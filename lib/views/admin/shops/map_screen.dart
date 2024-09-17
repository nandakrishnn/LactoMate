import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lactomate/views/admin/shops/bloc_add_shop/shop_details_addition_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class SearchMapScreen extends StatefulWidget {
  final Function(Map<String, dynamic>?) onLocationSelected;

  SearchMapScreen({required this.onLocationSelected});
  @override
  _SearchMapScreenState createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  MapboxMapController? mapController;
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchSuggestions = [];
  Map<String, dynamic>? selectedLocation;
  Symbol? locationMarker;
  Symbol? locationLabel;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  // Fetch autocomplete suggestions from Mapbox Places API
  void _searchAutoComplete(String query) async {
    if (query.isNotEmpty) {
      try {
        final suggestions = await fetchAutoCompleteSuggestions(query);
        setState(() {
          searchSuggestions = suggestions;
        });
      } catch (e) {
        print('Error fetching suggestions: $e');
      }
    }
  }

  // Automatically save and display the selected location in the ListTile
  void _onSuggestionSelected(dynamic suggestion) async {
    final placeName = suggestion['place_name'];
    final coordinates = suggestion['geometry']['coordinates'];

    setState(() {
      searchController.text = placeName;
      searchSuggestions.clear(); // Clear the suggestions after selection

      // Store only the latest selected location
      selectedLocation = {
        'latitude': coordinates[1],
        'longitude': coordinates[0],
        'placeName': placeName,
      };

      // Add BLoC events for saving the location details
      context.read<ShopDetailsAdditionBloc>().add(ShopLatitudeChanges(coordinates[1]));
      context.read<ShopDetailsAdditionBloc>().add(ShopLongitudeChanges(coordinates[0]));
      context.read<ShopDetailsAdditionBloc>().add(ShopAdressChnages(placeName));
    });

    // Animate the map to the selected location
    mapController?.animateCamera(CameraUpdate.newLatLng(
      LatLng(coordinates[1], coordinates[0]),
    ));

    // Add a marker at the selected location
    await _addMarker(LatLng(coordinates[1], coordinates[0]), placeName);
  }

  Future<void> _addMarker(LatLng coordinates, String placeName) async {
    if (mapController == null) return;

    // Remove previous marker if it exists
    if (locationMarker != null) {
      mapController?.removeSymbol(locationMarker!);
    }

    locationMarker = await mapController?.addSymbol(SymbolOptions(
      geometry: coordinates,
      iconImage: "marker-15",
      iconSize: 1.5,
    ));

    // Add a label for the place name near the marker
    if (locationLabel != null) {
      mapController?.removeSymbol(locationLabel!);
    }
    locationLabel = await mapController?.addSymbol(SymbolOptions(
      geometry: LatLng(coordinates.latitude + 0.001, coordinates.longitude),
      textField: placeName,
      textSize: 12,
      textAnchor: "top",
    ));
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Map View
        ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: MapboxMap(
            compassEnabled: true,
            accessToken:
                "pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg",
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(10.8505, 76.2711), // Kerala's coordinates
              zoom: 10,
            ),
            styleString: MapboxStyles.MAPBOX_STREETS,
          ),
        ),

        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: _searchAutoComplete,
                        decoration: InputDecoration(
                          hintText: 'Search for a location',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (searchController.text.isEmpty) {
                          print('Please enter a location');
                        }
                      },
                      icon: Icon(Icons.search, color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Display suggestions in a dropdown list above the search bar
              if (searchSuggestions.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = searchSuggestions[index];
                      return ListTile(
                        title: Text(suggestion['place_name']),
                        onTap: () => _onSuggestionSelected(suggestion),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),

        // Display the selected location as text
        Positioned(
          bottom: 35,
          left: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              selectedLocation != null
                  ? "Selected Place: ${selectedLocation!['placeName']}"
                  : ".No location selected",
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
       
       
       }


  // Fetch suggestions from Mapbox Places API
  Future<List<dynamic>> fetchAutoCompleteSuggestions(String query) async {
    final apiUrl =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg&autocomplete=true&limit=5';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['features'];
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
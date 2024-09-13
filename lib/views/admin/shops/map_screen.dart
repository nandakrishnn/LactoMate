import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lactomate/utils/constants.dart';
import 'package:lactomate/widgets/login_button.dart';
import 'package:lactomate/widgets/textformfeild.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class SearchMapScreen extends StatefulWidget {
  @override
  _SearchMapScreenState createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  MapboxMapController? mapController;
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchSuggestions = [];
  List<Map<String, dynamic>> savedLocations = [];

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

  // Handle selecting a suggestion
  void _onSuggestionSelected(dynamic suggestion) async {
    final placeName = suggestion['place_name'];
    final coordinates = suggestion['geometry']['coordinates'];

    setState(() {
      searchController.text = placeName;
      searchSuggestions.clear(); // Clear suggestions after selecting
      selectedLocation = {
        'latitude': coordinates[1],
        'longitude': coordinates[0],
        'placeName': placeName,
      };
    });

    // Animate the map to the selected location
    mapController?.animateCamera(CameraUpdate.newLatLng(
      LatLng(coordinates[1], coordinates[0]),
    ));

    // Add a marker at the selected location
    await _addMarker(LatLng(coordinates[1], coordinates[0]), placeName);
  }

  // Add a marker at the specified coordinates
  Future<void> _addMarker(LatLng coordinates, String placeName) async {
    if (mapController == null) return;

    // Remove the previous marker if it exists
    if (locationMarker != null) {
      mapController?.removeSymbol(locationMarker!);
    }

    // Add a new marker at the selected location
    locationMarker = await mapController?.addSymbol(SymbolOptions(
      geometry: coordinates,
      iconImage: "marker-15", // Make sure the map style supports this icon
      iconSize: 1.5, // Adjust the size of the marker if necessary
    ));

    // Add a label for the place name near the marker
    if (locationLabel != null) {
      mapController?.removeSymbol(locationLabel!);
    }
    locationLabel = await mapController?.addSymbol(SymbolOptions(
      geometry: LatLng(coordinates.latitude + 0.001, coordinates.longitude), // Slight offset for label
      textField: placeName,
      textSize: 12,
      textAnchor: "top",
    ));
  }

  // Save the selected location
  void _saveLocation() {
    if (selectedLocation != null) {
      setState(() {
        savedLocations.add(selectedLocation!);
      });
    } else {
      print('No location to save');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Column(
        children: [
          Column(
            children: [
              
              CustomTextFeild(
                hinttext: 'Enter a location',
                obscure: false,
                controller: searchController,
                onChanged: _searchAutoComplete,
                sufixbutton: IconButton(
                    onPressed: () {
                      if (searchController.text.isEmpty) {
                        print('Please enter a location');
                      }
                    },
                    icon: Icon(Icons.search)),
              ),
              if (searchSuggestions.isNotEmpty)
                Container(
                  height: 150, // Set a max height for the list
                  child: ListView.builder(
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
          AppConstants.kheight30,
          Expanded(
            flex: 3,
            child: MapboxMap(
              accessToken:
                  "pk.eyJ1IjoibmFuZGFrcmlzaG5uIiwiYSI6ImNtMHpwZzkxcTA4eHoyaXF0cmU5Znh0bHYifQ.AxCRb6R-j52fETy4rq37cg",
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(10.8505, 76.2711), // Kerala's coordinates
                zoom: 10, // You can adjust the zoom level as needed
              ),
              styleString: MapboxStyles.MAPBOX_STREETS, // Ensure a style that supports markers
            ),
          ),
          // List of saved locations
          Expanded(
            child: ListView.builder(
              itemCount: savedLocations.length,
              itemBuilder: (context, index) {
                final location = savedLocations[index];
                return ListTile(
                  title: Text(
                      '${location['placeName']}: ${location['latitude']}, ${location['longitude']}'),
                );
              },
            ),
          ),
          if (selectedLocation != null)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: LoginContainer(content: 'Save Location',ontap: _saveLocation,),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DistributionChart extends StatefulWidget {
  const DistributionChart({super.key});

  @override
  State<DistributionChart> createState() => _DistributionChartState();
}

class _DistributionChartState extends State<DistributionChart> {
  late Future<List<SalesData>> futureData; // Future for holding chart data

  @override
  void initState() {
    super.initState();
    futureData = fetchChartData();
  }

  Future<List<SalesData>> fetchChartData() async {
    int totalShops = await getCollectionCount('ShopDetails');
    int totalDrivers = await getCollectionCount('DriverDetails');
    int totalShopsInRoutes = await getCollectionCount('RouteDetails');

    // Return the data in the format needed for the chart
    return [
      SalesData('Shops', totalShops.toDouble()),
      SalesData('Drivers', totalDrivers.toDouble()),
      SalesData('Shops in Routes', totalShopsInRoutes.toDouble()),
    ];
  }

  Future<int> getCollectionCount(String collectionName) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    return snapshot.size; // Returns the number of documents in the collection
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SalesData>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator()); // Show loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data')); // Handle errors
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available')); // Handle no data case
        } else {
          List<SalesData> data = snapshot.data!; // Data ready for the chart
          return SizedBox(
            height: 300, // Set the height of the chart
            child: SfCartesianChart(
              
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ), // X-axis as category
              series: [
                
                ColumnSeries<SalesData, String>(
                  color: AppColors.appcolorTeal,
                  dataSource: data,
                  xValueMapper: (SalesData sales, _) => sales.category, // Category on X axis
                  yValueMapper: (SalesData sales, _) => sales.value, // Value on Y axis
                  dataLabelSettings: const DataLabelSettings(isVisible: true), // Show data labels
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

// Data class to hold the chart data
class SalesData {
  SalesData(this.category, this.value);

  final String category;
  final double value;
}

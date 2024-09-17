import 'package:flutter/material.dart';
import 'package:lactomate/views/admin/routes/add_route_details.dart';
import 'package:lactomate/widgets/route_animations.dart';

class RoutesList extends StatelessWidget {
  const RoutesList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(createRoute(AddRouteDetails()));
      },child: Text('+'),),
    );
  }
}
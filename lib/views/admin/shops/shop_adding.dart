import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lactomate/services/shop_service.dart';
import 'package:lactomate/utils/colors.dart';
import 'package:lactomate/views/admin/shops/add_shop_details.dart';
import 'package:lactomate/views/admin/shops/bloc_get_shop/get_shop_details_bloc.dart';
import 'package:lactomate/views/admin/shops/listing_shop_container.dart';
import 'package:lactomate/widgets/route_animations.dart';

class ShopsList extends StatelessWidget {
  const ShopsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appcolorCream,
        title: Text('Shopdetails'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(AddShopDetails()));
        },
        child: Text(
          '+',
          style: TextStyle(color: AppColors.appcolorCream),
        ),
        backgroundColor: AppColors.appcolorBlack,
      ),
      backgroundColor: AppColors.appcolorCream,
      body: BlocProvider(
        create: (context) => GetShopDetailsBloc(ShopService())..add(FetchShopDetails()),
        child: BlocConsumer<GetShopDetailsBloc, GetShopDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetShopDetailsLoaded) {
              final data = state.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PaymentItem(
                    deliveryStamp: data[index]['DeliveryTimeStamp'],
                    data: data[index],
                    category: data[index]['ShopAdress'],
                    title: data[index]['ShopName'],
                    imageUrl: data[index]['ShopImage'],
                    amount: data[index]['PayLoad'],
                  ),
                );
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}

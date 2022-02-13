import 'package:client/data/models/dummy_data.dart';
import 'package:client/data/models/restaurant.dart';
import 'package:client/logic/cubit/collection_cubit.dart';
import 'package:client/utils/app_utils.dart';
import 'package:client/utils/dimensions.dart';
import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: height,
          child: Stack(
            children: [
              bgImage(height * 0.45, width, widget.restaurant.image),
              mask(height * 0.45, width),
              Positioned(
                  bottom: 0,
                  child: detailCard(widget.restaurant, height, width)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon:
                            const Icon(Icons.arrow_back, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mask(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget bgImage(double height, double width, String image) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Container detailCard(Restaurant restaurant, double height, double width) {
    List<Map<String, String>> cussineImagesList = DummyData().cussineList;
    SizedBox spacer = const SizedBox(height: 16);
    return Container(
      height: height * 0.65,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant.restaurantName,
                style: kTitle1.copyWith(fontWeight: FontWeight.bold)),
            Text(restaurant.time, style: kBody1),
            spacer,
            Text(restaurant.restaurantName + restaurantAbout,
                textAlign: TextAlign.justify,
                style: kBody1.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                )),
            spacer,
            Text(
              'Cuisine',
              style: kBody1.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: width * 0.42,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: cussineImagesList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PhysicalModel(
                          color: Colors.transparent,
                          elevation: 4,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: Container(
                            height: width * 0.3,
                            width: width * 0.3,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: Image.asset(
                                  cussineImagesList[index]['url'] ?? '',
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        cussineImagesList[index]['name'] ?? '',
                        style: kBody2,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

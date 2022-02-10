import 'dart:developer';

import 'package:client/data/models/restaurant.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/ui/common_widgets/shimmer/loading_screen.dart';
import 'package:client/ui/screens/home_screen/components/restaurant_tile.dart';
import 'package:client/utils/dimensions.dart';
import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<String> restaurantSearch = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantCubit>(context).fetchAllRestaurants();
  }

  @override
  void dispose() {
    restaurantSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);
    Widget spacer = const SizedBox(height: 16);
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, state) {
            log('Restaurant Screen State Rebuild');
            if (state is RestaurantLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Search',
                          style: kTitle0.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      spacer,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: searchWidget(width),
                      ),
                      spacer,
                      restaurantListView(state)
                    ]),
              );
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }

  Widget searchWidget(double width) {
    return SizedBox(
      width: width * 0.9,
      child: TextField(
        maxLines: null,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          errorText: null,
          icon: Icon(Icons.search),
          hintText: "Restaurant search eg. Osakaya Restaurant",
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        onChanged: (value) {
          restaurantSearch.value = value;
        },
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (restaurantSearch.value.length > 2) {}
        },
      ),
    );
  }

  Widget restaurantListView(RestaurantLoaded state) {
    return Scrollbar(
      interactive: true,
      thickness: 10,
      radius: const Radius.circular(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.restaurantsList.length,
        physics: const BouncingScrollPhysics(),
        primary: false,
        itemBuilder: (context, index) {
          Restaurant restaurant = state.restaurantsList[index];
          return RestaurantTile(restaurant: restaurant);
        },
      ),
    );
  }
}

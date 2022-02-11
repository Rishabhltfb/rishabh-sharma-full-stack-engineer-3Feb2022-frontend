import 'dart:developer';

import 'package:client/data/models/restaurant.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/ui/common_widgets/shimmer/loading_screen.dart';
import 'package:client/ui/screens/home_screen/components/restaurant_card.dart';
import 'package:client/ui/screens/home_screen/components/restaurant_tile.dart';
import 'package:client/ui/screens/restaurant_screen/restaurant_screen.dart';
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
  ValueNotifier<bool> searchError = ValueNotifier(false);
  ValueNotifier<bool> showFloatingActionButton = ValueNotifier(false);
  List<Restaurant> allRestaurants = [];
  ValueNotifier<List<Restaurant>> recentSearchedRestaurantsList =
      ValueNotifier([]);
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RestaurantCubit>(context).fetchAllRestaurants();
    _scrollController.addListener(() {
      if (_scrollController.offset > 10 && !showFloatingActionButton.value) {
        showFloatingActionButton.value = true;
      }
      if (_scrollController.offset < 10 && showFloatingActionButton.value) {
        showFloatingActionButton.value = false;
      }
    });
  }

  @override
  void dispose() {
    restaurantSearch.dispose();
    searchError.dispose();
    showFloatingActionButton.dispose();
    _scrollController.dispose();
    recentSearchedRestaurantsList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
          valueListenable: showFloatingActionButton,
          builder: (context, value, child) {
            if (showFloatingActionButton.value) {
              return FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(0.0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn);
                },
                backgroundColor: Colors.orange,
                child: const Icon(Icons.arrow_upward_outlined),
              );
            }
            return const SizedBox();
          }),
      body: homeBody(),
    );
  }

  Widget searchWidget(double width) {
    return SizedBox(
      width: width * 0.9,
      child: ValueListenableBuilder(
        valueListenable: searchError,
        builder: (context, value, child) => TextField(
          controller: _searchTextController,
          maxLines: null,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            errorText:
                searchError.value ? 'Search length should be  > 3' : null,
            icon: const Icon(Icons.search),
            hintText: "Restaurant search eg. Osakaya Restaurant",
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
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
            if (restaurantSearch.value.length > 2) {
              searchError.value = false;
              BlocProvider.of<RestaurantCubit>(context)
                  .filterByRestaurantName(restaurantSearch.value);
            } else {
              searchError.value = true;
            }
          },
        ),
      ),
    );
  }

  Widget restaurantListView(List<Restaurant> restaurantsList) {
    return Scrollbar(
      interactive: true,
      thickness: 10,
      radius: const Radius.circular(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: restaurantsList.length,
        physics: const BouncingScrollPhysics(),
        primary: false,
        itemBuilder: (context, index) {
          Restaurant restaurant = restaurantsList[index];
          return RestaurantTile(
            restaurant: restaurant,
            onTap: () {
              recentSearchedRestaurantsList.value =
                  List.from(recentSearchedRestaurantsList.value)
                    ..add(restaurant);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return RestaurantScreen(restaurant: restaurant);
                },
              ));
            },
          );
        },
      ),
    );
  }

  Widget clearFilter() {
    return Center(
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<RestaurantCubit>(context)
              .resetFilter(allRestaurants, recentSearchedRestaurantsList.value);
          _searchTextController.text = '';
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Clear Filter'),
              SizedBox(width: 5),
              Icon(Icons.clear),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeBody() {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);
    Widget spacer = const SizedBox(height: 16);
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          log('Restaurant Screen State Rebuild');
          if ((state is RestaurantLoaded) ||
              (state is RestaurantFilterApplied)) {
            List<Restaurant> restaurantsList = [];
            if (state is RestaurantLoaded) {
              restaurantsList = state.restaurantsList;
              allRestaurants = restaurantsList;
            }
            if (state is RestaurantFilterApplied) {
              restaurantsList = state.filteredRestaurantsList;
            }
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
                    (recentSearchedRestaurantsList.value.isNotEmpty)
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Recent Searches',
                              style:
                                  kTitle2.copyWith(fontWeight: FontWeight.bold),
                            ),
                          )
                        : spacer,
                    ValueListenableBuilder(
                      valueListenable: recentSearchedRestaurantsList,
                      builder: (context, value, child) {
                        if (recentSearchedRestaurantsList.value.isNotEmpty) {
                          return recentSearchListView(height, width);
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    (state is RestaurantLoaded)
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Restaurants around you',
                              style:
                                  kTitle2.copyWith(fontWeight: FontWeight.bold),
                            ),
                          )
                        : spacer,
                    (state is RestaurantFilterApplied)
                        ? clearFilter()
                        : const SizedBox(),
                    restaurantListView(restaurantsList)
                  ]),
            );
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }

  Widget recentSearchListView(double height, double width) {
    return SizedBox(
      height: height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: recentSearchedRestaurantsList.value.length,
        itemBuilder: (context, index) {
          Restaurant restaurant = recentSearchedRestaurantsList.value[index];
          return RestaurantCard(
            restaurant: restaurant,
            onTap: () {},
          );
        },
      ),
    );
  }
}

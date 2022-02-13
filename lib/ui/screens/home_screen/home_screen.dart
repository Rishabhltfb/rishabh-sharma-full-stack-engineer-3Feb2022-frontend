import 'dart:developer';

import 'package:client/data/models/restaurant.dart';
import 'package:client/logic/cubit/auth_cubit.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/ui/common_widgets/restaurant_listview.dart';
import 'package:client/ui/common_widgets/shimmer/loading_screen.dart';
import 'package:client/ui/screens/collection_screen/collection_screen.dart';
import 'package:client/ui/screens/home_screen/components/clear_filter_widget.dart';
import 'package:client/ui/screens/home_screen/components/restaurant_card.dart';
import 'package:client/ui/screens/home_screen/components/restaurant_tile.dart';
import 'package:client/ui/screens/home_screen/components/search_widget.dart';
import 'package:client/ui/screens/profile_screen/profile_screen.dart';
import 'package:client/ui/screens/restaurant_screen/restaurant_screen.dart';
import 'package:client/utils/color_pallet.dart';
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
  ValueNotifier<bool> listLoading = ValueNotifier(false);
  ValueNotifier<int> paginationPage = ValueNotifier(1);
  List<Restaurant> allRestaurants = [];
  ValueNotifier<List<Restaurant>> recentSearchedRestaurantsList =
      ValueNotifier([]);
  final ScrollController _scrollController = ScrollController();
  late RestaurantCubit restaurantCubit;
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    restaurantCubit = BlocProvider.of<RestaurantCubit>(context);
    _scrollController.addListener(showFloating);
    _scrollController.addListener(pagination);
  }

  void pagination() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !listLoading.value) {
      log('Fetch Pagination data for page ${(paginationPage.value + 1).toString()}');
      listLoading.value = true;
      restaurantCubit.fetchRestaurants(
          paginationPage.value + 1, recentSearchedRestaurantsList.value);
      paginationPage.value = paginationPage.value + 1;
      Future.delayed(
          const Duration(seconds: 1), () => listLoading.value = false);
    }
  }

  @override
  void dispose() {
    restaurantSearch.dispose();
    searchError.dispose();
    showFloatingActionButton.dispose();
    _scrollController.dispose();
    listLoading.dispose();
    recentSearchedRestaurantsList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);
    Widget spacer = const SizedBox(height: 16);
    return SafeArea(
      child: Scaffold(
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
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.arrow_upward_outlined),
                );
              }
              return const SizedBox();
            }),
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<RestaurantCubit, RestaurantState>(
            builder: (context, state) {
              log('State Chnaged: $state');
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
                        const SizedBox(height: 30),
                        headerWidget(),
                        spacer,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SearchWidget(
                              searchError: searchError,
                              searchTextController: _searchTextController,
                              scaffoldContext: context),
                        ),
                        spacer,
                        (state is RestaurantLoaded)
                            ? ValueListenableBuilder(
                                valueListenable: recentSearchedRestaurantsList,
                                builder: (context, value, child) {
                                  if (recentSearchedRestaurantsList
                                      .value.isNotEmpty) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              'Recent search',
                                              style: kTitle2.copyWith(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          recentSearchListView(height, width)
                                        ]);
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )
                            : const SizedBox(),
                        (state is RestaurantLoaded)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Restaurants around you',
                                  style: kTitle2.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : spacer,
                        (state is RestaurantFilterApplied)
                            ? ClearFilterWidget(onTap: () {
                                restaurantCubit.resetFilter(allRestaurants,
                                    recentSearchedRestaurantsList.value);
                                _searchTextController.text = '';
                              })
                            : const SizedBox(),
                        RestaurantListView(
                          restaurantsList: restaurantsList,
                          recentSearchedRestaurantsList:
                              recentSearchedRestaurantsList,
                        ),
                        ValueListenableBuilder(
                          valueListenable: listLoading,
                          builder: (context, value, child) => listLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black),
                                )
                              : const SizedBox(),
                        )
                      ]),
                );
              } else {
                return const LoadingScreen();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget recentSearchListView(double height, double width) {
    return SizedBox(
      height: height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: recentSearchedRestaurantsList.value.length,
        itemBuilder: (context, index) {
          Restaurant restaurant = recentSearchedRestaurantsList.value[index];
          return RestaurantCard(
            restaurant: restaurant,
            onTap: () {
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

  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search',
            style: kTitle0.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              OutlinedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, CollectionScreen.route),
                  child: Text(
                    'My Collection',
                    style: kBody1.copyWith(fontWeight: FontWeight.bold),
                  )),
              // GestureDetector(
              //   onTap: () {

              //   },
              //   child: const CircleAvatar(
              //     backgroundColor: Colors.black,
              //     radius: 18,
              //     child: Icon(
              //       Icons.favorite_rounded,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).logoutUser();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 18,
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showFloating() {
    if (_scrollController.offset > 10 && !showFloatingActionButton.value) {
      showFloatingActionButton.value = true;
    }
    if (_scrollController.offset < 10 && showFloatingActionButton.value) {
      showFloatingActionButton.value = false;
    }
  }
}

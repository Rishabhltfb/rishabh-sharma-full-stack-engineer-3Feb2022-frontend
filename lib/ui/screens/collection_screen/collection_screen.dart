import 'package:client/data/models/collection.dart';
import 'package:client/logic/cubit/collection_cubit.dart';
import 'package:client/logic/cubit/user_cubit.dart';
import 'package:client/ui/common_widgets/message_widget.dart';
import 'package:client/ui/common_widgets/restaurant_listview.dart';
import 'package:client/ui/common_widgets/shimmer/loading_screen.dart';
import 'package:client/utils/assets.dart';
import 'package:client/utils/dimensions.dart';
import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionScreen extends StatefulWidget {
  static const String route = '/collection';
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late CollectionCubit collectionCubit;
  late UserCubit userCubit;

  @override
  void initState() {
    super.initState();
    collectionCubit = BlocProvider.of<CollectionCubit>(context);
    userCubit = BlocProvider.of<UserCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);
    SizedBox spacer = const SizedBox(height: 16);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: BlocBuilder<CollectionCubit, CollectionState>(
          builder: (context, state) {
            if (state is CollectionLoaded) {
              if (state.collectionsList.isEmpty) {
                return addCollectionButton(context);
              }
            }
            return const SizedBox();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
              Text(
                'My Collections',
                style: kTitle0.copyWith(fontWeight: FontWeight.bold),
              ),
              spacer,
              BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  if (state is CollectionLoaded) {
                    List<Collection> collectionList = state.collectionsList;

                    if (collectionList.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: height * 0.1),
                          MessageWidget(
                            height: height * 0.35,
                            svgPicture: RestaurantAssets.noData,
                            message: 'It\'s Empty!',
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                      itemCount: collectionList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        Collection collection = collectionList[index];
                        return ExpansionTile(
                          title: Text(collection.name,
                              style: kTitle2.copyWith(
                                  fontWeight: FontWeight.w600)),
                          collapsedBackgroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          children: [
                            RestaurantListView(
                                restaurantsList: collection.restaurants)
                          ],
                        );
                      },
                    );
                  } else if (state is CollectionError) {
                    return Column(
                      children: [
                        SizedBox(height: height * 0.1),
                        MessageWidget(
                          height: height * 0.35,
                          svgPicture: RestaurantAssets.error,
                          message: 'Oops!',
                        ),
                      ],
                    );
                  } else {
                    return const LoadingScreen();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton addCollectionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: showSnackBar,
      child: const Icon(Icons.add),
    );
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 1),
        elevation: 2,
        content: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Functionality not implemented',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

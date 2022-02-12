import 'package:client/data/models/collection.dart';
import 'package:client/logic/cubit/collection_cubit.dart';
import 'package:client/ui/common_widgets/restaurant_listview.dart';
import 'package:client/ui/common_widgets/shimmer/loading_screen.dart';
import 'package:client/utils/dimensions.dart';
import 'package:client/utils/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionScreen extends StatelessWidget {
  static const String route = '/collection';
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = getDeviceHeight(context);
    double width = getDeviceWidth(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.08),
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
            BlocBuilder<CollectionCubit, CollectionState>(
              builder: (context, state) {
                if (state is CollectionLoaded) {
                  List<Collection> collectionList = state.collectionsList;
                  return ListView.builder(
                    itemCount: collectionList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Collection collection = collectionList[index];
                      return ExpansionTile(
                        title: Text(collection.name, style: kTitle2),
                        children: [
                          RestaurantListView(
                              restaurantsList: collection.restaurants)
                        ],
                      );
                    },
                  );
                } else if (state is CollectionError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                } else {
                  return const LoadingScreen();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

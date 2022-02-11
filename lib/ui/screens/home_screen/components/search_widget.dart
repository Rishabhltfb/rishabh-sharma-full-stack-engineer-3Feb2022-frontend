import 'dart:developer';

import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class SearchWidget extends StatelessWidget {
  final ValueNotifier<bool> searchError;
  final TextEditingController searchTextController;
  final Function(int initialTime, int finalTime) getTime;
  const SearchWidget({
    Key? key,
    required this.searchError,
    required this.searchTextController,
    required this.getTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = getDeviceWidth(context);
    return SizedBox(
      width: width * 0.9,
      child: ValueListenableBuilder(
        valueListenable: searchError,
        builder: (context, value, child) => TextField(
          controller: searchTextController,
          maxLines: null,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            errorText:
                searchError.value ? 'Search length should be  > 3' : null,
            icon: const Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: () {
                  showCustomTimePicker(
                      context: context,
                      cancelText: 'Cancel',
                      confirmText: 'Next',
                      helpText: 'Pick Schedule time',
                      onFailValidation: (context) =>
                          log('Unavailable selection'),
                      initialTime: TimeOfDay(hour: 0, minute: 0),
                      selectableTimePredicate: (time) => true).then((time) {
                    if (time != null) {
                      int selectedTime = time.hour * 100 + time.minute;
                    }
                  });
                },
                icon: const Icon(Icons.calendar_today_outlined)),
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
          // onChanged: (value) {
          //   searchTextController.text = value;
          // },
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (searchTextController.text.length > 2) {
              searchError.value = false;
              BlocProvider.of<RestaurantCubit>(context)
                  .filterByRestaurantName(searchTextController.text);
            } else {
              searchError.value = true;
            }
          },
        ),
      ),
    );
  }
}

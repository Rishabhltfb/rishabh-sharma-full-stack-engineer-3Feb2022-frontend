import 'dart:developer';

import 'package:client/data/models/dummy_data.dart';
import 'package:client/logic/cubit/restaurant_cubit.dart';
import 'package:client/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class SearchWidget extends StatelessWidget {
  final ValueNotifier<bool> searchError;
  final TextEditingController searchTextController;
  final BuildContext scaffoldContext;

  const SearchWidget({
    Key? key,
    required this.searchError,
    required this.searchTextController,
    required this.scaffoldContext,
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
                onPressed: () async {
                  int day = await getDay(context);
                  if (day != -1) {
                    int startTime =
                        await timePicker(context, 'Pick Starting time');
                    if (startTime != -1) {
                      int endTime =
                          await timePicker(context, 'Pick Ending time');

                      if (endTime != -1) {
                        if (startTime < endTime) {
                          BlocProvider.of<RestaurantCubit>(context)
                              .filterByDayTime(DummyData().weekdays[day - 1],
                                  startTime, endTime);
                        } else {
                          showSnackBar();
                        }
                      }
                    }
                  }
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

  Future<int> getDay(BuildContext context) async {
    DateTime? day = await showDatePicker(
      context: context,
      helpText: 'Pick Dining Date',
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (day != null) {
      return day.weekday;
    } else {
      return -1;
    }
  }

  Future<int> timePicker(BuildContext context, String helpText) async {
    TimeOfDay? time = await showCustomTimePicker(
        context: context,
        cancelText: 'Cancel',
        confirmText: 'Next',
        helpText: helpText,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        onFailValidation: (context) => log('Unavailable selection'),
        initialTime: const TimeOfDay(hour: 0, minute: 0),
        selectableTimePredicate: (time) => true);
    if (time != null) {
      int selectedTime = time.hour * 100 + time.minute;
      return selectedTime;
    } else {
      return -1;
    }
  }

  void showSnackBar() {
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 1),
        elevation: 2,
        content: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Invalid Time Picked',
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

import 'package:flutter/material.dart';

class ClearFilterWidget extends StatelessWidget {
  final Function() onTap;
  const ClearFilterWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
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
}

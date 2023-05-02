import 'package:flutter/material.dart';

class LocationsListTile extends StatelessWidget {
  const LocationsListTile(
      {super.key, required this.location, required this.onPress});

  final String location;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPress,
          horizontalTitleGap: 0,
          title: Text(
            location,
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: Theme.of(context).cardColor,
        )
      ],
    );
  }
}

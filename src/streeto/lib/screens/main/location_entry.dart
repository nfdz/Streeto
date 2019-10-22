import 'package:flutter/material.dart';
import 'package:streeto/common/format_helper.dart';
import 'package:streeto/model/location_suggestion.dart';

class LocationEntry extends StatelessWidget {
  final LocationSuggestion location;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  LocationEntry({
    @required this.location,
    @required this.padding,
    @required this.onPressed,
  }) : super(key: Key(location.locationId));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Card(
        child: ListTile(
          title: Text(location.label, key: Key("main.location_entry.label")),
          subtitle: Text(FormatHelper.formatDistance(location.distanceInMeters)),
          onTap: onPressed,
        ),
      ),
    );
  }
}

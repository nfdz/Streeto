import 'package:flutter/material.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/dimensions.dart';
import 'package:streeto/common/texts/main_texts.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  SearchBox({@required this.onChanged}) : super(key: Key("main.search_box"));

  @override
  Widget build(BuildContext context) {
    ScreenType screen = getScreenType(context);
    return Padding(
      padding: dimenMainSearchBoxPadding(screen),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: kAccentColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(45.0),
          ),
        ),
        child: TextField(
          style: kContentTextStyle,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
            hintText: MainTexts.searchHint(context),
            hintStyle: kContentTextStyle.copyWith(color: kHintColor),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: kAccentColor,
              size: 26,
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/dimensions.dart';

class LoadingBounce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(size: dimenLoadingSize(getScreenType(context)), color: kAccentColor);
  }
}

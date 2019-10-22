import 'package:flutter/material.dart';
import 'package:streeto/common/constants.dart';
import 'package:streeto/common/dimensions.dart';
import 'package:transparent_image/transparent_image.dart';

class AlertContent extends StatelessWidget {
  final String message;
  final String btnText;
  final String auxBtnText;
  final String imageAsset;
  final VoidCallback onPressed;
  final VoidCallback onPressedAux;
  AlertContent({
    @required this.message,
    @required this.imageAsset,
    this.btnText,
    this.onPressed,
    this.auxBtnText,
    this.onPressedAux,
  });

  @override
  Widget build(BuildContext context) {
    final screen = getScreenType(context);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: dimenAlertContentPadding(screen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(imageAsset),
                fit: BoxFit.contain,
                fadeInDuration: kFadeImageDuration,
                width: dimenAlertContentImageSize(screen),
                height: dimenAlertContentImageSize(screen),
              ),
              Padding(
                padding: dimenAlertContentTextPadding(screen),
                child: Text(
                  message,
                  style: kContentTextStyle.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              if (btnText?.isNotEmpty == true)
                OutlineButton(
                  child: Text(btnText),
                  onPressed: this.onPressed,
                ),
              if (auxBtnText?.isNotEmpty == true)
                OutlineButton(
                  child: Text(auxBtnText),
                  onPressed: this.onPressedAux,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

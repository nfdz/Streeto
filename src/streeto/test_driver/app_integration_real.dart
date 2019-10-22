import 'package:flutter_driver/driver_extension.dart';
import 'package:streeto/main.dart' as app;

void main() {
  enableFlutterDriverExtension();
  app.main(mockServices: false, mockTexts: true, mockLocation: true);
}

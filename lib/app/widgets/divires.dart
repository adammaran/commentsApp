import 'package:flutter/material.dart';

class VerticalDividerWidget {
  Widget customDivider({double? width, double? thickness, Color? color}) =>
      VerticalDivider(
        width: width ?? 1,
        thickness: thickness ?? 1,
        color: color ?? Colors.grey,
      );

  static Widget showDefault() =>
      VerticalDivider(width: 1, thickness: 1, color: Colors.grey);
}

class HorizontalDivider {
  Widget customDivider({double? height, double? thickness, Color? color}) => Divider(
        height: height ?? 1,
        thickness: thickness ?? 1,
        color: color ?? Colors.grey,
      );

  static Widget showDefault() =>
      Divider(height: 1, thickness: 1, color: Colors.grey);
}

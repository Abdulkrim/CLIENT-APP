import 'package:flutter/material.dart';

class MessageBorder extends ShapeBorder {
  const MessageBorder();

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 10));

    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(24)))
      ..moveTo(rect.bottomCenter.dx, rect.bottomCenter.dy)
      ..relativeLineTo(15, 20)
      ..relativeLineTo(10, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only(bottom: 10);
}

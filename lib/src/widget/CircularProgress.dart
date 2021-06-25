import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
Widget circularProgress({
  Color progressColor = const Color(0xFF1E88E5),
}) {
  return SpinKitCircle(
    color: progressColor,
  );
}
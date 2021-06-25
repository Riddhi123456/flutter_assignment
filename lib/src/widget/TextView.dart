import 'package:flutter/material.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Dimen.dart';

Widget TextView({
  EdgeInsetsGeometry margin = const EdgeInsets.all(0),
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  String title = '',
  double fontSize = Dimen.txtSize13px,
  Color fontColor = CommonColor.txtColorGray,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.left,
  Color containerBg = CommonColor.transparent,
  double width = null,
  TextDecoration textDecoration = TextDecoration.none,
  Alignment alignment = null,
  int maxLine = 1,
  TextOverflow overflow = TextOverflow.visible,
}) {
  return title != null && title.isNotEmpty
      ? Container(
          margin: margin,
          width: width,
          color: containerBg,
          alignment: alignment,
          child: Padding(
              padding: padding,
              child: Text(
                title,
                overflow: overflow,
                maxLines: maxLine,
                style: TextStyle(
                  decoration: textDecoration,
                  fontSize: fontSize,
                  color: fontColor,
                  fontStyle: fontStyle,
                  fontWeight: fontWeight,
                ),
                textAlign: textAlign,
              )),
        )
      : Container();
}

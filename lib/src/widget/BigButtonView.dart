import 'package:flutter/material.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Dimen.dart';
import 'package:flutter_task/src/widget/TextView.dart';

Widget bigButtonView({
  bool isEnabled = false,
  String label = '',
  double labelSize = Dimen.txtSize18px,
  Color labelColor = CommonColor.txtColorWhite,
  Color enableColor = CommonColor.btnEnableBg,
  Color disableColor = CommonColor.btnDisableBg,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.normal,
  EdgeInsetsGeometry margin = const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
  EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
  VoidCallback onClick,
  double elevation = 2,
  Color stockColor = CommonColor.transparent,
  double minWidth = double.infinity,
  int maxLine = 1,
  double cornerRadius = 2,
  TextAlign textAlign = TextAlign.center,
}) {
  return Container(
    margin: margin,
    child: MaterialButton(
      padding: padding,
      child: TextView(
          title: label,
          maxLine: maxLine,
          fontSize: labelSize,
          textAlign: textAlign,
          fontColor: labelColor,
          fontWeight: fontWeight,
          fontStyle: fontStyle),
      elevation: elevation,
      minWidth: minWidth,
      onPressed: isEnabled ? onClick : null,
    ),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isEnabled ? enableColor : disableColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        border: Border.all(color: stockColor)),
  );
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Dimen.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/utils/Utils.dart';
import 'package:flutter_task/src/widget/ImageViewAssets.dart';
import 'package:flutter_task/src/widget/TextView.dart';


Future<File> pickImageFromDeviceBottomSheet(BuildContext context,
    {String filename}) async {
  Future<File> s = showModalBottomSheet<File>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextView(
                fontColor: CommonColor.txtColorDark,
                title: "Add File",
                fontSize: Dimen.txtSize15px,
                margin: EdgeInsets.only(left: 20, top: 28, bottom: 10)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: TextView(
                  title: Strings.take_photo,
                  fontColor: CommonColor.txtColorDark,
                  fontSize: Dimen.txtSize15px),
              leading: imageViewAsset(
                  imagePath: 'assets/images/camera.png', margin: EdgeInsets.only(left: 20, top: 3)),
              onTap: () async {
                chooseFileFromCamera(filename: filename).then((value) {
                  Navigator.of(context).pop(value);
                });
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: TextView(
                  title: Strings.choose_from_gallery,
                  fontColor: CommonColor.txtColorDark,
                  fontSize: Dimen.txtSize15px),
              leading: imageViewAsset(
                  imagePath: 'assets/images/gallery.png',
                  margin: EdgeInsets.only(left: 20, top: 3)),
              onTap: () async {
                chooseFile().then((value) {
                    Navigator.of(context).pop(value);
                  });

              },
            ),
            Container(
              margin: EdgeInsets.all(10),
            )
          ],
        );
      });
  return s;
}

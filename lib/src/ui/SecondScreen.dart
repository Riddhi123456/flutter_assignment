import 'package:flutter/material.dart';
import 'package:flutter_task/src/base/ScreenState.dart';
import 'package:flutter_task/src/listener/BaseResponceListener.dart';
import 'package:flutter_task/src/models/PhotoModel.dart';
import 'package:flutter_task/src/providers/PhotoProvider.dart';
import 'package:flutter_task/src/repository/RestRequest.dart';
import 'package:flutter_task/src/resources/CommonColor.dart';
import 'package:flutter_task/src/resources/Dimen.dart';
import 'package:flutter_task/src/resources/Strings.dart';
import 'package:flutter_task/src/widget/TextView.dart';
import 'package:flutter_task/src/widget/ToolBar.dart';
import 'package:provider/provider.dart';

class SecondScreen extends ScreenState {
  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return Container(
      color: CommonColor.white,
      child: Consumer<PhotoProvider>(
        builder: (context, model, child) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              PhotoModel photoModel = model.list.elementAt(index);
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextView(
                          title: photoModel.authorName,
                          fontColor: CommonColor.txtColorDark,
                          fontSize: Dimen.txtSize18px,
                          textAlign: TextAlign.center,
                          maxLine: 3,
                          overflow: TextOverflow.ellipsis,
                          margin: EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration:
                              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                          child: Image.network(
                            photoModel.url,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                          )),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  AppBar getToolBar(BuildContext context) {
    // TODO: implement getToolBar
    return toolBar(
        toolBarTitle: Strings.photo_listing,
        toolBarBgColor: CommonColor.red,
        onClick: () {
          performBack(context);
        });
  }

  @override
  void onScreenReady(BuildContext context) {
    // TODO: implement onScreenReady
    RestRequest<PhotoProvider>(context: context).photoListApi(BaseResponseListener(
        onSuccess: (data) {
          context.read<PhotoProvider>().addPhotoData(data.list);
        },
        onError: (e) {
          showSnackBar(e);
        },
        isLive: true,
        showProgress: (b) {
          showProgress(b);
        }));
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:bloc_provider_test/components/customOffsetAnimation.dart';
import 'package:bloc_provider_test/main.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogManager {
  void pop() {
    ExtendedNavigator.root.pop();
  }

  static BuildContext get context => navKey.currentState.overlay.context;

    static void showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.6),
        builder: (context) =>
            SpinKitChasingDots(size: 60.0, color: Colors.white));
  }

  static Future bottomSheetManager({@required Widget child}) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: child,
                    )
                  ],
                ))));
  }

  static void showCustomToast(
      {@required String message, @required String buttonTitle}) {
    BotToast.showAnimationWidget(
        clickClose: true,
        duration: Duration(seconds: 3),
        wrapAnimation: (controller, cancel, child) => CustomOffsetAnimation(
              controller: controller,
              child: child,
            ),
        toastBuilder: (cancelFunc) => Align(
              alignment: Alignment(0, 0.98),
              child: Card(
                color: Color(0xea121212),
                elevation: 20.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          cancelFunc();
                        },
                        child: Text(buttonTitle,
                            style: TextStyle(color: Colors.green)),
                      )
                    ],
                  ),
                ),
              ),
            ),
        animationDuration: Duration(milliseconds: 200));
  }

  static Future<bool> showAlertDialog(
      {@required String title,
      @required String content,
      @required String buttonTitle}) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.6),
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(content), actions: [
              FlatButton(
                  onPressed: () {
                    ExtendedNavigator.root.pop(false);
                  },
                  child: Text("Cancel")),
              RaisedButton(
                onPressed: () {
                  ExtendedNavigator.root.pop(true);
                },
                child: Text(buttonTitle),
              ),
            ]));
  }
}

import 'package:Wellness/services/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:root_checker/root_checker.dart';

Future<void> showMessageDialog(
        BuildContext context, String title, Text msg) async =>
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: msg,
                  ),
                ),
                Container(
                  height: 50,
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                    child: Text(
                      AppLocalizations.translate("close"),
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

Future checkDeviceSecure(BuildContext context) async {
    bool isDeviceSecure = await RootChecker.isDeviceRooted;
    if (isDeviceSecure)
      showMessageDialog(context,
        AppLocalizations.translate("warning"),
        Text(
          AppLocalizations.translate("yourDeviceIsNotSecure"),
          textAlign: TextAlign.center,
        ),
      );
  }
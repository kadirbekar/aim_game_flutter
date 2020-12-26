import 'package:flutter/material.dart';

import 'label_text.dart';

class ShowCustomDialogBox {
  static Future showAlertDialogWithAction({BuildContext context,String title,String content,Function rightButtonOnPressed,}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          children: [
            Container(
              child: AlertDialog(
                content: LabelText(
                  text: content,
                ),
                title: Text(title),
                actions: [
                  OutlineButton(
                    onPressed: rightButtonOnPressed,
                    child: const LabelText(
                      text: 'Accept',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

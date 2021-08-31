import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void showBotToastText(text) {
  BotToast.showText(
    text: text.toString(),
    textStyle: TextStyle(color: Colors.white),
    duration: Duration(seconds: 3),
    clickClose: true,
    contentColor: Colors.black,
    contentPadding: EdgeInsets.fromLTRB(12, 12.5, 12, 12.5),
  );
}

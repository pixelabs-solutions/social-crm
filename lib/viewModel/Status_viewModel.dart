import 'package:flutter/material.dart';

import '../Model/Status.dart';


class TextStatusViewModel extends ChangeNotifier {
  StatusData _textStatus = StatusData(text: '', backgroundColorHex: '#FFFFFF');

  StatusData get textStatus => _textStatus;

  void setText(String text) {
    _textStatus = StatusData(text: text, backgroundColorHex: _textStatus.backgroundColorHex);
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    String colorHex = '#${color.value.toRadixString(16).substring(2)}';
    _textStatus = StatusData(text: _textStatus.text, backgroundColorHex: colorHex);
    notifyListeners();
  }
}

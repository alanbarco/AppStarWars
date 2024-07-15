import 'package:flutter/cupertino.dart';

class FilterProvider extends ChangeNotifier {
  String _value = 'Todos';

  String get value => _value;

  void setFilter(String filter) {
    _value = filter;
    notifyListeners();
  }
}	
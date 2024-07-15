import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier {
  int _currentPage = 1;

  int get currentPage => _currentPage;

  void incrementPage() {
    _currentPage += 1;
    notifyListeners();
  }
}	
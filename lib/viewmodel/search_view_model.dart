import 'package:flutter/cupertino.dart';

class SearchViewModel extends ChangeNotifier {
  bool isLoading = false;

  void searchLoading() {
    isLoading = true;
    notifyListeners();
  }

  void searchComplete() {
    isLoading = false;
    notifyListeners();
  }
}

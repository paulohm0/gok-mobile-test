import 'package:flutter/cupertino.dart';

class UsersViewModel extends ChangeNotifier {
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

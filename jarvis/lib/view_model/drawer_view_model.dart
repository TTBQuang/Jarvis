import 'package:flutter/foundation.dart';

class DrawerViewModel extends ValueNotifier<int> {
  DrawerViewModel(super.value);

  void selectTab(int index) {
    value = index;
  }
}

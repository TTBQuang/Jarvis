import 'package:flutter/foundation.dart';

class DrawerNotifier extends ValueNotifier<int> {
  DrawerNotifier(super.value);

  void selectTab(int index) {
    value = index;
  }
}

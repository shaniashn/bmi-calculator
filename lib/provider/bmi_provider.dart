import 'package:flutter/material.dart';

import '../models/bmi.dart';

class BMIProvider extends ChangeNotifier {
  List<History> bmiHistory = [];

  void addBMI(History bmi) {
    bmiHistory.add(bmi);
  }
}

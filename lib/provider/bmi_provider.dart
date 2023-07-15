import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../BMI.dart';

class BMIProvider extends ChangeNotifier {
  List<BMI> bmiHistory = [];

  void addBMI(BMI bmi){
    bmiHistory.add(bmi);
  }

  
}
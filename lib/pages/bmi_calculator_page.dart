import 'package:bmi_flutter_sabtu/models/bmi.dart';
import 'package:bmi_flutter_sabtu/pages/each_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/bmi_provider.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  List<double> bmiHistory = [];

  int currentindex = 0;
  String result = "";
  double height = 0;
  double weight = 0;
  String descBmi = "";
  double final_result = 0;

  int result_state = 0;

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color textColor;
    if (final_result == 0) {
      textColor = Color(0xfffafafa);
    } else {
      textColor = Colors.pink;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xfffafafa),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.settings,
        //       color: Colors.black,
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Man", Colors.blue, 0),
                  radioButton("Woman", Colors.pink, 1),
                ],
              ),
              const SizedBox(
                height: 55.0,
              ),
              const Text(
                "Your height (cm): ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: heightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Input your height",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                "Your weight (kg): ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Input your weight",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      height = double.parse(heightController.value.text);
                      weight = double.parse(weightController.value.text);
                    });
                    calculateBmi(height, weight);
                  },
                  child: const Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Your BMI is: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),

              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      result.isEmpty ? "0.0" : result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    descBmi,
                    style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    )
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Results(index: result_state))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: Container(
                        child: Text(
                          "More explanation",
                          style: TextStyle(color: textColor),),
                      ),
                      )
                    ,
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void calculateBmi(double height, double weight) {
    int index = 0;

    if (height == 0 || weight == 0) {
      result = "0";
    }

    double finalresult = weight / ((height / 100) * (height / 100));
    String bmi = finalresult.toStringAsFixed(2);

    String description = finalresult <= 18.5 ? "Underweight" : finalresult < 23
            ? "Normal"
            : finalresult < 25
                ? "Risk to overweight"
                : finalresult < 30
                    ? "Overweight"
                    : "Obese";

    if(description == "Underweight"){
      index = 0;
    }
    else if(description == "Normal"){
      index = 1;
    }
    else if(description == "Risk to overweight"){
      index = 2;
    }
    else if(description == "Overweight"){
      index = 3;
    }
    else if(description == "Obese"){
      index = 4;
    }

    final provider = Provider.of<BMIProvider>(context, listen: false);
    final bmiResult = History(
        height: height,
        weight: weight,
        bmi: finalresult,
        description: description);

    provider.addBMI(bmiResult);

    setState(() {
      result_state = index;
      descBmi = description;
      result = bmi;
      final_result = finalresult;
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: currentindex == index ? color : Colors.grey[200],
          ),
          onPressed: () {
            changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
              color: currentindex == index ? Colors.white : color,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

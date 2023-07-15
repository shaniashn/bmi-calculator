import 'package:flutter/material.dart';
import 'package:bmi_flutter_sabtu/provider/bmi_provider.dart';
import 'package:provider/provider.dart';
import 'package:bmi_flutter_sabtu/second_page.dart';

import 'BMI.dart';

void main() {
  runApp(HelloWorldApp());
}

class HelloWorldApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BMIProvider>(
          create: (context) => BMIProvider(),
        )
      ],
      child: MaterialApp(
          home: BmiCalculator(),

        ),
    );
  }
}

class BmiCalculator extends StatefulWidget {

  const BmiCalculator({super.key});
  //  BmiCalculator({Key key}) : super(key: key)

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  

  
  List<double> bmiHistory = [];

  int currentindex = 0;
  String result = "";
  double height = 0;
  double weight = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BMIProvider>(context);
    
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ],
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

              SizedBox(
                height: 100.0,
              ),

              Text(
                "Your height in cm: ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),

              SizedBox(
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

              SizedBox(
                height: 20.0,
              ),

              Text(
                "Your weight in kg: ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),

              SizedBox(
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

              SizedBox(
                height: 20.0,
              ),

              Container(
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
                  child: Text("Calculate", 
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              Container(
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

              SizedBox(
                height: 50.0,
              ),

              Container(
                  width: double.infinity,
                  child: Text(
                  "$result",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
              ),


              
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage())
                ),
                
                child: Text("See History")
              )
            ],
          ),
          ),
        ),
      ),
    );
  }

  void calculateBmi(double height, double weight){
    double finalresult = weight/(height*height/1000);
    String bmi = finalresult.toStringAsFixed(2);
    
    String description = finalresult <= 18.5 ? "underweight": finalresult < 23 ? "Normal" : finalresult < 25? "Risk to overweight" : finalresult < 30 ? "Overweight" : "Obese";

    setState(() {
      result = bmi;
    });

    final provider = Provider.of<BMIProvider>(context, listen: false);
    final bmiResult = BMI(height: height, weight: weight, bmi: finalresult, description: description);

    provider.addBMI(bmiResult);
  }

  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index){
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
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
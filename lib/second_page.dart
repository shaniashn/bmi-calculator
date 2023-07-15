import 'package:flutter/material.dart';
import 'package:bmi_flutter_sabtu/provider/bmi_provider.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BMIProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("History", 
        style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xfffafafa),
        iconTheme: IconThemeData(
          color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(children: 
               provider.bmiHistory.map(
                (bmi) => Text("weight: ${bmi.weight} - height: ${bmi.height}. so BMI is ${bmi.bmi}")
                ).toList()
              )
            ],
          ),
        )
      ),
    );
  }
}
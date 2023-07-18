import 'package:bmi_flutter_sabtu/models/bmi.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Results extends StatelessWidget {
  final List<ResultBmi> resultBmi = [
    ResultBmi(description: "Pay attention to your nutritional intake and consult a nutritionist to plan balanced and healthy meals and focus on gaining weight in a healthy way.", suggestion: "Here are foods suggestion: milk, smoothies, rice, avocado, cheese", category: "Underweight", links: "https://www.medicalnewstoday.com/, https://www.verywellfit.com/"),
    ResultBmi(description: "Maintain a balanced diet, stay active with regular exercise, and maintain a healthy lifestyle by getting enough sleep and managing stress well.", suggestion: "Here are foods suggestion: milk, smoothies, rice, avocado, cheese", category: "Normal", links: "https://www.medicalnewstoday.com/, https://www.verywellfit.com/"),
    ResultBmi(description: "Pay attention to calorie intake, reduce food portions, avoid foods high in fat and sugar, and increase physical activity with regular exercise to burn calories.", suggestion: "Here are foods suggestion: eggs, cheese, green vegetables, tomato, oatmeal", category: "Risk to overweight", links: "https://www.verywellfit.com/"),
    ResultBmi(description: "Pay attention to calorie intake, reduce food portions, avoid foods high in fat and sugar, and increase physical activity with regular exercise to burn calories.", suggestion: "Here are foods suggestion: salmon, shrimp, broccoli, cereals, ", category: "Overweight", links: "https://www.verywellfit.com/"),
    ResultBmi(description: "Consult a doctor or nutritionist to plan a safe weight loss program, focus on low-calorie nutritious foods, and increase physical activity with intensive exercise according to professional advice.", suggestion: "Here are foods suggestion: vegetables, fruits, nuts, healthful sources of protein (fish, poultry, beans), and plant oils", category: "Obese", links: "https://www.hsph.harvard.edu/obesity-prevention-source/obesity-causes/diet-and-weight/#:~:text=Choose%20minimally%20processed%2C%20whole%20foods,foods%2C%20such%20as%20fast%20food66")
  ];

  int index = 0;
  Results({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Description"),
      ),
      body: EachResult(resultBmi, index),
    );
  }
}

class EachResult extends StatefulWidget {
  final List<ResultBmi> rsult;
  final int index;

  const EachResult(this.rsult, this.index, {super.key});

  @override
  State<EachResult> createState() => _EachResult();
}

class _EachResult extends State<EachResult> {
  @override
  Widget build(BuildContext context) {
    int indx = widget.index;
    String desc = widget.rsult[indx].description;
    String suggest = widget.rsult[indx].suggestion;
    String ctgry = widget.rsult[indx].category;
    String links = widget.rsult[indx].links;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.pink[300]
              ),
              child: Center(
                child: Text(ctgry,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color:  Colors.white
              ),
              textAlign: TextAlign.center,
            ),
              )
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(desc,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal
              ),
            ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Text(suggest,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal
              ),
            ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Text(links),
            ),
          ]
          ),
        )
    );

  }
}
import 'package:bmi_flutter_sabtu/pages/bmi_calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:bmi_flutter_sabtu/provider/bmi_provider.dart';
import 'package:provider/provider.dart';
import 'package:bmi_flutter_sabtu/pages/history_page.dart';

void main() {
  runApp(const MyBMICalculator());
}

class MyBMICalculator extends StatelessWidget {
  const MyBMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BMIProvider>(
          create: (context) => BMIProvider(),
        ),
        // ChangeNotifierProvider<ResultProvider>(create: (context) => ResultProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var pages = [const BmiCalculator(), HistoryPage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [pages[index], bottomNavigationBar()],
      ),
    );
  }

  Align bottomNavigationBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              child: Column(
                children: [
                  Icon(
                    Icons.calculate_rounded,
                    color: index == 0 ? Colors.blueAccent : Colors.grey,
                    size: 32,
                  ),
                  Text(
                    "Calculator",
                    style: TextStyle(
                      color: index == 0 ? Colors.blueAccent : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              child: Column(
                children: [
                  Icon(
                    Icons.article_rounded,
                    color: index == 1 ? Colors.blueAccent : Colors.grey,
                    size: 32,
                  ),
                  Text(
                    "History",
                    style: TextStyle(
                      color: index == 1 ? Colors.blueAccent : Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

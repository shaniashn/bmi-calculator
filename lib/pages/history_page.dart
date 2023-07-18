import 'package:bmi_flutter_sabtu/models/bmi.dart';
import 'package:flutter/material.dart';
import 'package:bmi_flutter_sabtu/provider/bmi_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BMIProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xfffafafa),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: provider.bmiHistory.isEmpty
            ? SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  children: provider.bmiHistory
                      .map((bmi) => resultItem(bmi))
                      .toList()
                      .reversed
                      .toList(),
                ),
              ),
      ),
    );
  }

  Widget resultItem(History bmi) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      // color: const Color.fromARGB(255, 95, 33, 33),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      margin: const EdgeInsets.only(left: 24, right: 24, top: 8),
      decoration: BoxDecoration(
        color: Colors.pink[300],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bmi.description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${bmi.bmi.toStringAsFixed(2)} BMI",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "${bmi.height} cm • ${bmi.weight} kg",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

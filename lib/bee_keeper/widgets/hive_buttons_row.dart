import 'package:flutter/material.dart';
import 'package:flutter_application_2/bee_keeper/utils/constants.dart';
import '../pages/live_page.dart';
import '../pages/alerts_page.dart';
import '../pages/timely_data_page.dart';

class HiveButtonsRow extends StatelessWidget {
  final String hiveKey;
  const HiveButtonsRow({super.key, required this.hiveKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LivePage(hiveKey: hiveKey))),

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 3,
            ),
            child: Text(
              'Live',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage(hiveKey: hiveKey)),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(accentColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 3,
            ),
            child: Text(
              'Alerts',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width:2),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TimeAnalysis()),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 3,
            ),
            child: Text(
              'Time',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

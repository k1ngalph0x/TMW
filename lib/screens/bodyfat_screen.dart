import 'package:flutter/material.dart';
import 'dart:math';

class BodyFatCalculatorScreen extends StatefulWidget {
  @override
  _BodyFatCalculatorScreenState createState() =>
      _BodyFatCalculatorScreenState();
}

class _BodyFatCalculatorScreenState extends State<BodyFatCalculatorScreen> {
  double height = 170; // cm
  double waist = 80; // cm
  double neck = 35; // cm
  double hip = 90; // cm (for women)
  bool isMale = true;
  double bodyFatPercentage = 0;
  String bodyFatCategory = '';
  Color bodyFatColor = Colors.green;

  void calculateBodyFat() {
    double bodyFat;
    if (isMale) {
      bodyFat = 495 /
              (1.0324 -
                  0.19077 * log(waist - neck) / ln10 +
                  0.15456 * log(height) / ln10) -
          450;
    } else {
      bodyFat = 495 /
              (1.29579 -
                  0.35004 * log(waist + hip - neck) / ln10 +
                  0.22100 * log(height) / ln10) -
          450;
    }

    setState(() {
      bodyFatPercentage = bodyFat;
      if (isMale) {
        if (bodyFat < 6) {
          bodyFatCategory = 'Essential Fat';
          bodyFatColor = Colors.blue;
        } else if (bodyFat >= 6 && bodyFat < 14) {
          bodyFatCategory = 'Athletes';
          bodyFatColor = Colors.green;
        } else if (bodyFat >= 14 && bodyFat < 18) {
          bodyFatCategory = 'Fitness';
          bodyFatColor = Colors.lightGreen;
        } else if (bodyFat >= 18 && bodyFat < 25) {
          bodyFatCategory = 'Average';
          bodyFatColor = Colors.orange;
        } else {
          bodyFatCategory = 'Obese';
          bodyFatColor = Colors.red;
        }
      } else {
        if (bodyFat < 14) {
          bodyFatCategory = 'Essential Fat';
          bodyFatColor = Colors.blue;
        } else if (bodyFat >= 14 && bodyFat < 21) {
          bodyFatCategory = 'Athletes';
          bodyFatColor = Colors.green;
        } else if (bodyFat >= 21 && bodyFat < 25) {
          bodyFatCategory = 'Fitness';
          bodyFatColor = Colors.lightGreen;
        } else if (bodyFat >= 25 && bodyFat < 32) {
          bodyFatCategory = 'Average';
          bodyFatColor = Colors.orange;
        } else {
          bodyFatCategory = 'Obese';
          bodyFatColor = Colors.red;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    calculateBodyFat();
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label (${value.round()} cm)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          label: value.round().toString(),
          onChanged: (double value) {
            onChanged(value);
            calculateBodyFat();
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Fat Calculator'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Female'),
                Switch(
                  value: isMale,
                  onChanged: (value) {
                    setState(() {
                      isMale = value;
                      calculateBodyFat();
                    });
                  },
                  activeColor: Colors.red[700],
                ),
                Text('Male'),
              ],
            ),
            SizedBox(height: 20),
            _buildSlider('Height', height, 100, 220,
                (value) => setState(() => height = value)),
            _buildSlider('Waist', waist, 50, 150,
                (value) => setState(() => waist = value)),
            _buildSlider(
                'Neck', neck, 20, 60, (value) => setState(() => neck = value)),
            if (!isMale)
              _buildSlider(
                  'Hip', hip, 50, 150, (value) => setState(() => hip = value)),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bodyFatColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: bodyFatColor),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Body Fat Percentage',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${bodyFatPercentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: bodyFatColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    bodyFatCategory,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: bodyFatColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Body Fat Categories (${isMale ? "Men" : "Women"}):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (isMale) ...[
              Text('Essential Fat: < 6%'),
              Text('Athletes: 6-13%'),
              Text('Fitness: 14-17%'),
              Text('Average: 18-24%'),
              Text('Obese: ≥ 25%'),
            ] else ...[
              Text('Essential Fat: < 14%'),
              Text('Athletes: 14-20%'),
              Text('Fitness: 21-24%'),
              Text('Average: 25-31%'),
              Text('Obese: ≥ 32%'),
            ],
          ],
        ),
      ),
    );
  }
}

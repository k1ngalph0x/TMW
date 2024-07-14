import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  double height = 170; // cm
  double weight = 70; // kg
  double bmi = 0;
  String bmiCategory = '';
  Color bmiColor = Colors.green;

  void calculateBMI() {
    double bmiValue = weight / ((height / 100) * (height / 100));
    setState(() {
      bmi = bmiValue;
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
        bmiColor = Colors.blue;
      } else if (bmi >= 18.5 && bmi < 25) {
        bmiCategory = 'Normal';
        bmiColor = Colors.green;
      } else if (bmi >= 25 && bmi < 30) {
        bmiCategory = 'Overweight';
        bmiColor = Colors.orange;
      } else {
        bmiCategory = 'Obese';
        bmiColor = Colors.red;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    calculateBMI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.red[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Height (cm)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: height,
              min: 100,
              max: 220,
              divisions: 120,
              label: height.round().toString(),
              onChanged: (double value) {
                setState(() {
                  height = value;
                  calculateBMI();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Weight (kg)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: weight,
              min: 30,
              max: 150,
              divisions: 120,
              label: weight.round().toString(),
              onChanged: (double value) {
                setState(() {
                  weight = value;
                  calculateBMI();
                });
              },
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bmiColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: bmiColor),
              ),
              child: Column(
                children: [
                  Text(
                    'Your BMI',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: bmiColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    bmiCategory,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: bmiColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'BMI Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Underweight: < 18.5'),
            Text('Normal: 18.5 - 24.9'),
            Text('Overweight: 25 - 29.9'),
            Text('Obese: ≥ 30'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tmw/components/bmigauge_painter.dart';

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen>
    with SingleTickerProviderStateMixin {
  double height = 170; // cm
  double weight = 70; // kg
  double bmi = 0;
  String bmiCategory = '';
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Color _primaryColor = const Color(0xFF1F1F1F);
  final Color _accentColor = Colors.purpleAccent;
  final Color _backgroundColor = const Color(0xFF121212);
  final Color _surfaceColor = const Color(0xFF2C2C2C);
  final Color _textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    calculateBMI();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void calculateBMI() {
    double bmiValue = weight / ((height / 100) * (height / 100));
    setState(() {
      bmi = bmiValue;
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 25) {
        bmiCategory = 'Normal';
      } else if (bmi >= 25 && bmi < 30) {
        bmiCategory = 'Overweight';
      } else {
        bmiCategory = 'Obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: _backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: _primaryColor,
          elevation: 0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator', style: TextStyle(color: _textColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderCard(),
              _buildInputSection(),
              _buildResultSection(),
              _buildBmiCategoriesCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'Check Your BMI',
              style: TextStyle(
                color: _textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Body Mass Index (BMI) is a measure of body fat based on height and weight.',
              style: TextStyle(color: _textColor.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildSlider('Height (cm)', height, 100, 220, (value) {
            setState(() {
              height = value;
              calculateBMI();
            });
          }),
          const SizedBox(height: 16),
          _buildSlider('Weight (kg)', weight, 30, 150, (value) {
            setState(() {
              weight = value;
              calculateBMI();
            });
          }),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: _textColor)),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              value.round().toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _accentColor),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: _accentColor,
                  inactiveTrackColor: _accentColor.withOpacity(0.2),
                  thumbColor: _accentColor,
                  overlayColor: _accentColor.withOpacity(0.2),
                  valueIndicatorColor: _accentColor,
                  valueIndicatorTextStyle: TextStyle(color: _primaryColor),
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: (max - min).round(),
                  label: value.round().toString(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('Your BMI',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textColor)),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(200, 200),
                painter: BmiGaugePainter(
                  bmi: bmi,
                  animation: _animation.value,
                  backgroundColor: _surfaceColor,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            bmi.toStringAsFixed(1),
            style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: _getBmiColor()),
          ),
          Text(
            bmiCategory,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getBmiColor()),
          ),
          const SizedBox(height: 20),
          Text(
            _getBmiInterpretation(),
            style: TextStyle(fontSize: 16, color: _textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Color _getBmiColor() {
  //   if (bmi < 18.5) return Colors.blue;
  //   if (bmi < 25) return Colors.green;
  //   if (bmi < 30) return Colors.orange;
  //   return Colors.red;
  // }

  Color _getBmiColor() {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  String _getBmiInterpretation() {
    if (bmi < 18.5) {
      return "You are underweight. Consider consulting a nutritionist for a healthy weight gain plan.";
    }
    if (bmi < 25) {
      return "Your BMI is normal. Keep up the good work with a balanced diet and regular exercise!";
    }
    if (bmi < 30) {
      return "You are overweight. Consider increasing physical activity and improving your diet.";
    }
    return "You are in the obese category. It's advisable to consult a healthcare professional for a personalized plan.";
  }

  Widget _buildBmiCategoriesCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BMI Categories',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textColor)),
          const SizedBox(height: 16),
          _buildCategoryRow('Underweight', '< 18.5', Colors.blue),
          _buildCategoryRow('Normal', '18.5 - 24.9', Colors.green),
          _buildCategoryRow('Overweight', '25 - 29.9', Colors.orange),
          _buildCategoryRow('Obese', '≥ 30', Colors.red),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String category, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text('$category: $range',
              style: TextStyle(fontSize: 16, color: _textColor)),
        ],
      ),
    );
  }
}

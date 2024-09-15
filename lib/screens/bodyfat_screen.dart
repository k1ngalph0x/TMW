import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tmw/components/bodyfatgauge_painter.dart';

class BodyFatCalculatorScreen extends StatefulWidget {
  @override
  _BodyFatCalculatorScreenState createState() =>
      _BodyFatCalculatorScreenState();
}

class _BodyFatCalculatorScreenState extends State<BodyFatCalculatorScreen>
    with SingleTickerProviderStateMixin {
  double height = 170;
  double weight = 70;
  double waist = 80;
  double neck = 35;
  double hip = 90;
  bool isMale = true;
  double bodyFatPercentage = 0;
  String bodyFatCategory = '';
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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    calculateBodyFat();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void calculateBodyFat() {
    double bodyFat;
    if (isMale) {
      bodyFat = 495 /
              (1.0324 -
                  0.19077 * math.log(waist - neck) / math.ln10 +
                  0.15456 * math.log(height) / math.ln10) -
          450;
    } else {
      bodyFat = 495 /
              (1.29579 -
                  0.35004 * math.log(waist + hip - neck) / math.ln10 +
                  0.22100 * math.log(height) / math.ln10) -
          450;
    }

    setState(() {
      bodyFatPercentage = bodyFat;
      bodyFatCategory = getBodyFatCategory(bodyFat);
    });
    _animationController.reset();
    _animationController.forward();
  }

  String getBodyFatCategory(double bodyFat) {
    if (isMale) {
      if (bodyFat < 6) return 'Essential Fat';
      if (bodyFat < 14) return 'Athletes';
      if (bodyFat < 18) return 'Fitness';
      if (bodyFat < 25) return 'Average';
      return 'Obese';
    } else {
      if (bodyFat < 14) return 'Essential Fat';
      if (bodyFat < 21) return 'Athletes';
      if (bodyFat < 25) return 'Fitness';
      if (bodyFat < 32) return 'Average';
      return 'Obese';
    }
  }

  Color getBodyFatColor(String category) {
    switch (category) {
      case 'Essential Fat':
        return Colors.blue;
      case 'Athletes':
        return Colors.green;
      case 'Fitness':
        return Colors.lightGreen;
      case 'Average':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return _accentColor;
    }
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
          title:
              Text('Body Fat Calculator', style: TextStyle(color: _textColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderCard(),
              _buildInputSection(),
              _buildResultSection(),
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
      child: Column(
        children: [
          Text(
            'Body Fat Calculator',
            style: TextStyle(
              color: _textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Estimate your body fat percentage based on measurements',
            style: TextStyle(color: _textColor.withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
        ],
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
          _buildGenderSelector(),
          _buildSlider('Height (cm)', height, 100, 220,
              (value) => setState(() => height = value)),
          _buildSlider('Weight (kg)', weight, 30, 150,
              (value) => setState(() => weight = value)),
          _buildSlider('Waist (cm)', waist, 50, 150,
              (value) => setState(() => waist = value)),
          _buildSlider('Neck (cm)', neck, 20, 60,
              (value) => setState(() => neck = value)),
          if (!isMale)
            _buildSlider('Hip (cm)', hip, 50, 150,
                (value) => setState(() => hip = value)),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton(Icons.male, 'Male', isMale),
        const SizedBox(width: 20),
        _buildGenderButton(Icons.female, 'Female', !isMale),
      ],
    );
  }

  Widget _buildGenderButton(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMale = label == 'Male';
          calculateBodyFat();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _accentColor : _surfaceColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: _accentColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? _primaryColor : _accentColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? _primaryColor : _accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
                  onChanged: (newValue) {
                    onChanged(newValue);
                    calculateBodyFat();
                  },
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
          Text('Your Body Fat Percentage',
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
                painter: BodyFatGaugePainter(
                  percentage: bodyFatPercentage,
                  color: getBodyFatColor(bodyFatCategory),
                  animation: _animation.value,
                  backgroundColor: _surfaceColor,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            '${bodyFatPercentage.toStringAsFixed(1)}%',
            style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: getBodyFatColor(bodyFatCategory)),
          ),
          Text(
            bodyFatCategory,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: getBodyFatColor(bodyFatCategory)),
          ),
        ],
      ),
    );
  }
}

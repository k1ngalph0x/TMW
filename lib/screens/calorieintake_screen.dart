import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalorieIntakeScreen extends StatefulWidget {
  const CalorieIntakeScreen({Key? key}) : super(key: key);

  @override
  _CalorieIntakeScreenState createState() => _CalorieIntakeScreenState();
}

class _CalorieIntakeScreenState extends State<CalorieIntakeScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _gender = 'Male';
  double _age = 25;
  double _height = 170;
  double _weight = 70;
  String _activityLevel = 'Sedentary';
  double _calories = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Map<String, double> _activityLevels = {
    'Sedentary': 1.2,
    'Lightly Active': 1.375,
    'Moderately Active': 1.55,
    'Very Active': 1.725,
    'Extra Active': 1.9,
  };

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateCalories() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      double bmr;
      if (_gender == 'Male') {
        bmr = 88.362 + (13.397 * _weight) + (4.799 * _height) - (5.677 * _age);
      } else {
        bmr = 447.593 + (9.247 * _weight) + (3.098 * _height) - (4.330 * _age);
      }
      setState(() {
        _calories = bmr * _activityLevels[_activityLevel]!;
      });
      _animationController.reset();
      _animationController.forward();
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
          title: Text('Calorie Intake Calculator',
              style: TextStyle(color: _textColor)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderCard(),
              _buildInputSection(),
              if (_calories > 0) _buildResultSection(),
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
            'Calorie Intake Calculator',
            style: TextStyle(
              color: _textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Calculate your daily calorie needs based on your body metrics and activity level.',
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGenderSelector(),
            const SizedBox(height: 16),
            _buildSlider(
                'Age', _age, 1, 120, (value) => setState(() => _age = value)),
            _buildSlider('Height (cm)', _height, 100, 220,
                (value) => setState(() => _height = value)),
            _buildSlider('Weight (kg)', _weight, 30, 150,
                (value) => setState(() => _weight = value)),
            const SizedBox(height: 16),
            _buildActivityLevelDropdown(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateCalories,
              style: ElevatedButton.styleFrom(
                foregroundColor: _primaryColor,
                backgroundColor: _accentColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton(Icons.male, 'Male', _gender == 'Male'),
        const SizedBox(width: 20),
        _buildGenderButton(Icons.female, 'Female', _gender == 'Female'),
      ],
    );
  }

  Widget _buildGenderButton(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = label;
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

  Widget _buildActivityLevelDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Activity Level',
        labelStyle: TextStyle(color: _textColor),
        border: OutlineInputBorder(borderSide: BorderSide(color: _accentColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _accentColor.withOpacity(0.5))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: _accentColor)),
      ),
      dropdownColor: _surfaceColor,
      value: _activityLevel,
      items: _activityLevels.keys.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: _textColor)),
        );
      }).toList(),
      onChanged: (value) => setState(() => _activityLevel = value!),
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
          Text(
            'Your Daily Calorie Needs',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: _textColor),
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Text(
                '${(_calories * _animation.value).round()} calories',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _accentColor,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'This is the estimated number of calories you need daily to maintain your current weight.',
            style: TextStyle(color: _textColor, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

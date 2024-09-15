// //Original
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CalorieIntakeScreen extends StatefulWidget {
//   const CalorieIntakeScreen({Key? key}) : super(key: key);

//   @override
//   _CalorieIntakeScreenState createState() => _CalorieIntakeScreenState();
// }

// class _CalorieIntakeScreenState extends State<CalorieIntakeScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _gender = 'Male';
//   double _age = 0;
//   double _height = 0;
//   double _weight = 0;
//   String _activityLevel = 'Sedentary';
//   double _calories = 0;

//   final Map<String, double> _activityLevels = {
//     'Sedentary': 1.2,
//     'Lightly Active': 1.375,
//     'Moderately Active': 1.55,
//     'Very Active': 1.725,
//     'Extra Active': 1.9,
//   };

//   void _calculateCalories() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       double bmr;
//       if (_gender == 'Male') {
//         bmr = 88.362 + (13.397 * _weight) + (4.799 * _height) - (5.677 * _age);
//       } else {
//         bmr = 447.593 + (9.247 * _weight) + (3.098 * _height) - (4.330 * _age);
//       }
//       setState(() {
//         _calories = bmr * _activityLevels[_activityLevel]!;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(100.0),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromRGBO(64, 130, 175, 1),
//                 Color.fromRGBO(38, 83, 126, 1),
//               ],
//             ),
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Center(
//               child: Text(
//                 'Calorie Intake Calculator',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildGenderSelector(),
//               SizedBox(height: 16),
//               _buildNumberInput('Age', 'years', (value) => _age = value),
//               SizedBox(height: 16),
//               _buildNumberInput('Height', 'cm', (value) => _height = value),
//               SizedBox(height: 16),
//               _buildNumberInput('Weight', 'kg', (value) => _weight = value),
//               SizedBox(height: 16),
//               _buildActivityLevelDropdown(),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _calculateCalories,
//                 child: Text('Calculate'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromRGBO(64, 130, 175, 1),
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   textStyle: TextStyle(fontSize: 18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//               if (_calories > 0) _buildResultCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderSelector() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text('Gender:', style: TextStyle(fontSize: 18)),
//             Row(
//               children: [
//                 Radio<String>(
//                   value: 'Male',
//                   groupValue: _gender,
//                   onChanged: (value) => setState(() => _gender = value!),
//                   activeColor: Color.fromRGBO(64, 130, 175, 1),
//                 ),
//                 Text('Male'),
//               ],
//             ),
//             Row(
//               children: [
//                 Radio<String>(
//                   value: 'Female',
//                   groupValue: _gender,
//                   onChanged: (value) => setState(() => _gender = value!),
//                   activeColor: Color.fromRGBO(64, 130, 175, 1),
//                 ),
//                 Text('Female'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNumberInput(
//       String label, String unit, Function(double) onSaved) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextFormField(
//           decoration: InputDecoration(
//             labelText: '$label ($unit)',
//             border: OutlineInputBorder(),
//           ),
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
//           ],
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your $label';
//             }
//             if (double.tryParse(value) == null) {
//               return 'Please enter a valid number';
//             }
//             return null;
//           },
//           onSaved: (value) => onSaved(double.parse(value!)),
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityLevelDropdown() {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             labelText: 'Activity Level',
//             border: OutlineInputBorder(),
//           ),
//           value: _activityLevel,
//           items: _activityLevels.keys.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (value) => setState(() => _activityLevel = value!),
//         ),
//       ),
//     );
//   }

//   Widget _buildResultCard() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       color: Color.fromRGBO(64, 130, 175, 1),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'Recommended Daily Calorie Intake',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               '${_calories.round()} calories',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalorieIntakeScreen extends StatefulWidget {
  const CalorieIntakeScreen({Key? key}) : super(key: key);

  @override
  _CalorieIntakeScreenState createState() => _CalorieIntakeScreenState();
}

class _CalorieIntakeScreenState extends State<CalorieIntakeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _gender = 'Male';
  double _age = 0;
  double _height = 0;
  double _weight = 0;
  String _activityLevel = 'Sedentary';
  double _calories = 0;

  final Map<String, double> _activityLevels = {
    'Sedentary': 1.2,
    'Lightly Active': 1.375,
    'Moderately Active': 1.55,
    'Very Active': 1.725,
    'Extra Active': 1.9,
  };

  final Color _primaryColor = Color(0xFF1F1F1F);
  final Color _accentColor = Colors.purpleAccent;
  final Color _backgroundColor = Color(0xFF121212);
  final Color _surfaceColor = Color(0xFF2C2C2C);
  final Color _textColor = Colors.white;

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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGenderSelector(),
                SizedBox(height: 16),
                _buildNumberInput('Age', 'years', (value) => _age = value),
                SizedBox(height: 16),
                _buildNumberInput('Height', 'cm', (value) => _height = value),
                SizedBox(height: 16),
                _buildNumberInput('Weight', 'kg', (value) => _weight = value),
                SizedBox(height: 16),
                _buildActivityLevelDropdown(),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _calculateCalories,
                  child: Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _primaryColor,
                    backgroundColor: _accentColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                if (_calories > 0) _buildResultCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Card(
      color: _surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Gender:', style: TextStyle(fontSize: 18, color: _textColor)),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value!),
                  activeColor: _accentColor,
                ),
                Text('Male', style: TextStyle(color: _textColor)),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Female',
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value!),
                  activeColor: _accentColor,
                ),
                Text('Female', style: TextStyle(color: _textColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberInput(
      String label, String unit, Function(double) onSaved) {
    return Card(
      color: _surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          style: TextStyle(color: _textColor),
          decoration: InputDecoration(
            labelText: '$label ($unit)',
            labelStyle: TextStyle(color: _textColor.withOpacity(0.7)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: _accentColor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _accentColor.withOpacity(0.5))),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: _accentColor)),
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $label';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
          onSaved: (value) => onSaved(double.parse(value!)),
        ),
      ),
    );
  }

  Widget _buildActivityLevelDropdown() {
    return Card(
      color: _surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          dropdownColor: _surfaceColor,
          decoration: InputDecoration(
            labelText: 'Activity Level',
            labelStyle: TextStyle(color: _textColor.withOpacity(0.7)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: _accentColor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _accentColor.withOpacity(0.5))),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: _accentColor)),
          ),
          style: TextStyle(color: _textColor),
          value: _activityLevel,
          items: _activityLevels.keys.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => setState(() => _activityLevel = value!),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 4,
      color: _accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Recommended Daily Calorie Intake',
              style: TextStyle(
                color: _primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${_calories.round()} calories',
              style: TextStyle(
                color: _primaryColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

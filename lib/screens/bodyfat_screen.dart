// import 'package:flutter/material.dart';
// import 'dart:math';

// class BodyFatCalculatorScreen extends StatefulWidget {
//   @override
//   _BodyFatCalculatorScreenState createState() =>
//       _BodyFatCalculatorScreenState();
// }

// class _BodyFatCalculatorScreenState extends State<BodyFatCalculatorScreen> {
//   double height = 170; // cm
//   double waist = 80; // cm
//   double neck = 35; // cm
//   double hip = 90; // cm (for women)
//   bool isMale = true;
//   double bodyFatPercentage = 0;
//   String bodyFatCategory = '';
//   Color bodyFatColor = Colors.green;

//   void calculateBodyFat() {
//     double bodyFat;
//     if (isMale) {
//       bodyFat = 495 /
//               (1.0324 -
//                   0.19077 * log(waist - neck) / ln10 +
//                   0.15456 * log(height) / ln10) -
//           450;
//     } else {
//       bodyFat = 495 /
//               (1.29579 -
//                   0.35004 * log(waist + hip - neck) / ln10 +
//                   0.22100 * log(height) / ln10) -
//           450;
//     }

//     setState(() {
//       bodyFatPercentage = bodyFat;
//       if (isMale) {
//         if (bodyFat < 6) {
//           bodyFatCategory = 'Essential Fat';
//           bodyFatColor = Colors.blue;
//         } else if (bodyFat >= 6 && bodyFat < 14) {
//           bodyFatCategory = 'Athletes';
//           bodyFatColor = Colors.green;
//         } else if (bodyFat >= 14 && bodyFat < 18) {
//           bodyFatCategory = 'Fitness';
//           bodyFatColor = Colors.lightGreen;
//         } else if (bodyFat >= 18 && bodyFat < 25) {
//           bodyFatCategory = 'Average';
//           bodyFatColor = Colors.orange;
//         } else {
//           bodyFatCategory = 'Obese';
//           bodyFatColor = Colors.red;
//         }
//       } else {
//         if (bodyFat < 14) {
//           bodyFatCategory = 'Essential Fat';
//           bodyFatColor = Colors.blue;
//         } else if (bodyFat >= 14 && bodyFat < 21) {
//           bodyFatCategory = 'Athletes';
//           bodyFatColor = Colors.green;
//         } else if (bodyFat >= 21 && bodyFat < 25) {
//           bodyFatCategory = 'Fitness';
//           bodyFatColor = Colors.lightGreen;
//         } else if (bodyFat >= 25 && bodyFat < 32) {
//           bodyFatCategory = 'Average';
//           bodyFatColor = Colors.orange;
//         } else {
//           bodyFatCategory = 'Obese';
//           bodyFatColor = Colors.red;
//         }
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     calculateBodyFat();
//   }

//   Widget _buildSlider(String label, double value, double min, double max,
//       Function(double) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$label (${value.round()} cm)',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: (max - min).round(),
//           label: value.round().toString(),
//           onChanged: (double value) {
//             onChanged(value);
//             calculateBodyFat();
//           },
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Body Fat Calculator'),
//         backgroundColor: Colors.red[700],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Female'),
//                 Switch(
//                   value: isMale,
//                   onChanged: (value) {
//                     setState(() {
//                       isMale = value;
//                       calculateBodyFat();
//                     });
//                   },
//                   activeColor: Colors.red[700],
//                 ),
//                 Text('Male'),
//               ],
//             ),
//             SizedBox(height: 20),
//             _buildSlider('Height', height, 100, 220,
//                 (value) => setState(() => height = value)),
//             _buildSlider('Waist', waist, 50, 150,
//                 (value) => setState(() => waist = value)),
//             _buildSlider(
//                 'Neck', neck, 20, 60, (value) => setState(() => neck = value)),
//             if (!isMale)
//               _buildSlider(
//                   'Hip', hip, 50, 150, (value) => setState(() => hip = value)),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: bodyFatColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: bodyFatColor),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'Your Body Fat Percentage',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     '${bodyFatPercentage.toStringAsFixed(1)}%',
//                     style: TextStyle(
//                         fontSize: 48,
//                         fontWeight: FontWeight.bold,
//                         color: bodyFatColor),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     bodyFatCategory,
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: bodyFatColor),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Body Fat Categories (${isMale ? "Men" : "Women"}):',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             if (isMale) ...[
//               Text('Essential Fat: < 6%'),
//               Text('Athletes: 6-13%'),
//               Text('Fitness: 14-17%'),
//               Text('Average: 18-24%'),
//               Text('Obese: ≥ 25%'),
//             ] else ...[
//               Text('Essential Fat: < 14%'),
//               Text('Athletes: 14-20%'),
//               Text('Fitness: 21-24%'),
//               Text('Average: 25-31%'),
//               Text('Obese: ≥ 32%'),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
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
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          '${value.round()} cm',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(64, 130, 175, 1),
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          activeColor: Color.fromRGBO(64, 130, 175, 1),
          inactiveColor: Color.fromRGBO(64, 130, 175, 0.2),
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
        backgroundColor: Color.fromRGBO(64, 130, 175, 1),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(64, 130, 175, 1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGenderSelector(),
                SizedBox(height: 20),
                _buildInputCard(),
                SizedBox(height: 20),
                _buildBodyFatResultCard(),
                SizedBox(height: 20),
                _buildBodyFatCategoriesCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Female', style: TextStyle(fontSize: 18)),
            Switch(
              value: isMale,
              onChanged: (value) {
                setState(() {
                  isMale = value;
                  calculateBodyFat();
                });
              },
              activeColor: Color.fromRGBO(64, 130, 175, 1),
            ),
            Text('Male', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSlider('Height', height, 100, 220,
                (value) => setState(() => height = value)),
            _buildSlider('Waist', waist, 50, 150,
                (value) => setState(() => waist = value)),
            _buildSlider(
                'Neck', neck, 20, 60, (value) => setState(() => neck = value)),
            if (!isMale)
              _buildSlider(
                  'Hip', hip, 50, 150, (value) => setState(() => hip = value)),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyFatResultCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Your Body Fat Percentage',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: bodyFatColor, width: 8),
                boxShadow: [
                  BoxShadow(
                    color: bodyFatColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${bodyFatPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: bodyFatColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: bodyFatColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                bodyFatCategory,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: bodyFatColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyFatCategoriesCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Body Fat Categories (${isMale ? "Men" : "Women"}):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ..._buildCategoryList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategoryList() {
    final categories = isMale
        ? [
            ['Essential Fat', '< 6%', Colors.blue],
            ['Athletes', '6-13%', Colors.green],
            ['Fitness', '14-17%', Colors.lightGreen],
            ['Average', '18-24%', Colors.orange],
            ['Obese', '≥ 25%', Colors.red],
          ]
        : [
            ['Essential Fat', '< 14%', Colors.blue],
            ['Athletes', '14-20%', Colors.green],
            ['Fitness', '21-24%', Colors.lightGreen],
            ['Average', '25-31%', Colors.orange],
            ['Obese', '≥ 32%', Colors.red],
          ];

    return categories.map((category) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: category[2] as Color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text('${category[0]}: ${category[1]}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }).toList();
  }
}

// import 'package:flutter/material.dart';

// class BmiScreen extends StatefulWidget {
//   @override
//   _BmiScreenState createState() => _BmiScreenState();
// }

// class _BmiScreenState extends State<BmiScreen> {
//   double height = 170; // cm
//   double weight = 70; // kg
//   double bmi = 0;
//   String bmiCategory = '';
//   Color bmiColor = Colors.green;

//   void calculateBMI() {
//     double bmiValue = weight / ((height / 100) * (height / 100));
//     setState(() {
//       bmi = bmiValue;
//       if (bmi < 18.5) {
//         bmiCategory = 'Underweight';
//         bmiColor = Colors.blue;
//       } else if (bmi >= 18.5 && bmi < 25) {
//         bmiCategory = 'Normal';
//         bmiColor = Colors.green;
//       } else if (bmi >= 25 && bmi < 30) {
//         bmiCategory = 'Overweight';
//         bmiColor = Colors.orange;
//       } else {
//         bmiCategory = 'Obese';
//         bmiColor = Colors.red;
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     calculateBMI();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI Calculator'),
//         backgroundColor: Colors.red[700],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Height (cm)',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Slider(
//               value: height,
//               min: 100,
//               max: 220,
//               divisions: 120,
//               label: height.round().toString(),
//               onChanged: (double value) {
//                 setState(() {
//                   height = value;
//                   calculateBMI();
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Weight (kg)',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Slider(
//               value: weight,
//               min: 30,
//               max: 150,
//               divisions: 120,
//               label: weight.round().toString(),
//               onChanged: (double value) {
//                 setState(() {
//                   weight = value;
//                   calculateBMI();
//                 });
//               },
//             ),
//             SizedBox(height: 40),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: bmiColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: bmiColor),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'Your BMI',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     bmi.toStringAsFixed(1),
//                     style: TextStyle(
//                         fontSize: 48,
//                         fontWeight: FontWeight.bold,
//                         color: bmiColor),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     bmiCategory,
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: bmiColor),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'BMI Categories:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text('Underweight: < 18.5'),
//             Text('Normal: 18.5 - 24.9'),
//             Text('Overweight: 25 - 29.9'),
//             Text('Obese: ≥ 30'),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInputCard(),
                  SizedBox(height: 20),
                  _buildBmiResultCard(),
                  SizedBox(height: 20),
                  _buildBmiCategoriesCard(),
                ],
              ),
            ),
          ),
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
            _buildSlider('Height (cm)', height, 100, 220, (value) {
              setState(() {
                height = value;
                calculateBMI();
              });
            }),
            SizedBox(height: 20),
            _buildSlider('Weight (kg)', weight, 30, 150, (value) {
              setState(() {
                weight = value;
                calculateBMI();
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          value.round().toString(),
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
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Widget _buildBmiResultCard() {
  //   return Card(
  //     elevation: 5,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //     ),
  //     color: bmiColor.withOpacity(0.1),
  //     child: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         children: [
  //           Text(
  //             'Your BMI',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             bmi.toStringAsFixed(1),
  //             style: TextStyle(
  //               fontSize: 48,
  //               fontWeight: FontWeight.bold,
  //               color: bmiColor,
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             bmiCategory,
  //             style: TextStyle(
  //               fontSize: 24,
  //               fontWeight: FontWeight.bold,
  //               color: bmiColor,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildBmiResultCard() {
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
              'Your BMI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: bmiColor, width: 8),
                boxShadow: [
                  BoxShadow(
                    color: bmiColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: bmiColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: bmiColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                bmiCategory,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: bmiColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBmiCategoriesCard() {
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
              'BMI Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildCategoryRow('Underweight', '< 18.5', Colors.blue),
            _buildCategoryRow('Normal', '18.5 - 24.9', Colors.green),
            _buildCategoryRow('Overweight', '25 - 29.9', Colors.orange),
            _buildCategoryRow('Obese', '≥ 30', Colors.red),
          ],
        ),
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
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text('$category: $range', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

//Original
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
//         backgroundColor: Color.fromRGBO(64, 130, 175, 1),
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color.fromRGBO(64, 130, 175, 1), Colors.white],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   _buildInputCard(),
//                   SizedBox(height: 20),
//                   _buildBmiResultCard(),
//                   SizedBox(height: 20),
//                   _buildBmiCategoriesCard(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             _buildSlider('Height (cm)', height, 100, 220, (value) {
//               setState(() {
//                 height = value;
//                 calculateBMI();
//               });
//             }),
//             SizedBox(height: 20),
//             _buildSlider('Weight (kg)', weight, 30, 150, (value) {
//               setState(() {
//                 weight = value;
//                 calculateBMI();
//               });
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSlider(String label, double value, double min, double max,
//       Function(double) onChanged) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text(
//           value.round().toString(),
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color.fromRGBO(64, 130, 175, 1),
//           ),
//         ),
//         Slider(
//           value: value,
//           min: min,
//           max: max,
//           divisions: (max - min).round(),
//           activeColor: Color.fromRGBO(64, 130, 175, 1),
//           inactiveColor: Color.fromRGBO(64, 130, 175, 0.2),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }

//   // Widget _buildBmiResultCard() {
//   //   return Card(
//   //     elevation: 5,
//   //     shape: RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.circular(15),
//   //     ),
//   //     color: bmiColor.withOpacity(0.1),
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(20.0),
//   //       child: Column(
//   //         children: [
//   //           Text(
//   //             'Your BMI',
//   //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//   //           ),
//   //           SizedBox(height: 10),
//   //           Text(
//   //             bmi.toStringAsFixed(1),
//   //             style: TextStyle(
//   //               fontSize: 48,
//   //               fontWeight: FontWeight.bold,
//   //               color: bmiColor,
//   //             ),
//   //           ),
//   //           SizedBox(height: 10),
//   //           Text(
//   //             bmiCategory,
//   //             style: TextStyle(
//   //               fontSize: 24,
//   //               fontWeight: FontWeight.bold,
//   //               color: bmiColor,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildBmiResultCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Text(
//               'Your BMI',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(color: bmiColor, width: 8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: bmiColor.withOpacity(0.3),
//                     blurRadius: 10,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   bmi.toStringAsFixed(1),
//                   style: TextStyle(
//                     fontSize: 48,
//                     fontWeight: FontWeight.bold,
//                     color: bmiColor,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               decoration: BoxDecoration(
//                 color: bmiColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 bmiCategory,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: bmiColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBmiCategoriesCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'BMI Categories:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             _buildCategoryRow('Underweight', '< 18.5', Colors.blue),
//             _buildCategoryRow('Normal', '18.5 - 24.9', Colors.green),
//             _buildCategoryRow('Overweight', '25 - 29.9', Colors.orange),
//             _buildCategoryRow('Obese', '≥ 30', Colors.red),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryRow(String category, String range, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Container(
//             width: 12,
//             height: 12,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//             ),
//           ),
//           SizedBox(width: 8),
//           Text('$category: $range', style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }

//Overhaul
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:vector_math/vector_math.dart' as math;

// class BmiScreen extends StatefulWidget {
//   @override
//   _BmiScreenState createState() => _BmiScreenState();
// }

// class _BmiScreenState extends State<BmiScreen>
//     with SingleTickerProviderStateMixin {
//   double height = 170; // cm
//   double weight = 70; // kg
//   double bmi = 0;
//   String bmiCategory = '';
//   Color bmiColor = Colors.green;
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   final Color _primaryColor = Color(0xFF00B4D8);
//   final Color _accentColor = Color(0xFFFFB703);
//   final Color _backgroundColor = Color(0xFFF8F9FA);
//   final Color _textColor = Color(0xFF023047);

//   @override
//   void initState() {
//     super.initState();
//     calculateBMI();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI Calculator', style: TextStyle(color: _textColor)),
//         backgroundColor: _backgroundColor,
//         elevation: 0,
//         iconTheme: IconThemeData(color: _primaryColor),
//       ),
//       body: Container(
//         color: _backgroundColor,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   _buildInputCard(),
//                   SizedBox(height: 20),
//                   _buildBmiResultCard(),
//                   SizedBox(height: 20),
//                   _buildBmiGraph(),
//                   SizedBox(height: 20),
//                   _buildBmiCategoriesCard(),
//                   SizedBox(height: 20),
//                   _buildHealthTipsCard(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             _buildSlider('Height (cm)', height, 100, 220, (value) {
//               setState(() {
//                 height = value;
//                 calculateBMI();
//               });
//             }),
//             SizedBox(height: 20),
//             _buildSlider('Weight (kg)', weight, 30, 150, (value) {
//               setState(() {
//                 weight = value;
//                 calculateBMI();
//               });
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSlider(String label, double value, double min, double max,
//       Function(double) onChanged) {
//     return Column(
//       children: [
//         Text(label,
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: _textColor)),
//         SizedBox(height: 10),
//         Text(
//           value.round().toString(),
//           style: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: _primaryColor),
//         ),
//         SliderTheme(
//           data: SliderThemeData(
//             activeTrackColor: _primaryColor,
//             inactiveTrackColor: _primaryColor.withOpacity(0.2),
//             thumbColor: _accentColor,
//             overlayColor: _accentColor.withOpacity(0.2),
//             valueIndicatorColor: _primaryColor,
//             valueIndicatorTextStyle: TextStyle(color: Colors.white),
//           ),
//           child: Slider(
//             value: value,
//             min: min,
//             max: max,
//             divisions: (max - min).round(),
//             label: value.round().toString(),
//             onChanged: onChanged,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBmiResultCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Text('Your BMI',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: _textColor)),
//             SizedBox(height: 20),
//             AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 return CustomPaint(
//                   size: Size(200, 200),
//                   painter: BmiGaugePainter(
//                     bmi: bmi,
//                     color: bmiColor,
//                     animation: _animation.value,
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           bmi.toStringAsFixed(1),
//                           style: TextStyle(
//                               fontSize: 48,
//                               fontWeight: FontWeight.bold,
//                               color: bmiColor),
//                         ),
//                         Text(
//                           bmiCategory,
//                           style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: bmiColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBmiGraph() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('BMI Range',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _textColor)),
//             SizedBox(height: 20),
//             Container(
//               height: 200,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 22,
//                         getTitlesWidget: (value, meta) {
//                           String text;
//                           switch (value.toInt()) {
//                             case 0:
//                               text = '0';
//                               break;
//                             case 20:
//                               text = '20';
//                               break;
//                             case 25:
//                               text = '25';
//                               break;
//                             case 30:
//                               text = '30';
//                               break;
//                             case 40:
//                               text = '40';
//                               break;
//                             default:
//                               return Text('');
//                           }
//                           return Text(text,
//                               style: TextStyle(
//                                 color: _textColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ));
//                         },
//                       ),
//                     ),
//                     leftTitles:
//                         AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles:
//                         AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles:
//                         AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   minX: 0,
//                   maxX: 40,
//                   minY: 0,
//                   maxY: 1,
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: [
//                         FlSpot(0, 0),
//                         FlSpot(18.5, 0),
//                         FlSpot(18.5, 1),
//                         FlSpot(25, 1),
//                         FlSpot(25, 0),
//                         FlSpot(30, 0),
//                         FlSpot(30, 1),
//                         FlSpot(40, 1),
//                       ],
//                       isCurved: false,
//                       color: Colors.grey,
//                       barWidth: 5,
//                       isStrokeCapRound: true,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(
//                         show: true,
//                         color: Colors.grey.withOpacity(0.3),
//                       ),
//                     ),
//                     LineChartBarData(
//                       spots: [FlSpot(bmi, 0), FlSpot(bmi, 1)],
//                       isCurved: false,
//                       color: bmiColor,
//                       barWidth: 2,
//                       isStrokeCapRound: true,
//                       dotData: FlDotData(
//                         show: true,
//                         getDotPainter: (spot, percent, barData, index) =>
//                             FlDotCirclePainter(
//                           radius: 6,
//                           color: bmiColor,
//                           strokeWidth: 2,
//                           strokeColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                   lineTouchData: LineTouchData(enabled: false),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBmiCategoriesCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('BMI Categories:',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _textColor)),
//             SizedBox(height: 10),
//             _buildCategoryRow('Underweight', '< 18.5', Colors.blue),
//             _buildCategoryRow('Normal', '18.5 - 24.9', Colors.green),
//             _buildCategoryRow('Overweight', '25 - 29.9', Colors.orange),
//             _buildCategoryRow('Obese', '≥ 30', Colors.red),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryRow(String category, String range, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
//           SizedBox(width: 8),
//           Text('$category: $range',
//               style: TextStyle(fontSize: 16, color: _textColor)),
//         ],
//       ),
//     );
//   }

//   Widget _buildHealthTipsCard() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Health Tips',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _textColor)),
//             SizedBox(height: 10),
//             _buildHealthTip(
//                 'Maintain a balanced diet rich in fruits, vegetables, and whole grains.'),
//             _buildHealthTip(
//                 'Engage in regular physical activity, aiming for at least 150 minutes per week.'),
//             _buildHealthTip(
//                 'Stay hydrated by drinking plenty of water throughout the day.'),
//             _buildHealthTip(
//                 'Get adequate sleep, aiming for 7-9 hours per night.'),
//             _buildHealthTip(
//                 'Manage stress through relaxation techniques like meditation or yoga.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHealthTip(String tip) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.check_circle, color: _primaryColor, size: 20),
//           SizedBox(width: 8),
//           Expanded(
//               child:
//                   Text(tip, style: TextStyle(fontSize: 14, color: _textColor))),
//         ],
//       ),
//     );
//   }
// }

// class BmiGaugePainter extends CustomPainter {
//   final double bmi;
//   final Color color;
//   final double animation;

//   BmiGaugePainter(
//       {required this.bmi, required this.color, required this.animation});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     final startAngle = math.radians(180);
//     final sweepAngle = math.radians(180);
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 20.0
//       ..strokeCap = StrokeCap.round;

//     // Draw background arc
//     paint.color = Colors.grey.withOpacity(0.2);
//     canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

//     // Draw BMI arc
//     paint.color = color;
//     final bmiAngle = math.radians(180 * (bmi / 40) * animation);
//     canvas.drawArc(rect, startAngle, bmiAngle, false, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

//Okish
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class BmiScreen extends StatefulWidget {
//   @override
//   _BmiScreenState createState() => _BmiScreenState();
// }

// class _BmiScreenState extends State<BmiScreen>
//     with SingleTickerProviderStateMixin {
//   double height = 170; // cm
//   double weight = 70; // kg
//   double bmi = 0;
//   String bmiCategory = '';
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   final Color _primaryColor = Color(0xFF1E88E5);
//   final Color _accentColor = Color(0xFFFFA726);
//   final Color _backgroundColor = Color(0xFFF5F5F5);
//   final Color _surfaceColor = Colors.white;
//   final Color _textColor = Color(0xFF333333);

//   @override
//   void initState() {
//     super.initState();
//     calculateBMI();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void calculateBMI() {
//     double bmiValue = weight / ((height / 100) * (height / 100));
//     setState(() {
//       bmi = bmiValue;
//       if (bmi < 18.5) {
//         bmiCategory = 'Underweight';
//       } else if (bmi >= 18.5 && bmi < 25) {
//         bmiCategory = 'Normal';
//       } else if (bmi >= 25 && bmi < 30) {
//         bmiCategory = 'Overweight';
//       } else {
//         bmiCategory = 'Obese';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       appBar: AppBar(
//         title: Text('BMI Calculator', style: TextStyle(color: _surfaceColor)),
//         backgroundColor: _primaryColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeaderCard(),
//             _buildInputSection(),
//             _buildResultSection(),
//             _buildBmiCategoriesCard(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderCard() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _primaryColor,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             Text(
//               'Check Your BMI',
//               style: TextStyle(
//                 color: _surfaceColor,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Body Mass Index (BMI) is a measure of body fat based on height and weight.',
//               style: TextStyle(color: _surfaceColor.withOpacity(0.8)),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputSection() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surfaceColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildSlider('Height (cm)', height, 100, 220, (value) {
//             setState(() {
//               height = value;
//               calculateBMI();
//             });
//           }),
//           SizedBox(height: 16),
//           _buildSlider('Weight (kg)', weight, 30, 150, (value) {
//             setState(() {
//               weight = value;
//               calculateBMI();
//             });
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildSlider(String label, double value, double min, double max,
//       Function(double) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: _textColor)),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Text(
//               value.round().toString(),
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _primaryColor),
//             ),
//             Expanded(
//               child: SliderTheme(
//                 data: SliderThemeData(
//                   activeTrackColor: _primaryColor,
//                   inactiveTrackColor: _primaryColor.withOpacity(0.2),
//                   thumbColor: _accentColor,
//                   overlayColor: _accentColor.withOpacity(0.2),
//                   valueIndicatorColor: _primaryColor,
//                   valueIndicatorTextStyle: TextStyle(color: _surfaceColor),
//                 ),
//                 child: Slider(
//                   value: value,
//                   min: min,
//                   max: max,
//                   divisions: (max - min).round(),
//                   label: value.round().toString(),
//                   onChanged: onChanged,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildResultSection() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surfaceColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text('Your BMI',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _textColor)),
//           SizedBox(height: 20),
//           AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return CustomPaint(
//                 size: Size(200, 200),
//                 painter: BmiGaugePainter(
//                   bmi: bmi,
//                   animation: _animation.value,
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Text(
//             bmi.toStringAsFixed(1),
//             style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: _getBmiColor()),
//           ),
//           Text(
//             bmiCategory,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: _getBmiColor()),
//           ),
//           SizedBox(height: 20),
//           Text(
//             _getBmiInterpretation(),
//             style: TextStyle(fontSize: 16, color: _textColor),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getBmiColor() {
//     if (bmi < 18.5) return Colors.blue;
//     if (bmi < 25) return Colors.green;
//     if (bmi < 30) return Colors.orange;
//     return Colors.red;
//   }

//   String _getBmiInterpretation() {
//     if (bmi < 18.5)
//       return "You are underweight. Consider consulting a nutritionist for a healthy weight gain plan.";
//     if (bmi < 25)
//       return "Your BMI is normal. Keep up the good work with a balanced diet and regular exercise!";
//     if (bmi < 30)
//       return "You are overweight. Consider increasing physical activity and improving your diet.";
//     return "You are in the obese category. It's advisable to consult a healthcare professional for a personalized plan.";
//   }

//   Widget _buildBmiCategoriesCard() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surfaceColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('BMI Categories',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _textColor)),
//           SizedBox(height: 16),
//           _buildCategoryRow('Underweight', '< 18.5', Colors.blue),
//           _buildCategoryRow('Normal', '18.5 - 24.9', Colors.green),
//           _buildCategoryRow('Overweight', '25 - 29.9', Colors.orange),
//           _buildCategoryRow('Obese', '≥ 30', Colors.red),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryRow(String category, String range, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Container(
//             width: 12,
//             height: 12,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           SizedBox(width: 8),
//           Text('$category: $range',
//               style: TextStyle(fontSize: 16, color: _textColor)),
//         ],
//       ),
//     );
//   }
// }

// class BmiGaugePainter extends CustomPainter {
//   final double bmi;
//   final double animation;

//   BmiGaugePainter({required this.bmi, required this.animation});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     final startAngle = math.pi * 0.75;
//     final sweepAngle = math.pi * 1.5;
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 15.0
//       ..strokeCap = StrokeCap.round;

//     // Draw background arc
//     paint.color = Colors.grey.withOpacity(0.2);
//     canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

//     // Draw BMI arc
//     final gradient = SweepGradient(
//       startAngle: startAngle,
//       endAngle: startAngle + sweepAngle,
//       colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
//       stops: [0.0, 0.3125, 0.625, 1.0],
//     );
//     paint.shader = gradient.createShader(rect);

//     final bmiAngle = (sweepAngle * (bmi / 40).clamp(0.0, 1.0) * animation)
//         .clamp(0.0, sweepAngle);
//     canvas.drawArc(rect, startAngle, bmiAngle, false, paint);

//     // Draw pointer
//     final pointerAngle = startAngle + bmiAngle;
//     final pointerLength = radius - 20;
//     final pointerEnd = Offset(
//       center.dx + pointerLength * math.cos(pointerAngle),
//       center.dy + pointerLength * math.sin(pointerAngle),
//     );
//     canvas.drawLine(
//         center,
//         pointerEnd,
//         Paint()
//           ..color = Colors.black
//           ..strokeWidth = 2
//           ..strokeCap = StrokeCap.round);

//     canvas.drawCircle(center, 5, Paint()..color = Colors.black);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class BmiScreen extends StatefulWidget {
//   @override
//   _BmiScreenState createState() => _BmiScreenState();
// }

// class _BmiScreenState extends State<BmiScreen>
//     with SingleTickerProviderStateMixin {
//   double height = 170; // cm
//   double weight = 70; // kg
//   double bmi = 0;
//   String bmiCategory = '';
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   final Color _primaryColor = Color(0xFF1E88E5);
//   final Color _accentColor = Color(0xFFFFA726);
//   final Color _backgroundColor = Color(0xFFF5F5F5);
//   final Color _surfaceColor = Colors.white;
//   final Color _textColor = Color(0xFF333333);

//   @override
//   void initState() {
//     super.initState();
//     calculateBMI();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void calculateBMI() {
//     double bmiValue = weight / ((height / 100) * (height / 100));
//     setState(() {
//       bmi = bmiValue;
//       if (bmi < 18.5) {
//         bmiCategory = 'Underweight';
//       } else if (bmi >= 18.5 && bmi < 25) {
//         bmiCategory = 'Normal';
//       } else if (bmi >= 25 && bmi < 30) {
//         bmiCategory = 'Overweight';
//       } else {
//         bmiCategory = 'Obese';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       appBar: AppBar(
//         title: Text('BMI Calculator', style: TextStyle(color: _surfaceColor)),
//         backgroundColor: _primaryColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeaderCard(),
//             _buildInputSection(),
//             _buildResultSection(),
//             _buildBmiCategoriesCard(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderCard() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _primaryColor,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             Text(
//               'Check Your BMI',
//               style: TextStyle(
//                 color: _surfaceColor,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Body Mass Index (BMI) is a measure of body fat based on height and weight.',
//               style: TextStyle(color: _surfaceColor.withOpacity(0.8)),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputSection() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surfaceColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildSlider('Height (cm)', height, 100, 220, (value) {
//             setState(() {
//               height = value;
//               calculateBMI();
//             });
//           }),
//           SizedBox(height: 16),
//           _buildSlider('Weight (kg)', weight, 30, 150, (value) {
//             setState(() {
//               weight = value;
//               calculateBMI();
//             });
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildSlider(String label, double value, double min, double max,
//       Function(double) onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: _textColor)),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Text(
//               value.round().toString(),
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _primaryColor),
//             ),
//             Expanded(
//               child: SliderTheme(
//                 data: SliderThemeData(
//                   activeTrackColor: _primaryColor,
//                   inactiveTrackColor: _primaryColor.withOpacity(0.2),
//                   thumbColor: _accentColor,
//                   overlayColor: _accentColor.withOpacity(0.2),
//                   valueIndicatorColor: _primaryColor,
//                   valueIndicatorTextStyle: TextStyle(color: _surfaceColor),
//                 ),
//                 child: Slider(
//                   value: value,
//                   min: min,
//                   max: max,
//                   divisions: (max - min).round(),
//                   label: value.round().toString(),
//                   onChanged: onChanged,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildResultSection() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surfaceColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text('Your BMI',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _textColor)),
//           SizedBox(height: 20),
//           AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return CustomPaint(
//                 size: Size(200, 200),
//                 painter: BmiGaugePainter(
//                   bmi: bmi,
//                   animation: _animation.value,
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Text(
//             bmi.toStringAsFixed(1),
//             style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: _getBmiColor()),
//           ),
//           Text(
//             bmiCategory,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: _getBmiColor()),
//           ),
//           SizedBox(height: 20),
//           Text(
//             _getBmiInterpretation(),
//             style: TextStyle(fontSize: 16, color: _textColor),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getBmiColor() {
//     if (bmi < 18.5) return Colors.blue;
//     if (bmi < 25) return Colors.green;
//     if (bmi < 30) return Colors.orange;
//     return Colors.red;
//   }

//   String _getBmiInterpretation() {
//     if (bmi < 18.5)
//       return "You are underweight. Consider consulting a nutritionist for a healthy weight gain plan.";
//     if (bmi < 25)
//       return "Your BMI is normal. Keep up the good work with a balanced diet and regular exercise!";
//     if (bmi < 30)
//       return "You are overweight. Consider increasing physical activity and improving your diet.";
//     return "You are in the obese category. It's advisable to consult a healthcare professional for a personalized plan.";
//   }

//   Widget _buildBmiCategoriesCard() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: _surfaceColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('BMI Categories',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _textColor)),
//           SizedBox(height: 16),
//           _buildCategoryRow('Underweight', '< 18.5', Colors.blue),
//           _buildCategoryRow('Normal', '18.5 - 24.9', Colors.green),
//           _buildCategoryRow('Overweight', '25 - 29.9', Colors.orange),
//           _buildCategoryRow('Obese', '≥ 30', Colors.red),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryRow(String category, String range, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Container(
//             width: 12,
//             height: 12,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           SizedBox(width: 8),
//           Text('$category: $range',
//               style: TextStyle(fontSize: 16, color: _textColor)),
//         ],
//       ),
//     );
//   }
// }

// class BmiGaugePainter extends CustomPainter {
//   final double bmi;
//   final double animation;

//   BmiGaugePainter({required this.bmi, required this.animation});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     final startAngle = math.pi * 0.75;
//     final sweepAngle = math.pi * 1.5;
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 15.0
//       ..strokeCap = StrokeCap.round;

//     // Draw background arc
//     paint.color = Colors.grey.withOpacity(0.2);
//     canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

//     // Draw BMI arc
//     final gradient = SweepGradient(
//       startAngle: startAngle,
//       endAngle: startAngle + sweepAngle,
//       colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
//       stops: [0.0, 0.3125, 0.625, 1.0],
//     );
//     paint.shader = gradient.createShader(rect);

//     final bmiAngle = (sweepAngle * (bmi / 40).clamp(0.0, 1.0) * animation)
//         .clamp(0.0, sweepAngle);
//     canvas.drawArc(rect, startAngle, bmiAngle, false, paint);

//     // Draw pointer
//     final pointerAngle = startAngle + bmiAngle;
//     final pointerLength = radius - 20;
//     final pointerEnd = Offset(
//       center.dx + pointerLength * math.cos(pointerAngle),
//       center.dy + pointerLength * math.sin(pointerAngle),
//     );
//     canvas.drawLine(
//         center,
//         pointerEnd,
//         Paint()
//           ..color = Colors.black
//           ..strokeWidth = 2
//           ..strokeCap = StrokeCap.round);

//     canvas.drawCircle(center, 5, Paint()..color = Colors.black);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  final Color _primaryColor = Color(0xFF1F1F1F);
  final Color _accentColor = Colors.purpleAccent;
  final Color _backgroundColor = Color(0xFF121212);
  final Color _surfaceColor = Color(0xFF2C2C2C);
  final Color _textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    calculateBMI();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.only(
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
            SizedBox(height: 8),
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
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
          SizedBox(height: 16),
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
        SizedBox(height: 8),
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
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
          SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(200, 200),
                painter: BmiGaugePainter(
                  bmi: bmi,
                  animation: _animation.value,
                  backgroundColor: _surfaceColor,
                ),
              );
            },
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          Text(
            _getBmiInterpretation(),
            style: TextStyle(fontSize: 16, color: _textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getBmiColor() {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  String _getBmiInterpretation() {
    if (bmi < 18.5)
      return "You are underweight. Consider consulting a nutritionist for a healthy weight gain plan.";
    if (bmi < 25)
      return "Your BMI is normal. Keep up the good work with a balanced diet and regular exercise!";
    if (bmi < 30)
      return "You are overweight. Consider increasing physical activity and improving your diet.";
    return "You are in the obese category. It's advisable to consult a healthcare professional for a personalized plan.";
  }

  Widget _buildBmiCategoriesCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
          SizedBox(height: 16),
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
          SizedBox(width: 8),
          Text('$category: $range',
              style: TextStyle(fontSize: 16, color: _textColor)),
        ],
      ),
    );
  }
}

class BmiGaugePainter extends CustomPainter {
  final double bmi;
  final double animation;
  final Color backgroundColor;

  BmiGaugePainter(
      {required this.bmi,
      required this.animation,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = math.pi * 0.75;
    final sweepAngle = math.pi * 1.5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw BMI arc
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [Colors.blue, Colors.green, Colors.orange, Colors.red],
      stops: [0.0, 0.3125, 0.625, 1.0],
    );
    paint.shader = gradient.createShader(rect);

    final bmiAngle = (sweepAngle * (bmi / 40).clamp(0.0, 1.0) * animation)
        .clamp(0.0, sweepAngle);
    canvas.drawArc(rect, startAngle, bmiAngle, false, paint);

    // Draw pointer
    final pointerAngle = startAngle + bmiAngle;
    final pointerLength = radius - 20;
    final pointerEnd = Offset(
      center.dx + pointerLength * math.cos(pointerAngle),
      center.dy + pointerLength * math.sin(pointerAngle),
    );
    canvas.drawLine(
        center,
        pointerEnd,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round);

    canvas.drawCircle(center, 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

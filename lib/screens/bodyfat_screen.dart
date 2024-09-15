// Original
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
//           label,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         Text(
//           '${value.round()} cm',
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
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildGenderSelector(),
//                 SizedBox(height: 20),
//                 _buildInputCard(),
//                 SizedBox(height: 20),
//                 _buildBodyFatResultCard(),
//                 SizedBox(height: 20),
//                 _buildBodyFatCategoriesCard(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderSelector() {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text('Female', style: TextStyle(fontSize: 18)),
//             Switch(
//               value: isMale,
//               onChanged: (value) {
//                 setState(() {
//                   isMale = value;
//                   calculateBodyFat();
//                 });
//               },
//               activeColor: Color.fromRGBO(64, 130, 175, 1),
//             ),
//             Text('Male', style: TextStyle(fontSize: 18)),
//           ],
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
//             _buildSlider('Height', height, 100, 220,
//                 (value) => setState(() => height = value)),
//             _buildSlider('Waist', waist, 50, 150,
//                 (value) => setState(() => waist = value)),
//             _buildSlider(
//                 'Neck', neck, 20, 60, (value) => setState(() => neck = value)),
//             if (!isMale)
//               _buildSlider(
//                   'Hip', hip, 50, 150, (value) => setState(() => hip = value)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBodyFatResultCard() {
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
//               'Your Body Fat Percentage',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87),
//             ),
//             SizedBox(height: 20),
//             Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//                 border: Border.all(color: bodyFatColor, width: 8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: bodyFatColor.withOpacity(0.3),
//                     blurRadius: 10,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   '${bodyFatPercentage.toStringAsFixed(1)}%',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: bodyFatColor,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               decoration: BoxDecoration(
//                 color: bodyFatColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 bodyFatCategory,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: bodyFatColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBodyFatCategoriesCard() {
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
//               'Body Fat Categories (${isMale ? "Men" : "Women"}):',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             ..._buildCategoryList(),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildCategoryList() {
//     final categories = isMale
//         ? [
//             ['Essential Fat', '< 6%', Colors.blue],
//             ['Athletes', '6-13%', Colors.green],
//             ['Fitness', '14-17%', Colors.lightGreen],
//             ['Average', '18-24%', Colors.orange],
//             ['Obese', '≥ 25%', Colors.red],
//           ]
//         : [
//             ['Essential Fat', '< 14%', Colors.blue],
//             ['Athletes', '14-20%', Colors.green],
//             ['Fitness', '21-24%', Colors.lightGreen],
//             ['Average', '25-31%', Colors.orange],
//             ['Obese', '≥ 32%', Colors.red],
//           ];

//     return categories.map((category) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Row(
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(
//                 color: category[2] as Color,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             SizedBox(width: 8),
//             Text('${category[0]}: ${category[1]}',
//                 style: TextStyle(fontSize: 16)),
//           ],
//         ),
//       );
//     }).toList();
//   }
// }

//Okish
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class BodyFatCalculatorScreen extends StatefulWidget {
//   @override
//   _BodyFatCalculatorScreenState createState() =>
//       _BodyFatCalculatorScreenState();
// }

// class _BodyFatCalculatorScreenState extends State<BodyFatCalculatorScreen>
//     with SingleTickerProviderStateMixin {
//   double height = 170;
//   double weight = 70;
//   double waist = 80;
//   double neck = 35;
//   double hip = 90;
//   bool isMale = true;
//   double bodyFatPercentage = 0;
//   String bodyFatCategory = '';
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   final Color _primaryColor = Color(0xFF6200EE);
//   final Color _accentColor = Color(0xFF03DAC6);
//   final Color _backgroundColor = Color(0xFFF5F5F5);
//   final Color _surfaceColor = Colors.white;
//   final Color _textColor = Color(0xFF333333);
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     calculateBodyFat();
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void calculateBodyFat() {
//     double bodyFat;
//     if (isMale) {
//       bodyFat = 495 /
//               (1.0324 -
//                   0.19077 * math.log(waist - neck) / math.ln10 +
//                   0.15456 * math.log(height) / math.ln10) -
//           450;
//     } else {
//       bodyFat = 495 /
//               (1.29579 -
//                   0.35004 * math.log(waist + hip - neck) / math.ln10 +
//                   0.22100 * math.log(height) / math.ln10) -
//           450;
//     }

//     setState(() {
//       bodyFatPercentage = bodyFat;
//       bodyFatCategory = getBodyFatCategory(bodyFat);
//     });
//     _animationController.reset();
//     _animationController.forward();
//   }

//   String getBodyFatCategory(double bodyFat) {
//     if (isMale) {
//       if (bodyFat < 6) return 'Essential Fat';
//       if (bodyFat < 14) return 'Athletes';
//       if (bodyFat < 18) return 'Fitness';
//       if (bodyFat < 25) return 'Average';
//       return 'Obese';
//     } else {
//       if (bodyFat < 14) return 'Essential Fat';
//       if (bodyFat < 21) return 'Athletes';
//       if (bodyFat < 25) return 'Fitness';
//       if (bodyFat < 32) return 'Average';
//       return 'Obese';
//     }
//   }

//   Color getBodyFatColor(String category) {
//     switch (category) {
//       case 'Essential Fat':
//         return Colors.blue;
//       case 'Athletes':
//         return Colors.green;
//       case 'Fitness':
//         return Colors.lightGreen;
//       case 'Average':
//         return Colors.orange;
//       case 'Obese':
//         return Colors.red;
//       default:
//         return _primaryColor;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       appBar: AppBar(
//         title:
//             Text('Body Fat Calculator', style: TextStyle(color: _surfaceColor)),
//         backgroundColor: _primaryColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeaderCard(),
//             _buildInputSection(),
//             _buildResultSection(),
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
//       child: Column(
//         children: [
//           Text(
//             'Body Fat Calculator',
//             style: TextStyle(
//               color: _surfaceColor,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Estimate your body fat percentage based on measurements',
//             style: TextStyle(color: _surfaceColor.withOpacity(0.8)),
//             textAlign: TextAlign.center,
//           ),
//         ],
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
//           _buildGenderSelector(),
//           _buildSlider('Height (cm)', height, 100, 220,
//               (value) => setState(() => height = value)),
//           _buildSlider('Weight (kg)', weight, 30, 150,
//               (value) => setState(() => weight = value)),
//           _buildSlider('Waist (cm)', waist, 50, 150,
//               (value) => setState(() => waist = value)),
//           _buildSlider('Neck (cm)', neck, 20, 60,
//               (value) => setState(() => neck = value)),
//           if (!isMale)
//             _buildSlider('Hip (cm)', hip, 50, 150,
//                 (value) => setState(() => hip = value)),
//         ],
//       ),
//     );
//   }

//   Widget _buildGenderSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildGenderButton(Icons.male, 'Male', isMale),
//         SizedBox(width: 20),
//         _buildGenderButton(Icons.female, 'Female', !isMale),
//       ],
//     );
//   }

//   Widget _buildGenderButton(IconData icon, String label, bool isSelected) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isMale = label == 'Male';
//           calculateBodyFat();
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? _primaryColor : _surfaceColor,
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: _primaryColor),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: isSelected ? _surfaceColor : _primaryColor),
//             SizedBox(width: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? _surfaceColor : _primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
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
//               child: Slider(
//                 value: value,
//                 min: min,
//                 max: max,
//                 activeColor: _primaryColor,
//                 inactiveColor: _primaryColor.withOpacity(0.2),
//                 onChanged: (newValue) {
//                   onChanged(newValue);
//                   calculateBodyFat();
//                 },
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
//           Text('Your Body Fat Percentage',
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
//                 painter: BodyFatGaugePainter(
//                   percentage: bodyFatPercentage,
//                   color: getBodyFatColor(bodyFatCategory),
//                   animation: _animation.value,
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Text(
//             '${bodyFatPercentage.toStringAsFixed(1)}%',
//             style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: getBodyFatColor(bodyFatCategory)),
//           ),
//           Text(
//             bodyFatCategory,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: getBodyFatColor(bodyFatCategory)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BodyFatGaugePainter extends CustomPainter {
//   final double percentage;
//   final Color color;
//   final double animation;

//   BodyFatGaugePainter(
//       {required this.percentage, required this.color, required this.animation});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     final startAngle = -math.pi / 2;
//     final sweepAngle = 2 * math.pi * (percentage / 100) * animation;
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 20.0
//       ..strokeCap = StrokeCap.round;

//     // Draw background arc
//     paint.color = Colors.grey.withOpacity(0.2);
//     canvas.drawArc(rect, startAngle, 2 * math.pi, false, paint);

//     // Draw percentage arc
//     paint.color = color;
//     canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

//     // Draw percentage text
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: '${(percentage * animation).toStringAsFixed(1)}%',
//         style:
//             TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(
//         canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class BodyFatCalculatorScreen extends StatefulWidget {
//   @override
//   _BodyFatCalculatorScreenState createState() =>
//       _BodyFatCalculatorScreenState();
// }

// class _BodyFatCalculatorScreenState extends State<BodyFatCalculatorScreen>
//     with SingleTickerProviderStateMixin {
//   double height = 170;
//   double weight = 70;
//   double waist = 80;
//   double neck = 35;
//   double hip = 90;
//   bool isMale = true;
//   double bodyFatPercentage = 0;
//   String bodyFatCategory = '';
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   final Color _primaryColor = Color(0xFF6200EE);
//   final Color _accentColor = Color(0xFF03DAC6);
//   final Color _backgroundColor = Color(0xFFF5F5F5);
//   final Color _surfaceColor = Colors.white;
//   final Color _textColor = Color(0xFF333333);
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     calculateBodyFat();
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void calculateBodyFat() {
//     double bodyFat;
//     if (isMale) {
//       bodyFat = 495 /
//               (1.0324 -
//                   0.19077 * math.log(waist - neck) / math.ln10 +
//                   0.15456 * math.log(height) / math.ln10) -
//           450;
//     } else {
//       bodyFat = 495 /
//               (1.29579 -
//                   0.35004 * math.log(waist + hip - neck) / math.ln10 +
//                   0.22100 * math.log(height) / math.ln10) -
//           450;
//     }

//     setState(() {
//       bodyFatPercentage = bodyFat;
//       bodyFatCategory = getBodyFatCategory(bodyFat);
//     });
//     _animationController.reset();
//     _animationController.forward();
//   }

//   String getBodyFatCategory(double bodyFat) {
//     if (isMale) {
//       if (bodyFat < 6) return 'Essential Fat';
//       if (bodyFat < 14) return 'Athletes';
//       if (bodyFat < 18) return 'Fitness';
//       if (bodyFat < 25) return 'Average';
//       return 'Obese';
//     } else {
//       if (bodyFat < 14) return 'Essential Fat';
//       if (bodyFat < 21) return 'Athletes';
//       if (bodyFat < 25) return 'Fitness';
//       if (bodyFat < 32) return 'Average';
//       return 'Obese';
//     }
//   }

//   Color getBodyFatColor(String category) {
//     switch (category) {
//       case 'Essential Fat':
//         return Colors.blue;
//       case 'Athletes':
//         return Colors.green;
//       case 'Fitness':
//         return Colors.lightGreen;
//       case 'Average':
//         return Colors.orange;
//       case 'Obese':
//         return Colors.red;
//       default:
//         return _primaryColor;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       appBar: AppBar(
//         title:
//             Text('Body Fat Calculator', style: TextStyle(color: _surfaceColor)),
//         backgroundColor: _primaryColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeaderCard(),
//             _buildInputSection(),
//             _buildResultSection(),
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
//       child: Column(
//         children: [
//           Text(
//             'Body Fat Calculator',
//             style: TextStyle(
//               color: _surfaceColor,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Estimate your body fat percentage based on measurements',
//             style: TextStyle(color: _surfaceColor.withOpacity(0.8)),
//             textAlign: TextAlign.center,
//           ),
//         ],
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
//           _buildGenderSelector(),
//           _buildSlider('Height (cm)', height, 100, 220,
//               (value) => setState(() => height = value)),
//           _buildSlider('Weight (kg)', weight, 30, 150,
//               (value) => setState(() => weight = value)),
//           _buildSlider('Waist (cm)', waist, 50, 150,
//               (value) => setState(() => waist = value)),
//           _buildSlider('Neck (cm)', neck, 20, 60,
//               (value) => setState(() => neck = value)),
//           if (!isMale)
//             _buildSlider('Hip (cm)', hip, 50, 150,
//                 (value) => setState(() => hip = value)),
//         ],
//       ),
//     );
//   }

//   Widget _buildGenderSelector() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildGenderButton(Icons.male, 'Male', isMale),
//         SizedBox(width: 20),
//         _buildGenderButton(Icons.female, 'Female', !isMale),
//       ],
//     );
//   }

//   Widget _buildGenderButton(IconData icon, String label, bool isSelected) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isMale = label == 'Male';
//           calculateBodyFat();
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: isSelected ? _primaryColor : _surfaceColor,
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: _primaryColor),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: isSelected ? _surfaceColor : _primaryColor),
//             SizedBox(width: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? _surfaceColor : _primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
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
//               child: Slider(
//                 value: value,
//                 min: min,
//                 max: max,
//                 activeColor: _primaryColor,
//                 inactiveColor: _primaryColor.withOpacity(0.2),
//                 onChanged: (newValue) {
//                   onChanged(newValue);
//                   calculateBodyFat();
//                 },
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
//           Text('Your Body Fat Percentage',
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
//                 painter: BodyFatGaugePainter(
//                   percentage: bodyFatPercentage,
//                   color: getBodyFatColor(bodyFatCategory),
//                   animation: _animation.value,
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Text(
//             '${bodyFatPercentage.toStringAsFixed(1)}%',
//             style: TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: getBodyFatColor(bodyFatCategory)),
//           ),
//           Text(
//             bodyFatCategory,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: getBodyFatColor(bodyFatCategory)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BodyFatGaugePainter extends CustomPainter {
//   final double percentage;
//   final Color color;
//   final double animation;

//   BodyFatGaugePainter(
//       {required this.percentage, required this.color, required this.animation});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     final startAngle = -math.pi / 2;
//     final sweepAngle = 2 * math.pi * (percentage / 100) * animation;
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 20.0
//       ..strokeCap = StrokeCap.round;

//     // Draw background arc
//     paint.color = Colors.grey.withOpacity(0.2);
//     canvas.drawArc(rect, startAngle, 2 * math.pi, false, paint);

//     // Draw percentage arc
//     paint.color = color;
//     canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

//     // Draw percentage text
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: '${(percentage * animation).toStringAsFixed(1)}%',
//         style:
//             TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(
//         canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  final Color _primaryColor = Color(0xFF1F1F1F);
  final Color _accentColor = Colors.purpleAccent;
  final Color _backgroundColor = Color(0xFF121212);
  final Color _surfaceColor = Color(0xFF2C2C2C);
  final Color _textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.only(
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
          SizedBox(height: 8),
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
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
        SizedBox(width: 20),
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _accentColor : _surfaceColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: _accentColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? _primaryColor : _accentColor),
            SizedBox(width: 8),
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
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
          SizedBox(height: 20),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(200, 200),
                painter: BodyFatGaugePainter(
                  percentage: bodyFatPercentage,
                  color: getBodyFatColor(bodyFatCategory),
                  animation: _animation.value,
                  backgroundColor: _surfaceColor,
                ),
              );
            },
          ),
          SizedBox(height: 20),
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

class BodyFatGaugePainter extends CustomPainter {
  final double percentage;
  final Color color;
  final double animation;
  final Color backgroundColor;

  BodyFatGaugePainter(
      {required this.percentage,
      required this.color,
      required this.animation,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * (percentage / 100) * animation;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round;

    // Draw background arc
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawArc(rect, startAngle, 2 * math.pi, false, paint);

    // Draw percentage arc
    paint.color = color;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw percentage text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(percentage * animation).toStringAsFixed(1)}%',
        style:
            TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

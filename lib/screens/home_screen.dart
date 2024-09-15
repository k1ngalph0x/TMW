//Original
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:tmw/screens/calorieintake_screen.dart';
// import '../database/database_helper.dart';
// import '../models/workout_model.dart';
// import '../provider/workout_provider.dart';
// import 'bmi_screen.dart';
// import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
// import 'bodyfat_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   Widget _buildStatItem(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color.fromRGBO(64, 130, 175, 1),
//           ),
//         ),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _loadWorkouts() async {
//     final workouts = await DatabaseHelper.instance.getWorkouts();
//     setState(() {
//       _savedWorkouts = workouts;
//     });
//   }

//   int _selectedIndex = 2;
//   List<String> _selectedWorkouts = [];
//   DateTime _selectedDateTime = DateTime.now();
//   List<Workout> _savedWorkouts = [];

//   List<String> _workoutlist = <String>[
//     'Chest',
//     'Shoulders',
//     'Abs',
//     'Hip',
//     'Legs',
//     'Calves',
//     'Cross-fit'
//   ];

//   final List<String> _navBarLabels = [
//     'Home',
//     'BMI',
//     'Add',
//     'Body Fat',
//     'Stats'
//   ];

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('MMMM d, y - h:mm a').format(dateTime);
//   }

//   void _refreshState() {
//     setState(() {
//       //rebuild
//     });
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     bool isSelected = _selectedIndex == index;
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//         if (index == 2) {
//           _showAddWorkoutBottomSheet(context);
//         } else if (index == 1) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BmiScreen()),
//           );
//         } else if (index == 3) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BodyFatCalculatorScreen()),
//           );
//         } else if (index == 4) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CalorieIntakeScreen()),
//           );
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
//     backgroundColor: Colors.red[700],
//     foregroundColor: Colors.white,
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   );

//   void _clearSelections() {
//     _selectedWorkouts.clear();
//     _selectedDateTime = DateTime.now();
//   }

//   Future<void> _selectDateTime(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDateTime,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//       );
//       if (pickedTime != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//         _refreshState();
//       }
//     }
//   }

//   void _showAddWorkoutBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//       ),
//       backgroundColor: Colors.white,
//       builder: (BuildContext context) {
//         return Consumer<WorkoutProvider>(
//           builder: (context, workoutProvider, child) {
//             return Container(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//                 left: 20,
//                 right: 20,
//                 top: 20,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 5,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2.5),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Add New Workout',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24.0,
//                       color: Color.fromRGBO(64, 130, 175, 1),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   MultiSelectDialogField(
//                     items:
//                         _workoutlist.map((e) => MultiSelectItem(e, e)).toList(),
//                     listType: MultiSelectListType.CHIP,
//                     onConfirm: (values) {
//                       workoutProvider
//                           .setSelectedWorkouts(values.cast<String>());
//                     },
//                     chipDisplay: MultiSelectChipDisplay(
//                       onTap: (value) {
//                         if (value != null) {
//                           workoutProvider.setSelectedWorkouts(
//                             workoutProvider.selectedWorkouts
//                                 .where((e) => e != value.toString())
//                                 .toList(),
//                           );
//                         }
//                       },
//                     ),
//                     title: Text("Select workouts"),
//                     selectedColor: Color.fromRGBO(64, 130, 175, 1),
//                     decoration: BoxDecoration(
//                       color: Color.fromRGBO(64, 130, 175, 0.1),
//                       borderRadius: BorderRadius.all(Radius.circular(40)),
//                       border: Border.all(
//                         color: Color.fromRGBO(64, 130, 175, 1),
//                         width: 2,
//                       ),
//                     ),
//                     buttonIcon: Icon(
//                       Icons.fitness_center,
//                       color: Color.fromRGBO(64, 130, 175, 1),
//                     ),
//                     buttonText: Text(
//                       "Select Workouts",
//                       style: TextStyle(
//                         color: Color.fromRGBO(64, 130, 175, 1),
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.calendar_today),
//                     label: Text('Select Date and Time'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromRGBO(64, 130, 175, 1),
//                       foregroundColor: Colors.white,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () async {
//                       final DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: workoutProvider.selectedDateTime,
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (pickedDate != null) {
//                         final TimeOfDay? pickedTime = await showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay.fromDateTime(
//                               workoutProvider.selectedDateTime),
//                         );
//                         if (pickedTime != null) {
//                           workoutProvider.setSelectedDateTime(DateTime(
//                             pickedDate.year,
//                             pickedDate.month,
//                             pickedDate.day,
//                             pickedTime.hour,
//                             pickedTime.minute,
//                           ));
//                         }
//                       }
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Selected Date and Time:',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     _formatDateTime(workoutProvider.selectedDateTime),
//                     style: TextStyle(
//                         fontSize: 16, color: Color.fromRGBO(64, 130, 175, 1)),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromRGBO(64, 130, 175, 1),
//                       foregroundColor: Colors.white,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () async {
//                       if (workoutProvider.selectedWorkouts.isNotEmpty) {
//                         final workout = Workout(
//                           dateTime: workoutProvider.selectedDateTime,
//                           exercises:
//                               List.from(workoutProvider.selectedWorkouts),
//                         );
//                         await workoutProvider.addWorkout(workout);
//                         workoutProvider.clearSelections();
//                         Navigator.pop(context);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                               content:
//                                   Text('Please select at least one workout')),
//                         );
//                       }
//                     },
//                     child: Text('Save Workout'),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: PreferredSize(
//       //   preferredSize: Size.fromHeight(100.0),
//       //   child: AppBar(
//       //     backgroundColor: Color.fromRGBO(64, 130, 175, 1),
//       //     centerTitle: true, // This centers the title
//       //     title: const Text(
//       //       'T M W',
//       //       style: TextStyle(
//       //         color: Colors.white,
//       //         fontWeight: FontWeight.bold,
//       //         fontSize: 25.0,
//       //       ),
//       //     ),
//       //     elevation: 10.0,
//       //   ),
//       // ),
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
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'TMW',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 32.0,
//                       letterSpacing: 3.0,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Track My Workout',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Consumer<WorkoutProvider>(
//         builder: (context, workoutProvider, child) {
//           return Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.all(16),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'This Week\'s Progress',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildStatItem('Workouts', '5'),
//                         _buildStatItem('Minutes', '180'),
//                         _buildStatItem('Calories', '500'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: workoutProvider.workouts.length,
//                   itemBuilder: (context, index) {
//                     final workout = workoutProvider.workouts[index];
//                     return Dismissible(
//                       key: Key(workout.dateTime.toIso8601String()),
//                       background: Container(
//                         color: Colors.red,
//                         alignment: Alignment.centerRight,
//                         padding: EdgeInsets.only(right: 20.0),
//                         child: Icon(Icons.delete, color: Colors.white),
//                       ),
//                       secondaryBackground: Container(
//                         color: Colors.red,
//                         alignment: Alignment.centerLeft,
//                         padding: EdgeInsets.only(left: 20.0),
//                         child: Icon(Icons.delete, color: Colors.white),
//                       ),
//                       confirmDismiss: (direction) async {
//                         return await showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text("Confirm"),
//                               content: const Text(
//                                   "Are you sure you want to delete this workout?"),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () =>
//                                       Navigator.of(context).pop(false),
//                                   child: const Text("CANCEL"),
//                                 ),
//                                 TextButton(
//                                   onPressed: () =>
//                                       Navigator.of(context).pop(true),
//                                   child: const Text("DELETE"),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       onDismissed: (direction) async {
//                         await workoutProvider.deleteWorkout(workout.id!);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Workout deleted')),
//                         );
//                       },
//                       child: Card(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ListTile(
//                           contentPadding: EdgeInsets.all(16),
//                           leading: CircleAvatar(
//                             backgroundColor: Color.fromRGBO(64, 130, 175, 1),
//                             child:
//                                 Icon(Icons.fitness_center, color: Colors.white),
//                           ),
//                           title: Text(
//                             DateFormat('EEEE, MMM d').format(workout.dateTime),
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             workout.exercises.join(', '),
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                           trailing: Icon(Icons.chevron_right,
//                               color: Color.fromRGBO(64, 130, 175, 1)),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(64, 130, 175, 1),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: Offset(0, -5),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem(Icons.home, 'Home', 0),
//                 _buildNavItem(Icons.sports_gymnastics, 'BMI', 1),
//                 _buildNavItem(Icons.add, 'Add', 2),
//                 _buildNavItem(Icons.percent, 'Body Fat', 3),
//                 _buildNavItem(Icons.bar_chart, 'Stats', 4),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//Overhaul
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../provider/workout_provider.dart';
// import '../models/workout_model.dart';
// import 'bmi_screen.dart';
// import 'bodyfat_screen.dart';
// import 'calorieintake_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 30, color: Color(0xFF6200EE)),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF6200EE)),
//             ),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutList() {
//     return Consumer<WorkoutProvider>(
//       builder: (context, workoutProvider, child) {
//         if (workoutProvider.workouts.isEmpty) {
//           return Center(child: Text('No workouts yet. Start by adding one!'));
//         }
//         return ListView.builder(
//           itemCount: workoutProvider.workouts.length,
//           itemBuilder: (context, index) {
//             final workout = workoutProvider.workouts[index];
//             return _buildWorkoutCard(workout);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildWorkoutCard(Workout workout) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: Color(0xFF6200EE),
//           child: Icon(Icons.fitness_center, color: Colors.white),
//         ),
//         title: Text(
//           DateFormat('EEEE, MMM d').format(workout.dateTime),
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           workout.exercises.join(', '),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => _showDeleteConfirmation(workout),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(Workout workout) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Delete"),
//           content: Text("Are you sure you want to delete this workout?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text("Delete"),
//               onPressed: () {
//                 Provider.of<WorkoutProvider>(context, listen: false)
//                     .deleteWorkout(workout.id!);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildProgressChart() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 1),
//                 FlSpot(2, 4),
//                 FlSpot(3, 2),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: Color(0xFF6200EE),
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                   show: true, color: Color(0xFF6200EE).withOpacity(0.2)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddWorkoutBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: AddWorkoutForm(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 200.0,
//               floating: false,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text('TMW', style: TextStyle(color: Colors.white)),
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Color(0xFF6200EE), Color(0xFF3700B3)],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'This Week\'s Progress',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildStatCard('Workouts', '5', Icons.fitness_center),
//                         _buildStatCard('Minutes', '180', Icons.timer),
//                         _buildStatCard(
//                             'Calories', '500', Icons.local_fire_department),
//                       ],
//                     ),
//                     SizedBox(height: 24),
//                     Text(
//                       'Progress Chart',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     _buildProgressChart(),
//                     SizedBox(height: 24),
//                     TabBar(
//                       controller: _tabController,
//                       labelColor: Color(0xFF6200EE),
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [
//                         Tab(text: 'Workouts'),
//                         Tab(text: 'Statistics'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverFillRemaining(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildWorkoutList(),
//                   Center(child: Text('Statistics coming soon!')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddWorkoutBottomSheet,
//         child: Icon(Icons.add),
//         backgroundColor: Color(0xFF6200EE),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color(0xFF6200EE),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 1:
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => BmiScreen()));
//               break;
//             case 2:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => BodyFatCalculatorScreen()));
//               break;
//             case 3:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CalorieIntakeScreen()));
//               break;
//           }
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'BMI'),
//           BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Body Fat'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fastfood), label: 'Calories'),
//         ],
//       ),
//     );
//   }
// }

// class AddWorkoutForm extends StatefulWidget {
//   @override
//   _AddWorkoutFormState createState() => _AddWorkoutFormState();
// }

// class _AddWorkoutFormState extends State<AddWorkoutForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _selectedExercises = [];
//   DateTime _selectedDateTime = DateTime.now();

//   final List<String> _exerciseList = [
//     'Chest',
//     'Shoulders',
//     'Abs',
//     'Hip',
//     'Legs',
//     'Calves',
//     'Cross-fit'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Add New Workout',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF6200EE)),
//             ),
//             SizedBox(height: 16),
//             Wrap(
//               spacing: 8.0,
//               children: _exerciseList.map((exercise) {
//                 return FilterChip(
//                   label: Text(exercise),
//                   selected: _selectedExercises.contains(exercise),
//                   onSelected: (selected) {
//                     setState(() {
//                       if (selected) {
//                         _selectedExercises.add(exercise);
//                       } else {
//                         _selectedExercises.remove(exercise);
//                       }
//                     });
//                   },
//                   selectedColor: Color(0xFF6200EE).withOpacity(0.2),
//                   checkmarkColor: Color(0xFF6200EE),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             ListTile(
//               title: Text('Date and Time'),
//               subtitle: Text(
//                   DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime)),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () async {
//                 final DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: _selectedDateTime,
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   final TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//                   );
//                   if (pickedTime != null) {
//                     setState(() {
//                       _selectedDateTime = DateTime(
//                         pickedDate.year,
//                         pickedDate.month,
//                         pickedDate.day,
//                         pickedTime.hour,
//                         pickedTime.minute,
//                       );
//                     });
//                   }
//                 }
//               },
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               child: Text('Save Workout'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF6200EE),
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               ),
//               onPressed: () {
//                 if (_formKey.currentState!.validate() &&
//                     _selectedExercises.isNotEmpty) {
//                   final workout = Workout(
//                     dateTime: _selectedDateTime,
//                     exercises: _selectedExercises,
//                   );
//                   Provider.of<WorkoutProvider>(context, listen: false)
//                       .addWorkout(workout);
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Please select at least one exercise')),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////
///
///
///
///
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../provider/workout_provider.dart';
// import '../models/workout_model.dart';
// import 'bmi_screen.dart';
// import 'bodyfat_screen.dart';
// import 'calorieintake_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   // New color scheme
//   final Color _primaryColor = Color(0xFF00B4D8);
//   final Color _accentColor = Color(0xFFFFB703);
//   final Color _backgroundColor = Color(0xFFF8F9FA);
//   final Color _textColor = Color(0xFF023047);

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       color: _backgroundColor,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 30, color: _primaryColor),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: _primaryColor),
//             ),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: _textColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutList() {
//     return Consumer<WorkoutProvider>(
//       builder: (context, workoutProvider, child) {
//         if (workoutProvider.workouts.isEmpty) {
//           return Center(
//               child: Text('No workouts yet. Start by adding one!',
//                   style: TextStyle(color: _textColor)));
//         }
//         return ListView.builder(
//           itemCount: workoutProvider.workouts.length,
//           itemBuilder: (context, index) {
//             final workout = workoutProvider.workouts[index];
//             return _buildWorkoutCard(workout);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildWorkoutCard(Workout workout) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       color: _backgroundColor,
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: _primaryColor,
//           child: Icon(Icons.fitness_center, color: Colors.white),
//         ),
//         title: Text(
//           DateFormat('EEEE, MMM d').format(workout.dateTime),
//           style: TextStyle(fontWeight: FontWeight.bold, color: _textColor),
//         ),
//         subtitle: Text(
//           workout.exercises.join(', '),
//           style: TextStyle(color: _textColor.withOpacity(0.7)),
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => _showDeleteConfirmation(workout),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(Workout workout) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Delete"),
//           content: Text("Are you sure you want to delete this workout?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel", style: TextStyle(color: _primaryColor)),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text("Delete", style: TextStyle(color: Colors.red)),
//               onPressed: () {
//                 Provider.of<WorkoutProvider>(context, listen: false)
//                     .deleteWorkout(workout.id!);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildProgressChart() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 1),
//                 FlSpot(2, 4),
//                 FlSpot(3, 2),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: _primaryColor,
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                   show: true, color: _primaryColor.withOpacity(0.2)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddWorkoutBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: BoxDecoration(
//           color: _backgroundColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: AddWorkoutForm(
//           primaryColor: _primaryColor,
//           accentColor: _accentColor,
//           textColor: _textColor,
//           backgroundColor: _backgroundColor,
//         ),
//       ),
//     );
//   }

//   Widget _buildEnhancedAppBar() {
//     return SliverAppBar(
//       expandedHeight: 200.0,
//       floating: false,
//       pinned: true,
//       backgroundColor: _primaryColor,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [_primaryColor, _accentColor],
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 'TMW',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Track My Workout',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.8),
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildMiniStatCard('5', 'Workouts'),
//                   _buildMiniStatCard('180', 'Minutes'),
//                   _buildMiniStatCard('500', 'Calories'),
//                 ],
//               ),
//               SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMiniStatCard(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.8),
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _backgroundColor,
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             _buildEnhancedAppBar(),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Progress Chart',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: _textColor),
//                     ),
//                     _buildProgressChart(),
//                     SizedBox(height: 24),
//                     TabBar(
//                       controller: _tabController,
//                       labelColor: _primaryColor,
//                       unselectedLabelColor: _textColor.withOpacity(0.5),
//                       indicatorColor: _primaryColor,
//                       tabs: [
//                         Tab(text: 'Workouts'),
//                         Tab(text: 'Statistics'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverFillRemaining(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildWorkoutList(),
//                   Center(
//                       child: Text('Statistics coming soon!',
//                           style: TextStyle(color: _textColor))),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddWorkoutBottomSheet,
//         child: Icon(Icons.add),
//         backgroundColor: _accentColor,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: _primaryColor,
//         unselectedItemColor: _textColor.withOpacity(0.5),
//         backgroundColor: _backgroundColor,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 1:
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => BmiScreen()));
//               break;
//             case 2:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => BodyFatCalculatorScreen()));
//               break;
//             case 3:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CalorieIntakeScreen()));
//               break;
//           }
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'BMI'),
//           BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Body Fat'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fastfood), label: 'Calories'),
//         ],
//       ),
//     );
//   }
// }

// class AddWorkoutForm extends StatefulWidget {
//   final Color primaryColor;
//   final Color accentColor;
//   final Color textColor;
//   final Color backgroundColor;

//   AddWorkoutForm({
//     required this.primaryColor,
//     required this.accentColor,
//     required this.textColor,
//     required this.backgroundColor,
//   });

//   @override
//   _AddWorkoutFormState createState() => _AddWorkoutFormState();
// }

// class _AddWorkoutFormState extends State<AddWorkoutForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _selectedExercises = [];
//   DateTime _selectedDateTime = DateTime.now();

//   final List<String> _exerciseList = [
//     'Chest',
//     'Shoulders',
//     'Abs',
//     'Hip',
//     'Legs',
//     'Calves',
//     'Cross-fit'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: widget.backgroundColor,
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Add New Workout',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: widget.primaryColor,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Select Exercises',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: widget.textColor,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: _exerciseList.map((exercise) {
//                   return FilterChip(
//                     label: Text(
//                       exercise,
//                       style: TextStyle(
//                         color: _selectedExercises.contains(exercise)
//                             ? Colors.white
//                             : widget.textColor,
//                       ),
//                     ),
//                     selected: _selectedExercises.contains(exercise),
//                     onSelected: (selected) {
//                       setState(() {
//                         if (selected) {
//                           _selectedExercises.add(exercise);
//                         } else {
//                           _selectedExercises.remove(exercise);
//                         }
//                       });
//                     },
//                     selectedColor: widget.accentColor,
//                     backgroundColor: widget.backgroundColor,
//                     checkmarkColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(color: widget.accentColor),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Date and Time',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: widget.textColor,
//                 ),
//               ),
//               SizedBox(height: 10),
//               InkWell(
//                 onTap: () async {
//                   final DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: _selectedDateTime,
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                     builder: (BuildContext context, Widget? child) {
//                       return Theme(
//                         data: ThemeData.light().copyWith(
//                           primaryColor: widget.primaryColor,
//                           colorScheme:
//                               ColorScheme.light(primary: widget.primaryColor),
//                           buttonTheme: ButtonThemeData(
//                               textTheme: ButtonTextTheme.primary),
//                         ),
//                         child: child!,
//                       );
//                     },
//                   );
//                   if (pickedDate != null) {
//                     final TimeOfDay? pickedTime = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//                       builder: (BuildContext context, Widget? child) {
//                         return Theme(
//                           data: ThemeData.light().copyWith(
//                             primaryColor: widget.primaryColor,
//                             colorScheme:
//                                 ColorScheme.light(primary: widget.primaryColor),
//                             buttonTheme: ButtonThemeData(
//                                 textTheme: ButtonTextTheme.primary),
//                           ),
//                           child: child!,
//                         );
//                       },
//                     );
//                     if (pickedTime != null) {
//                       setState(() {
//                         _selectedDateTime = DateTime(
//                           pickedDate.year,
//                           pickedDate.month,
//                           pickedDate.day,
//                           pickedTime.hour,
//                           pickedTime.minute,
//                         );
//                       });
//                     }
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: widget.accentColor),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         DateFormat('yyyy-MM-dd – kk:mm')
//                             .format(_selectedDateTime),
//                         style: TextStyle(color: widget.textColor, fontSize: 16),
//                       ),
//                       Icon(Icons.calendar_today, color: widget.accentColor),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   child: Text('Save Workout'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: widget.accentColor,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate() &&
//                         _selectedExercises.isNotEmpty) {
//                       final workout = Workout(
//                         dateTime: _selectedDateTime,
//                         exercises: _selectedExercises,
//                       );
//                       Provider.of<WorkoutProvider>(context, listen: false)
//                           .addWorkout(workout);
//                       Navigator.pop(context);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please select at least one exercise'),
//                           backgroundColor: widget.primaryColor,
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//OKish
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../provider/workout_provider.dart';
// import '../models/workout_model.dart';
// import 'bmi_screen.dart';
// import 'bodyfat_screen.dart';
// import 'calorieintake_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 30, color: Color(0xFF6200EE)),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF6200EE)),
//             ),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutList() {
//     return Consumer<WorkoutProvider>(
//       builder: (context, workoutProvider, child) {
//         if (workoutProvider.workouts.isEmpty) {
//           return Center(child: Text('No workouts yet. Start by adding one!'));
//         }
//         return ListView.builder(
//           itemCount: workoutProvider.workouts.length,
//           itemBuilder: (context, index) {
//             final workout = workoutProvider.workouts[index];
//             return _buildWorkoutCard(workout);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildWorkoutCard(Workout workout) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: Color(0xFF6200EE),
//           child: Icon(Icons.fitness_center, color: Colors.white),
//         ),
//         title: Text(
//           DateFormat('EEEE, MMM d').format(workout.dateTime),
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           workout.exercises.join(', '),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => _showDeleteConfirmation(workout),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(Workout workout) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Delete"),
//           content: Text("Are you sure you want to delete this workout?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text("Delete"),
//               onPressed: () {
//                 Provider.of<WorkoutProvider>(context, listen: false)
//                     .deleteWorkout(workout.id!);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildProgressChart() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 1),
//                 FlSpot(2, 4),
//                 FlSpot(3, 2),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: Color(0xFF6200EE),
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                   show: true, color: Color(0xFF6200EE).withOpacity(0.2)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddWorkoutBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: AddWorkoutForm(),
//       ),
//     );
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: SafeArea(
//   //       child: CustomScrollView(
//   //         slivers: [
//   //           SliverAppBar(
//   //             expandedHeight: 200.0,
//   //             floating: false,
//   //             pinned: true,
//   //             flexibleSpace: FlexibleSpaceBar(
//   //               title: Text(
//   //                 'TMW',
//   //                 style: TextStyle(color: Colors.white),
//   //               ),
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: Colors.grey[100],
//   //     body: SafeArea(
//   //       child: CustomScrollView(
//   //         slivers: [
//   //           SliverAppBar(
//   //             expandedHeight: 120.0,
//   //             floating: false,
//   //             pinned: true,
//   //             backgroundColor: Color(0xFF1E88E5),
//   //             elevation: 0,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.vertical(
//   //                 bottom: Radius.circular(30),
//   //               ),
//   //             ),
//   //             flexibleSpace: FlexibleSpaceBar(
//   //               centerTitle: true,
//   //               title: Text(
//   //                 'TMW',
//   //                 style: TextStyle(
//   //                   color: Colors.black87,
//   //                   fontWeight: FontWeight.bold,
//   //                   fontSize: 24,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //           //     background: Container(
//   //           //       decoration: BoxDecoration(color: Colors.purple[400]
//   //           //           // gradient: LinearGradient(
//   //           //           //   begin: Alignment.topLeft,
//   //           //           //   end: Alignment.bottomRight,
//   //           //           //   colors: [Color(0xFF6200EE), Color(0xFF3700B3)],
//   //           //           // ),
//   //           //           ),
//   //           //     ),
//   //           //   ),
//   //           // ),

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 200.0,
//               floating: false,
//               pinned: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
//                     ),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                   ),
//                 ),
//                 centerTitle: true,
//                 title: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'TMW',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 28,
//                       ),
//                     ),
//                     Text(
//                       'Track My Workout',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ],
//                 ),
//                 titlePadding: EdgeInsets.only(bottom: 16),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'This Week\'s Progress',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildStatCard('Workouts', '5', Icons.fitness_center),
//                         _buildStatCard('Minutes', '180', Icons.timer),
//                         _buildStatCard(
//                             'Calories', '500', Icons.local_fire_department),
//                       ],
//                     ),
//                     SizedBox(height: 24),
//                     Text(
//                       'Progress Chart',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     _buildProgressChart(),
//                     SizedBox(height: 24),
//                     TabBar(
//                       controller: _tabController,
//                       labelColor: Color(0xFF6200EE),
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [
//                         Tab(text: 'Workouts'),
//                         Tab(text: 'Statistics'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverFillRemaining(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildWorkoutList(),
//                   Center(child: Text('Statistics coming soon!')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddWorkoutBottomSheet,
//         child: Icon(Icons.add),
//         backgroundColor: Color(0xFF6200EE),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color(0xFF6200EE),
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           switch (index) {
//             case 1:
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => BmiScreen()));
//               break;
//             case 2:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => BodyFatCalculatorScreen()));
//               break;
//             case 3:
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CalorieIntakeScreen()));
//               break;
//           }
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'BMI'),
//           BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Body Fat'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.fastfood), label: 'Calories'),
//         ],
//       ),
//     );
//   }
// }

// class AddWorkoutForm extends StatefulWidget {
//   @override
//   _AddWorkoutFormState createState() => _AddWorkoutFormState();
// }

// class _AddWorkoutFormState extends State<AddWorkoutForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _selectedExercises = [];
//   DateTime _selectedDateTime = DateTime.now();

//   final List<String> _exerciseList = [
//     'Chest',
//     'Shoulders',
//     'Abs',
//     'Hip',
//     'Legs',
//     'Calves',
//     'Cross-fit'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Add New Workout',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF6200EE)),
//             ),
//             SizedBox(height: 16),
//             Wrap(
//               spacing: 8.0,
//               children: _exerciseList.map((exercise) {
//                 return FilterChip(
//                   label: Text(exercise),
//                   selected: _selectedExercises.contains(exercise),
//                   onSelected: (selected) {
//                     setState(() {
//                       if (selected) {
//                         _selectedExercises.add(exercise);
//                       } else {
//                         _selectedExercises.remove(exercise);
//                       }
//                     });
//                   },
//                   selectedColor: Color(0xFF6200EE).withOpacity(0.2),
//                   checkmarkColor: Color(0xFF6200EE),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             ListTile(
//               title: Text('Date and Time'),
//               subtitle: Text(
//                   DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime)),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () async {
//                 final DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: _selectedDateTime,
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   final TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//                   );
//                   if (pickedTime != null) {
//                     setState(() {
//                       _selectedDateTime = DateTime(
//                         pickedDate.year,
//                         pickedDate.month,
//                         pickedDate.day,
//                         pickedTime.hour,
//                         pickedTime.minute,
//                       );
//                     });
//                   }
//                 }
//               },
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               child: Text('Save Workout'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF6200EE),
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               ),
//               onPressed: () {
//                 if (_formKey.currentState!.validate() &&
//                     _selectedExercises.isNotEmpty) {
//                   final workout = Workout(
//                     dateTime: _selectedDateTime,
//                     exercises: _selectedExercises,
//                   );
//                   Provider.of<WorkoutProvider>(context, listen: false)
//                       .addWorkout(workout);
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Please select at least one exercise')),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//Great
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../provider/workout_provider.dart';
// import '../models/workout_model.dart';
// import 'bmi_screen.dart';
// import 'bodyfat_screen.dart';
// import 'calorieintake_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       color: Color(0xFF2C2C2C),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 30, color: Colors.purpleAccent),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: Colors.grey[400]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutList() {
//     return Consumer<WorkoutProvider>(
//       builder: (context, workoutProvider, child) {
//         if (workoutProvider.workouts.isEmpty) {
//           return Center(child: Text('No workouts yet. Start by adding one!'));
//         }
//         return ListView.builder(
//           itemCount: workoutProvider.workouts.length,
//           itemBuilder: (context, index) {
//             final workout = workoutProvider.workouts[index];
//             return _buildWorkoutCard(workout);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildWorkoutCard(Workout workout) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: Color(0xFF6200EE),
//           child: Icon(Icons.fitness_center, color: Colors.white),
//         ),
//         title: Text(
//           DateFormat('EEEE, MMM d').format(workout.dateTime),
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           workout.exercises.join(', '),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => _showDeleteConfirmation(workout),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(Workout workout) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Delete"),
//           content: Text("Are you sure you want to delete this workout?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text("Delete"),
//               onPressed: () {
//                 Provider.of<WorkoutProvider>(context, listen: false)
//                     .deleteWorkout(workout.id!);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildProgressChart() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 1),
//                 FlSpot(2, 4),
//                 FlSpot(3, 2),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: Color(0xFF6200EE),
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                   show: true, color: Color(0xFF6200EE).withOpacity(0.2)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddWorkoutBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: AddWorkoutForm(),
//       ),
//     );
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: SafeArea(
//   //       child: CustomScrollView(
//   //         slivers: [
//   //           SliverAppBar(
//   //             expandedHeight: 200.0,
//   //             floating: false,
//   //             pinned: true,
//   //             flexibleSpace: FlexibleSpaceBar(
//   //               title: Text(
//   //                 'TMW',
//   //                 style: TextStyle(color: Colors.white),
//   //               ),
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: Colors.grey[100],
//   //     body: SafeArea(
//   //       child: CustomScrollView(
//   //         slivers: [
//   //           SliverAppBar(
//   //             expandedHeight: 120.0,
//   //             floating: false,
//   //             pinned: true,
//   //             backgroundColor: Color(0xFF1E88E5),
//   //             elevation: 0,
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.vertical(
//   //                 bottom: Radius.circular(30),
//   //               ),
//   //             ),
//   //             flexibleSpace: FlexibleSpaceBar(
//   //               centerTitle: true,
//   //               title: Text(
//   //                 'TMW',
//   //                 style: TextStyle(
//   //                   color: Colors.black87,
//   //                   fontWeight: FontWeight.bold,
//   //                   fontSize: 24,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //           //     background: Container(
//   //           //       decoration: BoxDecoration(color: Colors.purple[400]
//   //           //           // gradient: LinearGradient(
//   //           //           //   begin: Alignment.topLeft,
//   //           //           //   end: Alignment.bottomRight,
//   //           //           //   colors: [Color(0xFF6200EE), Color(0xFF3700B3)],
//   //           //           // ),
//   //           //           ),
//   //           //     ),
//   //           //   ),
//   //           // ),

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[100],
// //       body: SafeArea(
// //         child: CustomScrollView(
// //           slivers: [
// //             SliverAppBar(
// //               expandedHeight: 200.0,
// //               floating: false,
// //               pinned: true,
// //               backgroundColor: Colors.transparent,
// //               elevation: 0,
// //               flexibleSpace: FlexibleSpaceBar(
// //                 background: Container(
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                       colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
// //                     ),
// //                     borderRadius: BorderRadius.only(
// //                       bottomLeft: Radius.circular(30),
// //                       bottomRight: Radius.circular(30),
// //                     ),
// //                   ),
// //                 ),
// //                 centerTitle: true,
// //                 title: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       'TMW',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 28,
// //                       ),
// //                     ),
// //                     Text(
// //                       'Track My Workout',
// //                       style: TextStyle(
// //                         color: Colors.white70,
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w300,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 titlePadding: EdgeInsets.only(bottom: 16),
// //               ),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.only(
// //                   bottomLeft: Radius.circular(30),
// //                   bottomRight: Radius.circular(30),
// //                 ),
// //               ),
// //             ),
// //             SliverToBoxAdapter(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       'This Week\'s Progress',
// //                       style:
// //                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                     ),
// //                     SizedBox(height: 16),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                       children: [
// //                         _buildStatCard('Workouts', '5', Icons.fitness_center),
// //                         _buildStatCard('Minutes', '180', Icons.timer),
// //                         _buildStatCard(
// //                             'Calories', '500', Icons.local_fire_department),
// //                       ],
// //                     ),
// //                     SizedBox(height: 24),
// //                     Text(
// //                       'Progress Chart',
// //                       style:
// //                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                     ),
// //                     _buildProgressChart(),
// //                     SizedBox(height: 24),
// //                     TabBar(
// //                       controller: _tabController,
// //                       labelColor: Color(0xFF6200EE),
// //                       unselectedLabelColor: Colors.grey,
// //                       tabs: [
// //                         Tab(text: 'Workouts'),
// //                         Tab(text: 'Statistics'),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SliverFillRemaining(
// //               child: TabBarView(
// //                 controller: _tabController,
// //                 children: [
// //                   _buildWorkoutList(),
// //                   Center(child: Text('Statistics coming soon!')),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _showAddWorkoutBottomSheet,
// //         child: Icon(Icons.add),
// //         backgroundColor: Color(0xFF6200EE),
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Color(0xFF6200EE),
// //         unselectedItemColor: Colors.grey,
// //         onTap: (index) {
// //           setState(() {
// //             _selectedIndex = index;
// //           });
// //           switch (index) {
// //             case 1:
// //               Navigator.push(context,
// //                   MaterialPageRoute(builder: (context) => BmiScreen()));
// //               break;
// //             case 2:
// //               Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                       builder: (context) => BodyFatCalculatorScreen()));
// //               break;
// //             case 3:
// //               Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                       builder: (context) => CalorieIntakeScreen()));
// //               break;
// //           }
// //         },
// //         items: [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// //           BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'BMI'),
// //           BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Body Fat'),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.fastfood), label: 'Calories'),
// //         ],
// //       ),
// //     );
// //   }
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark().copyWith(
//         primaryColor: Color(0xFF1F1F1F),
//         scaffoldBackgroundColor: Color(0xFF121212),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Color(0xFF1F1F1F),
//           elevation: 0,
//         ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: Color(0xFF1F1F1F),
//           selectedItemColor: Colors.purpleAccent,
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 expandedHeight: 120.0,
//                 floating: false,
//                 pinned: true,
//                 centerTitle: true,
//                 title: Text(
//                   'TMW',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28,
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'This Week\'s Progress',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildStatCard('Workouts', '5', Icons.fitness_center),
//                           _buildStatCard('Minutes', '180', Icons.timer),
//                           _buildStatCard(
//                               'Calories', '500', Icons.local_fire_department),
//                         ],
//                       ),
//                       SizedBox(height: 24),
//                       Text(
//                         'Progress Chart',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       _buildProgressChart(),
//                       SizedBox(height: 24),
//                       TabBar(
//                         controller: _tabController,
//                         labelColor: Colors.purpleAccent,
//                         unselectedLabelColor: Colors.grey,
//                         tabs: [
//                           Tab(text: 'Workouts'),
//                           Tab(text: 'Statistics'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverFillRemaining(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildWorkoutList(),
//                     Center(
//                         child: Text('Statistics coming soon!',
//                             style: TextStyle(color: Colors.white))),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _showAddWorkoutBottomSheet,
//           child: Icon(Icons.add),
//           backgroundColor: Colors.purpleAccent,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 8.0,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               IconButton(icon: Icon(Icons.home), onPressed: () {}),
//               IconButton(
//                 icon: Icon(Icons.calculate),
//                 onPressed: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => BmiScreen())),
//               ),
//               SizedBox(width: 48),
//               IconButton(
//                 icon: Icon(Icons.percent),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => BodyFatCalculatorScreen())),
//               ),
//               IconButton(
//                 icon: Icon(Icons.fastfood),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CalorieIntakeScreen())),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddWorkoutForm extends StatefulWidget {
//   @override
//   _AddWorkoutFormState createState() => _AddWorkoutFormState();
// }

// class _AddWorkoutFormState extends State<AddWorkoutForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _selectedExercises = [];
//   DateTime _selectedDateTime = DateTime.now();

//   final List<String> _exerciseList = [
//     'Chest',
//     'Shoulders',
//     'Abs',
//     'Hip',
//     'Legs',
//     'Calves',
//     'Cross-fit'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Add New Workout',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF6200EE)),
//             ),
//             SizedBox(height: 16),
//             Wrap(
//               spacing: 8.0,
//               children: _exerciseList.map((exercise) {
//                 return FilterChip(
//                   label: Text(exercise),
//                   selected: _selectedExercises.contains(exercise),
//                   onSelected: (selected) {
//                     setState(() {
//                       if (selected) {
//                         _selectedExercises.add(exercise);
//                       } else {
//                         _selectedExercises.remove(exercise);
//                       }
//                     });
//                   },
//                   selectedColor: Color(0xFF6200EE).withOpacity(0.2),
//                   checkmarkColor: Color(0xFF6200EE),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             ListTile(
//               title: Text('Date and Time'),
//               subtitle: Text(
//                   DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime)),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () async {
//                 final DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: _selectedDateTime,
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   final TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//                   );
//                   if (pickedTime != null) {
//                     setState(() {
//                       _selectedDateTime = DateTime(
//                         pickedDate.year,
//                         pickedDate.month,
//                         pickedDate.day,
//                         pickedTime.hour,
//                         pickedTime.minute,
//                       );
//                     });
//                   }
//                 }
//               },
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               child: Text('Save Workout'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF6200EE),
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               ),
//               onPressed: () {
//                 if (_formKey.currentState!.validate() &&
//                     _selectedExercises.isNotEmpty) {
//                   final workout = Workout(
//                     dateTime: _selectedDateTime,
//                     exercises: _selectedExercises,
//                   );
//                   Provider.of<WorkoutProvider>(context, listen: false)
//                       .addWorkout(workout);
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content: Text('Please select at least one exercise')),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/////////////////
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../provider/workout_provider.dart';
// import '../models/workout_model.dart';
// import 'bmi_screen.dart';
// import 'bodyfat_screen.dart';
// import 'calorieintake_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       color: Color(0xFF2C2C2C),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 30, color: Colors.purpleAccent),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: Colors.grey[400]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutList() {
//     return Consumer<WorkoutProvider>(
//       builder: (context, workoutProvider, child) {
//         if (workoutProvider.workouts.isEmpty) {
//           return Center(child: Text('No workouts yet. Start by adding one!'));
//         }
//         return ListView.builder(
//           itemCount: workoutProvider.workouts.length,
//           itemBuilder: (context, index) {
//             final workout = workoutProvider.workouts[index];
//             return _buildWorkoutCard(workout);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildWorkoutCard(Workout workout) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: Color(0xFF6200EE),
//           child: Icon(Icons.fitness_center, color: Colors.white),
//         ),
//         title: Text(
//           DateFormat('EEEE, MMM d').format(workout.dateTime),
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           workout.exercises.join(', '),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => _showDeleteConfirmation(workout),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(Workout workout) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm Delete"),
//           content: Text("Are you sure you want to delete this workout?"),
//           actions: [
//             TextButton(
//               child: Text("Cancel"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: Text("Delete"),
//               onPressed: () {
//                 Provider.of<WorkoutProvider>(context, listen: false)
//                     .deleteWorkout(workout.id!);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildProgressChart() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 1),
//                 FlSpot(2, 4),
//                 FlSpot(3, 2),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: Color(0xFF6200EE),
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                   show: true, color: Color(0xFF6200EE).withOpacity(0.2)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddWorkoutBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: AddWorkoutForm(),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark().copyWith(
//         primaryColor: Color(0xFF1F1F1F),
//         scaffoldBackgroundColor: Color(0xFF121212),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Color(0xFF1F1F1F),
//           elevation: 0,
//         ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: Color(0xFF1F1F1F),
//           selectedItemColor: Colors.purpleAccent,
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 expandedHeight: 120.0,
//                 floating: false,
//                 pinned: true,
//                 centerTitle: true,
//                 title: Text(
//                   'TMW',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28,
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'This Week\'s Progress',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildStatCard('Workouts', '5', Icons.fitness_center),
//                           _buildStatCard('Minutes', '180', Icons.timer),
//                           _buildStatCard(
//                               'Calories', '500', Icons.local_fire_department),
//                         ],
//                       ),
//                       SizedBox(height: 24),
//                       Text(
//                         'Progress Chart',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       _buildProgressChart(),
//                       SizedBox(height: 24),
//                       TabBar(
//                         controller: _tabController,
//                         labelColor: Colors.purpleAccent,
//                         unselectedLabelColor: Colors.grey,
//                         tabs: [
//                           Tab(text: 'Workouts'),
//                           Tab(text: 'Statistics'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverFillRemaining(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildWorkoutList(),
//                     Center(
//                         child: Text('Statistics coming soon!',
//                             style: TextStyle(color: Colors.white))),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _showAddWorkoutBottomSheet,
//           child: Icon(Icons.add),
//           backgroundColor: Colors.purpleAccent,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 8.0,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               IconButton(icon: Icon(Icons.home), onPressed: () {}),
//               IconButton(
//                 icon: Icon(Icons.calculate),
//                 onPressed: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => BmiScreen())),
//               ),
//               SizedBox(width: 48),
//               IconButton(
//                 icon: Icon(Icons.percent),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => BodyFatCalculatorScreen())),
//               ),
//               IconButton(
//                 icon: Icon(Icons.fastfood),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CalorieIntakeScreen())),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddWorkoutForm extends StatefulWidget {
//   @override
//   _AddWorkoutFormState createState() => _AddWorkoutFormState();
// }

// class _AddWorkoutFormState extends State<AddWorkoutForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _selectedExercises = [];
//   DateTime _selectedDateTime = DateTime.now();

//   final List<String> _exerciseList = [
//     'Chest',
//     'Shoulders',
//     'Back',
//     'Arms',
//     'Abs',
//     'Legs',
//     'Cardio'
//   ];

//   final Color _primaryColor = Color(0xFF1F1F1F);
//   final Color _accentColor = Colors.purpleAccent;
//   final Color _backgroundColor = Color(0xFF121212);
//   final Color _surfaceColor = Color(0xFF2C2C2C);
//   final Color _textColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark().copyWith(
//         primaryColor: _primaryColor,
//         scaffoldBackgroundColor: _backgroundColor,
//         colorScheme: ColorScheme.fromSwatch()
//             .copyWith(secondary: _accentColor)
//             .copyWith(background: _backgroundColor),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: _backgroundColor,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[600],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Add New Workout',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: _accentColor,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 _buildDateTimePicker(),
//                 SizedBox(height: 16),
//                 Text(
//                   'Select Exercises',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _textColor,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 _buildExerciseSelector(),
//                 SizedBox(height: 24),
//                 _buildSaveButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateTimePicker() {
//     return GestureDetector(
//       onTap: () async {
//         final DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: _selectedDateTime,
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         );
//         if (pickedDate != null) {
//           final TimeOfDay? pickedTime = await showTimePicker(
//             context: context,
//             initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//           );
//           if (pickedTime != null) {
//             setState(() {
//               _selectedDateTime = DateTime(
//                 pickedDate.year,
//                 pickedDate.month,
//                 pickedDate.day,
//                 pickedTime.hour,
//                 pickedTime.minute,
//               );
//             });
//           }
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: _surfaceColor,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               DateFormat('MMM d, yyyy - HH:mm').format(_selectedDateTime),
//               style: TextStyle(color: _textColor, fontSize: 16),
//             ),
//             Icon(Icons.calendar_today, color: _accentColor),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExerciseSelector() {
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: _exerciseList.map((exercise) {
//         return FilterChip(
//           label: Text(exercise),
//           selected: _selectedExercises.contains(exercise),
//           onSelected: (selected) {
//             setState(() {
//               if (selected) {
//                 _selectedExercises.add(exercise);
//               } else {
//                 _selectedExercises.remove(exercise);
//               }
//             });
//           },
//           selectedColor: _accentColor.withOpacity(0.3),
//           checkmarkColor: _accentColor,
//           backgroundColor: _surfaceColor,
//           labelStyle: TextStyle(color: _textColor),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildSaveButton() {
//     return ElevatedButton(
//       child: Text('Save Workout'),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: _primaryColor,
//         backgroundColor: _accentColor,
//         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       onPressed: () {
//         if (_formKey.currentState!.validate() &&
//             _selectedExercises.isNotEmpty) {
//           final workout = Workout(
//             dateTime: _selectedDateTime,
//             exercises: _selectedExercises,
//           );
//           Provider.of<WorkoutProvider>(context, listen: false)
//               .addWorkout(workout);
//           Navigator.pop(context);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Please select at least one exercise'),
//               backgroundColor: _accentColor,
//             ),
//           );
//         }
//       },
//     );
//   }
// }

//Okish
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../provider/workout_provider.dart';
// import '../models/workout_model.dart';
// import 'bmi_screen.dart';
// import 'bodyfat_screen.dart';
// import 'calorieintake_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       color: Color(0xFF2C2C2C),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 30, color: Colors.purpleAccent),
//             SizedBox(height: 8),
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: Colors.grey[400]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkoutList() {
//     return Consumer<WorkoutProvider>(
//       builder: (context, workoutProvider, child) {
//         if (workoutProvider.workouts.isEmpty) {
//           return Center(child: Text('No workouts yet. Start by adding one!'));
//         }
//         return ListView.builder(
//           itemCount: workoutProvider.workouts.length,
//           itemBuilder: (context, index) {
//             final workout = workoutProvider.workouts[index];
//             return _buildWorkoutCard(workout);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildWorkoutCard(Workout workout) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: CircleAvatar(
//           backgroundColor: Color(0xFF6200EE),
//           child: Icon(Icons.fitness_center, color: Colors.white),
//         ),
//         title: Text(
//           DateFormat('EEEE, MMM d').format(workout.dateTime),
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           workout.exercises.join(', '),
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         trailing: IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () => _showDeleteConfirmation(workout),
//         ),
//       ),
//     );
//   }

//   // void _showDeleteConfirmation(Workout workout) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text("Confirm Delete"),
//   //         content: Text("Are you sure you want to delete this workout?"),
//   //         actions: [
//   //           TextButton(
//   //             child: Text("Cancel"),
//   //             onPressed: () => Navigator.of(context).pop(),
//   //           ),
//   //           TextButton(
//   //             child: Text("Delete"),
//   //             onPressed: () {
//   //               Provider.of<WorkoutProvider>(context, listen: false)
//   //                   .deleteWorkout(workout.id!);
//   //               Navigator.of(context).pop();
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   void _showDeleteConfirmation(Workout workout) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             dialogBackgroundColor: Color(0xFF2C2C2C),
//           ),
//           child: AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             title: Text(
//               "Delete Workout",
//               style: TextStyle(
//                 color: Colors.purpleAccent,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Are you sure you want to delete this workout?",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   "Date: ${DateFormat('EEEE, MMM d').format(workout.dateTime)}",
//                   style: TextStyle(color: Colors.grey[400]),
//                 ),
//                 Text(
//                   "Exercises: ${workout.exercises.join(', ')}",
//                   style: TextStyle(color: Colors.grey[400]),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//               ElevatedButton(
//                 child: Text(
//                   "Delete",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {
//                   Provider.of<WorkoutProvider>(context, listen: false)
//                       .deleteWorkout(workout.id!);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProgressChart() {
//     return Container(
//       height: 200,
//       padding: EdgeInsets.all(16),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(show: false),
//           borderData: FlBorderData(show: false),
//           minX: 0,
//           maxX: 6,
//           minY: 0,
//           maxY: 6,
//           lineBarsData: [
//             LineChartBarData(
//               spots: [
//                 FlSpot(0, 3),
//                 FlSpot(1, 1),
//                 FlSpot(2, 4),
//                 FlSpot(3, 2),
//                 FlSpot(4, 5),
//                 FlSpot(5, 3),
//               ],
//               isCurved: true,
//               color: Color(0xFF6200EE),
//               barWidth: 4,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(
//                   show: true, color: Color(0xFF6200EE).withOpacity(0.2)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddWorkoutBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: AddWorkoutForm(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark().copyWith(
//         primaryColor: Color(0xFF1F1F1F),
//         scaffoldBackgroundColor: Color(0xFF121212),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Color(0xFF1F1F1F),
//           elevation: 0,
//         ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: Color(0xFF1F1F1F),
//           selectedItemColor: Colors.purpleAccent,
//           unselectedItemColor: Colors.grey,
//         ),
//       ),
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 expandedHeight: 120.0,
//                 floating: false,
//                 pinned: true,
//                 backgroundColor: Color(0xFF1F1F1F),
//                 flexibleSpace: FlexibleSpaceBar(
//                   centerTitle: true,
//                   title: Text(
//                     'TMW',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 28,
//                     ),
//                   ),
//                 ),
//               ),
//             ];
//           },
//           body: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//               Text(
//                 'This Week\'s Progress',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildStatCard('Workouts', '5', Icons.fitness_center),
//                   _buildStatCard('Minutes', '180', Icons.timer),
//                   _buildStatCard(
//                       'Calories', '500', Icons.local_fire_department),
//                 ],
//               ),
//               SizedBox(height: 24),
//               Text(
//                 'Progress Chart',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               _buildProgressChart(),
//               SizedBox(height: 24),
//               TabBar(
//                 controller: _tabController,
//                 labelColor: Colors.purpleAccent,
//                 unselectedLabelColor: Colors.grey,
//                 tabs: [
//                   Tab(text: 'Workouts'),
//                   Tab(text: 'Statistics'),
//                 ],
//               ),
//               SizedBox(
//                 height: 300, // Adjust this height as needed
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildWorkoutList(),
//                     Center(
//                       child: Text(
//                         'Statistics coming soon!',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _showAddWorkoutBottomSheet,
//           child: Icon(Icons.add),
//           backgroundColor: Colors.purpleAccent,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           notchMargin: 8.0,
//           color: Color(0xFF1F1F1F),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               IconButton(icon: Icon(Icons.home), onPressed: () {}),
//               IconButton(
//                 icon: Icon(Icons.calculate),
//                 onPressed: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => BmiScreen())),
//               ),
//               SizedBox(width: 48),
//               IconButton(
//                 icon: Icon(Icons.percent),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => BodyFatCalculatorScreen())),
//               ),
//               IconButton(
//                 icon: Icon(Icons.fastfood),
//                 onPressed: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CalorieIntakeScreen())),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddWorkoutForm extends StatefulWidget {
//   @override
//   _AddWorkoutFormState createState() => _AddWorkoutFormState();
// }

// class _AddWorkoutFormState extends State<AddWorkoutForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> _selectedExercises = [];
//   DateTime _selectedDateTime = DateTime.now();

//   final List<String> _exerciseList = [
//     'Chest',
//     'Shoulders',
//     'Back',
//     'Arms',
//     'Abs',
//     'Legs',
//     'Cardio'
//   ];

//   final Color _primaryColor = Color(0xFF1F1F1F);
//   final Color _accentColor = Colors.purpleAccent;
//   final Color _backgroundColor = Color(0xFF121212);
//   final Color _surfaceColor = Color(0xFF2C2C2C);
//   final Color _textColor = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData.dark().copyWith(
//         primaryColor: _primaryColor,
//         scaffoldBackgroundColor: _backgroundColor,
//         colorScheme: ColorScheme.fromSwatch()
//             .copyWith(secondary: _accentColor)
//             .copyWith(background: _backgroundColor),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: _backgroundColor,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[600],
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Add New Workout',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: _accentColor,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 _buildDateTimePicker(),
//                 SizedBox(height: 16),
//                 Text(
//                   'Select Exercises',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _textColor,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 _buildExerciseSelector(),
//                 SizedBox(height: 24),
//                 _buildSaveButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateTimePicker() {
//     return GestureDetector(
//       onTap: () async {
//         final DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: _selectedDateTime,
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2101),
//         );
//         if (pickedDate != null) {
//           final TimeOfDay? pickedTime = await showTimePicker(
//             context: context,
//             initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//           );
//           if (pickedTime != null) {
//             setState(() {
//               _selectedDateTime = DateTime(
//                 pickedDate.year,
//                 pickedDate.month,
//                 pickedDate.day,
//                 pickedTime.hour,
//                 pickedTime.minute,
//               );
//             });
//           }
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: _surfaceColor,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               DateFormat('MMM d, yyyy - HH:mm').format(_selectedDateTime),
//               style: TextStyle(color: _textColor, fontSize: 16),
//             ),
//             Icon(Icons.calendar_today, color: _accentColor),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExerciseSelector() {
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: _exerciseList.map((exercise) {
//         return FilterChip(
//           label: Text(exercise),
//           selected: _selectedExercises.contains(exercise),
//           onSelected: (selected) {
//             setState(() {
//               if (selected) {
//                 _selectedExercises.add(exercise);
//               } else {
//                 _selectedExercises.remove(exercise);
//               }
//             });
//           },
//           selectedColor: _accentColor.withOpacity(0.3),
//           checkmarkColor: _accentColor,
//           backgroundColor: _surfaceColor,
//           labelStyle: TextStyle(color: _textColor),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildSaveButton() {
//     return ElevatedButton(
//       child: Text('Save Workout'),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: _primaryColor,
//         backgroundColor: _accentColor,
//         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       onPressed: () {
//         if (_formKey.currentState!.validate() &&
//             _selectedExercises.isNotEmpty) {
//           final workout = Workout(
//             dateTime: _selectedDateTime,
//             exercises: _selectedExercises,
//           );
//           Provider.of<WorkoutProvider>(context, listen: false)
//               .addWorkout(workout);
//           Navigator.pop(context);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Please select at least one exercise'),
//               backgroundColor: _accentColor,
//             ),
//           );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/workout_provider.dart';
import '../models/workout_model.dart';
import 'bmi_screen.dart';
import 'bodyfat_screen.dart';
import 'calorieintake_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkoutProvider>(context, listen: false).loadWorkouts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Card(
      elevation: 4,
      color: Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: Colors.purpleAccent),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutList() {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        if (workoutProvider.workouts.isEmpty) {
          return Center(child: Text('No workouts yet. Start by adding one!'));
        }
        return ListView.builder(
          itemCount: workoutProvider.workouts.length,
          itemBuilder: (context, index) {
            final workout = workoutProvider.workouts[index];
            return _buildWorkoutCard(workout);
          },
        );
      },
    );
  }

  Widget _buildWorkoutCard(Workout workout) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Color(0xFF6200EE),
          child: Icon(Icons.fitness_center, color: Colors.white),
        ),
        title: Text(
          DateFormat('EEEE, MMM d').format(workout.dateTime),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          workout.exercises.join(', '),
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(workout),
        ),
      ),
    );
  }

  // void _showDeleteConfirmation(Workout workout) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Confirm Delete"),
  //         content: Text("Are you sure you want to delete this workout?"),
  //         actions: [
  //           TextButton(
  //             child: Text("Cancel"),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           TextButton(
  //             child: Text("Delete"),
  //             onPressed: () {
  //               Provider.of<WorkoutProvider>(context, listen: false)
  //                   .deleteWorkout(workout.id!);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showDeleteConfirmation(Workout workout) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogBackgroundColor: Color(0xFF2C2C2C),
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Delete Workout",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Are you sure you want to delete this workout?",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  "Date: ${DateFormat('EEEE, MMM d').format(workout.dateTime)}",
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Text(
                  "Exercises: ${workout.exercises.join(', ')}",
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Provider.of<WorkoutProvider>(context, listen: false)
                      .deleteWorkout(workout.id!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressChart() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 3),
              ],
              isCurved: true,
              color: Color(0xFF6200EE),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true, color: Color(0xFF6200EE).withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddWorkoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: AddWorkoutForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1F1F1F),
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F),
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 120.0,
                floating: false,
                pinned: true,
                backgroundColor: Color(0xFF1F1F1F),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'TMW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Text(
                'This Week\'s Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Workouts', '5', Icons.fitness_center),
                  _buildStatCard('Minutes', '180', Icons.timer),
                  _buildStatCard(
                      'Calories', '500', Icons.local_fire_department),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Progress Chart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              _buildProgressChart(),
              SizedBox(height: 24),
              TabBar(
                controller: _tabController,
                labelColor: Colors.purpleAccent,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Workouts'),
                  Tab(text: 'Statistics'),
                ],
              ),
              SizedBox(
                height: 300, // Adjust this height as needed
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildWorkoutList(),
                    Center(
                      child: Text(
                        'Statistics coming soon!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddWorkoutBottomSheet,
          child: Icon(Icons.add),
          backgroundColor: Colors.purpleAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: Color(0xFF1F1F1F),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // IconButton(icon: Icon(Icons.home), onPressed: () {}),
              // IconButton(
              //   icon: Icon(Icons.calculate),
              //   onPressed: () => Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => BmiScreen())),
              // ),
              // SizedBox(width: 48),
              // IconButton(
              //   icon: Icon(Icons.percent),
              //   onPressed: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => BodyFatCalculatorScreen())),
              // ),
              // IconButton(
              //   icon: Icon(Icons.fastfood),
              //   onPressed: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => CalorieIntakeScreen()))),
              _buildNavBarItem(Icons.home, 'Home', 0),
              _buildNavBarItem(Icons.calculate, 'BMI', 1),
              SizedBox(width: 48), // Space for the FAB
              _buildNavBarItem(Icons.percent, 'Body Fat', 2),
              _buildNavBarItem(Icons.fastfood, 'Calories', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => _onNavBarItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  _selectedIndex == index ? Colors.purpleAccent : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color:
                    _selectedIndex == index ? Colors.purpleAccent : Colors.grey,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Already on home screen
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BmiScreen()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BodyFatCalculatorScreen()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CalorieIntakeScreen()));
        break;
    }
  }
}

class AddWorkoutForm extends StatefulWidget {
  @override
  _AddWorkoutFormState createState() => _AddWorkoutFormState();
}

class _AddWorkoutFormState extends State<AddWorkoutForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedExercises = [];
  DateTime _selectedDateTime = DateTime.now();

  final List<String> _exerciseList = [
    'Chest',
    'Shoulders',
    'Back',
    'Arms',
    'Abs',
    'Legs',
    'Cardio'
  ];

  final Color _primaryColor = Color(0xFF1F1F1F);
  final Color _accentColor = Colors.purpleAccent;
  final Color _backgroundColor = Color(0xFF121212);
  final Color _surfaceColor = Color(0xFF2C2C2C);
  final Color _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: _backgroundColor,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: _accentColor)
            .copyWith(background: _backgroundColor),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Add New Workout',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _accentColor,
                  ),
                ),
                SizedBox(height: 16),
                _buildDateTimePicker(),
                SizedBox(height: 16),
                Text(
                  'Select Exercises',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
                SizedBox(height: 8),
                _buildExerciseSelector(),
                SizedBox(height: 24),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDateTime,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
          );
          if (pickedTime != null) {
            setState(() {
              _selectedDateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            });
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: _surfaceColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MMM d, yyyy - HH:mm').format(_selectedDateTime),
              style: TextStyle(color: _textColor, fontSize: 16),
            ),
            Icon(Icons.calendar_today, color: _accentColor),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseSelector() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _exerciseList.map((exercise) {
        return FilterChip(
          label: Text(exercise),
          selected: _selectedExercises.contains(exercise),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedExercises.add(exercise);
              } else {
                _selectedExercises.remove(exercise);
              }
            });
          },
          selectedColor: _accentColor.withOpacity(0.3),
          checkmarkColor: _accentColor,
          backgroundColor: _surfaceColor,
          labelStyle: TextStyle(color: _textColor),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      child: Text('Save Workout'),
      style: ElevatedButton.styleFrom(
        foregroundColor: _primaryColor,
        backgroundColor: _accentColor,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate() &&
            _selectedExercises.isNotEmpty) {
          final workout = Workout(
            dateTime: _selectedDateTime,
            exercises: _selectedExercises,
          );
          Provider.of<WorkoutProvider>(context, listen: false)
              .addWorkout(workout);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select at least one exercise'),
              backgroundColor: _accentColor,
            ),
          );
        }
      },
    );
  }
}

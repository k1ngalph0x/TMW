// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import '../models/workout_model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 2;
//   List<String> _selectedWorkouts = [];
//   DateTime _selectedDateTime = DateTime.now();
//   List<Workout> _savedWorkouts = [];

//   List<String> _workoutlist = <String>[
//     'Chest',
//     'Abs',
//     'Calves',
//     'Legs',
//     'Cross-fit'
//   ];

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('MMMM d, y - h:mm a').format(dateTime);
//   }

//   void _refreshState() {
//     setState(() {
//       // This empty setState will trigger a rebuild
//     });
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
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//               left: 20,
//               right: 20,
//               top: 20,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Select today\'s workouts',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                 ),
//                 SizedBox(height: 20),
//                 MultiSelectDialogField(
//                   items:
//                       _workoutlist.map((e) => MultiSelectItem(e, e)).toList(),
//                   listType: MultiSelectListType.CHIP,
//                   onConfirm: (values) {
//                     setState(() {
//                       _selectedWorkouts = values.cast<String>();
//                     });
//                   },
//                   chipDisplay: MultiSelectChipDisplay(
//                     onTap: (value) {
//                       setState(() {
//                         _selectedWorkouts.remove(value);
//                       });
//                     },
//                   ),
//                   title: Text("Select workouts"),
//                   selectedColor: Colors.red,
//                   decoration: BoxDecoration(
//                     color: Colors.red.withOpacity(0.1),
//                     borderRadius: BorderRadius.all(Radius.circular(40)),
//                     border: Border.all(
//                       color: Colors.red,
//                       width: 2,
//                     ),
//                   ),
//                   buttonIcon: Icon(
//                     Icons.fitness_center,
//                     color: Colors.red,
//                   ),
//                   buttonText: Text(
//                     "Select Workouts",
//                     style: TextStyle(
//                       color: Colors.red[800],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: elevatedButtonStyle,
//                   onPressed: () => _selectDateTime(context),
//                   child: Text('Select Date and Time'),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Selected Date and Time:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   _formatDateTime(_selectedDateTime),
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: elevatedButtonStyle,
//                   onPressed: () {
//                     if (_selectedWorkouts.isNotEmpty) {
//                       setState(() {
//                         _savedWorkouts.add(Workout(
//                           dateTime: _selectedDateTime,
//                           exercises: List.from(_selectedWorkouts),
//                         ));
//                         _clearSelections();
//                       });
//                       _refreshState();
//                       Navigator.pop(context);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                                 Text('Please select at least one workout')),
//                       );
//                     }
//                   },
//                   child: Text('Save Workout'),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red[700],
//         title: const Text(
//           'T M W',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),
//         ),
//         elevation: 10.0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _savedWorkouts.length,
//               itemBuilder: (context, index) {
//                 final workout = _savedWorkouts[index];
//                 return Dismissible(
//                   key: Key(workout.dateTime.toIso8601String()),
//                   background: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerRight,
//                     padding: EdgeInsets.only(right: 20.0),
//                     child: Icon(Icons.delete, color: Colors.white),
//                   ),
//                   secondaryBackground: Container(
//                     color: Colors.red,
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(left: 20.0),
//                     child: Icon(Icons.delete, color: Colors.white),
//                   ),
//                   confirmDismiss: (direction) async {
//                     return await showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text("Confirm"),
//                           content: const Text(
//                               "Are you sure you want to delete this workout?"),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () => Navigator.of(context).pop(false),
//                               child: const Text("CANCEL"),
//                             ),
//                             TextButton(
//                               onPressed: () => Navigator.of(context).pop(true),
//                               child: const Text("DELETE"),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   onDismissed: (direction) {
//                     setState(() {
//                       _savedWorkouts.removeAt(index);
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Workout deleted')),
//                     );
//                   },
//                   child: Card(
//                     margin: EdgeInsets.all(8),
//                     child: ListTile(
//                       title: Text(
//                         DateFormat('EEEE').format(workout.dateTime),
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(workout.exercises.join(', ')),
//                       trailing:
//                           Text(DateFormat('MMM d').format(workout.dateTime)),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.red.shade50,
//         color: Colors.red.shade700,
//         buttonBackgroundColor: Colors.red.shade700,
//         height: 60,
//         items: <Widget>[
//           Icon(Icons.home, size: 30, color: Colors.white),
//           Icon(Icons.sports_gymnastics, size: 30, color: Colors.white),
//           Icon(Icons.add, size: 30, color: Colors.white),
//           Icon(Icons.person, size: 30, color: Colors.white),
//           Icon(Icons.person, size: 30, color: Colors.white),
//         ],
//         index: 2, // Always keep the middle button (index 2) selected
//         onTap: (index) {
//           if (index == 2) {
//             _showAddWorkoutBottomSheet(context);
//           } else {
//             setState(() {
//               _selectedIndex = index;
//             });
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../models/workout_model.dart';
import '../provider/workout_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final workouts = await DatabaseHelper.instance.getWorkouts();
    setState(() {
      _savedWorkouts = workouts;
    });
  }

  int _selectedIndex = 2;
  List<String> _selectedWorkouts = [];
  DateTime _selectedDateTime = DateTime.now();
  List<Workout> _savedWorkouts = [];

  List<String> _workoutlist = <String>[
    'Chest',
    'Shoulders',
    'Abs',
    'Hip',
    'Legs',
    'Calves',
    'Cross-fit'
  ];

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMMM d, y - h:mm a').format(dateTime);
  }

  void _refreshState() {
    setState(() {
      // This empty setState will trigger a rebuild
    });
  }

  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.red[700],
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  void _clearSelections() {
    _selectedWorkouts.clear();
    _selectedDateTime = DateTime.now();
  }

  Future<void> _selectDateTime(BuildContext context) async {
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
        _refreshState();
      }
    }
  }

  void _showAddWorkoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Consumer<WorkoutProvider>(
            builder: (context, workoutProvider, child) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select today\'s workouts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(height: 20),
                      MultiSelectDialogField(
                        items: _workoutlist
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          setState(() {
                            _selectedWorkouts = values.cast<String>();
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              _selectedWorkouts.remove(value);
                            });
                          },
                        ),
                        title: Text("Select workouts"),
                        selectedColor: Colors.red,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        buttonIcon: Icon(
                          Icons.fitness_center,
                          color: Colors.red,
                        ),
                        buttonText: Text(
                          "Select Workouts",
                          style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () => _selectDateTime(context),
                        child: Text('Select Date and Time'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Selected Date and Time:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formatDateTime(_selectedDateTime),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      // ElevatedButton(
                      //   style: elevatedButtonStyle,
                      //   onPressed: () {
                      //     if (_selectedWorkouts.isNotEmpty) {
                      //       setState(() {
                      //         _savedWorkouts.add(Workout(
                      //           dateTime: _selectedDateTime,
                      //           exercises: List.from(_selectedWorkouts),
                      //         ));
                      //         _clearSelections();
                      //       });
                      //       _refreshState();
                      //       Navigator.pop(context);
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //             content:
                      //                 Text('Please select at least one workout')),
                      //       );
                      //     }
                      //   },
                      //   child: Text('Save Workout'),
                      // ),
                      ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () async {
                          if (workoutProvider.selectedWorkouts.isNotEmpty) {
                            final workout = Workout(
                              dateTime: workoutProvider.selectedDateTime,
                              exercises:
                                  List.from(workoutProvider.selectedWorkouts),
                            );
                            // await DatabaseHelper.instance.insertWorkout(workout);
                            // await _loadWorkouts(); // Reload workouts from database
                            // _clearSelections();
                            // Navigator.pop(context);
                            await workoutProvider.addWorkout(workout);
                            workoutProvider.clearSelections();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Please select at least one workout')),
                            );
                          }
                        },
                        child: Text('Save Workout'),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: const Text(
          'T M W',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        elevation: 10.0,
      ),
      body: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: workoutProvider.workouts.length,
                  itemBuilder: (context, index) {
                    final workout = _savedWorkouts[index];
                    return Dismissible(
                        key: Key(workout.dateTime.toIso8601String()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you want to delete this workout?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("DELETE"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        // onDismissed: (direction) {
                        //   setState(() {
                        //     _savedWorkouts.removeAt(index);
                        //   });
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text('Workout deleted')),
                        //   );
                        // },
                        onDismissed: (direction) async {
                          final deletedWorkout = _savedWorkouts[index];
                          await DatabaseHelper.instance
                              .deleteWorkout(deletedWorkout.id!);
                          setState(() {
                            _savedWorkouts.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Workout deleted')),
                          );
                        },
                        child: Card(
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                DateFormat('EEEE').format(workout.dateTime),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(workout.exercises.join(', ')),
                              trailing: Text(
                                  DateFormat('MMM d').format(workout.dateTime)),
                            )));
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.red.shade50,
        color: Colors.red.shade700,
        buttonBackgroundColor: Colors.red.shade700,
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.sports_gymnastics, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        index: 2, // Always keep the middle button (index 2) selected
        onTap: (index) {
          if (index == 2) {
            _showAddWorkoutBottomSheet(context);
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }
}

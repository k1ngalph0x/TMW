// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   List<BottomNavigationBarItem> _bottomNavbarItems = [
//     BottomNavigationBarItem(
//         icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.red),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.sports_gymnastics),
//         label: 'BMI',
//         backgroundColor: Colors.red),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.add), label: 'Home', backgroundColor: Colors.red)
//   ];

//   void _onTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
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
//       bottomNavigationBar: BottomNavigationBar(
//         items: _bottomNavbarItems,
//         currentIndex: _selectedIndex,
//         onTap: _onTap,
//         selectedItemColor: Colors.red[700],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _selectedWorkouts = [];

  List<BottomNavigationBarItem> _bottomNavbarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_gymnastics),
        label: 'BMI',
        backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.add), label: 'Home', backgroundColor: Colors.red)
  ];

  List<String> _workoutlist = <String>[
    'Chest',
    'Abs',
    'Calves',
    'Legs',
    'Cross-fit'
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void listItems(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavbarItems,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Colors.red[700],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Add workout'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
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
                          Icons.pets,
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
                      Text(
                        'Selected Workouts: ${_selectedWorkouts.join(", ")}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            );

            ///////////////
          },
        ),
      ),
    );
  }
}

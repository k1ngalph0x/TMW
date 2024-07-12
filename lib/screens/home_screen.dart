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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//   Future<T?> showModalBottomSheet<T>(
// {required BuildContext context,
// required WidgetBuilder builder,
// Color? backgroundColor,
// String? barrierLabel,
// double? elevation,
// ShapeBorder? shape,
// Clip? clipBehavior,
// BoxConstraints? constraints,
// Color? barrierColor,
// bool isScrollControlled = false,
// double scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
// bool useRootNavigator = false,
// bool isDismissible = true,
// bool enableDrag = true,
// bool? showDragHandle,
// bool useSafeArea = false,
// RouteSettings? routeSettings,
// AnimationController? transitionAnimationController,
// Offset? anchorPoint,
// AnimationStyle? sheetAnimationStyle}
// )

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
                    child: Text('BottomModal'),
                  );
                });
          },
        ),
      ),
    );
  }
}

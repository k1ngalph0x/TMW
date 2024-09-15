import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tmw/components/add_workoutform.dart';
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
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: Colors.purpleAccent),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
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

  //Workouts tab
  Widget _buildWorkoutList() {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        if (workoutProvider.workouts.isEmpty) {
          return const Center(
              child: Text('No workouts yet. Start by adding one!'));
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
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF6200EE),
          child: Icon(Icons.fitness_center, color: Colors.white),
        ),
        title: Text(
          DateFormat('EEEE, MMM d').format(workout.dateTime),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          workout.exercises.join(', '),
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(workout),
        ),
      ),
    );
  }

  //Delete confirmation dialog
  void _showDeleteConfirmation(Workout workout) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogBackgroundColor: const Color(0xFF2C2C2C),
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
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
                const Text(
                  "Are you sure you want to delete this workout?",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
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
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
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
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //progress chart (Todo: Needs to be dynamic)
  Widget _buildProgressChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 3),
              ],
              isCurved: true,
              color: const Color(0xFF6200EE),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true, color: const Color(0xFF6200EE).withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }

  //Add workout form
  void _showAddWorkoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
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

  //Appbar
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF1F1F1F),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F),
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.grey,
        ),
      ),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const SliverAppBar(
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
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'This Week\'s Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('Workouts', '5', Icons.fitness_center),
                  _buildStatCard('Minutes', '180', Icons.timer),
                  _buildStatCard(
                      'Calories', '500', Icons.local_fire_department),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Progress Chart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              //Progress chart
              _buildProgressChart(),
              const SizedBox(height: 24),
              TabBar(
                controller: _tabController,
                labelColor: Colors.purpleAccent,
                unselectedLabelColor: Colors.grey,

                //Tab (Todo: Needs to be dynamic)
                tabs: const [
                  Tab(text: 'Workouts'),
                  Tab(text: 'Statistics'),
                ],
              ),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildWorkoutList(),
                    const Center(
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
          backgroundColor: Colors.purpleAccent,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          color: const Color(0xFF1F1F1F),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavBarItem(Icons.home, 'Home', 0),
              _buildNavBarItem(Icons.calculate, 'BMI', 1),
              const SizedBox(width: 48), // Space for the FAB
              _buildNavBarItem(Icons.percent, 'Body Fat', 2),
              _buildNavBarItem(Icons.fastfood, 'Calories', 3),
            ],
          ),
        ),
      ),
    );
  }

  //Navbar
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
        //Default home screen
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

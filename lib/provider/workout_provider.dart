import 'package:flutter/foundation.dart';
import '../models/workout_model.dart';
import '../database/database_helper.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];
  List<String> _selectedWorkouts = [];
  DateTime _selectedDateTime = DateTime.now();

  List<Workout> get workouts => _workouts;
  List<String> get selectedWorkouts => _selectedWorkouts;
  DateTime get selectedDateTime => _selectedDateTime;

  Future<void> loadWorkouts() async {
    _workouts = await DatabaseHelper.instance.getWorkouts();
    notifyListeners();
  }

  Future<void> addWorkout(Workout workout) async {
    await DatabaseHelper.instance.insertWorkout(workout);
    await loadWorkouts();
  }

  Future<void> deleteWorkout(int id) async {
    await DatabaseHelper.instance.deleteWorkout(id);
    await loadWorkouts();
  }

  void setSelectedWorkouts(List<String> workouts) {
    _selectedWorkouts = workouts;
    notifyListeners();
  }

  void setSelectedDateTime(DateTime dateTime) {
    _selectedDateTime = dateTime;
    notifyListeners();
  }

  void clearSelections() {
    _selectedWorkouts.clear();
    _selectedDateTime = DateTime.now();
    notifyListeners();
  }
}

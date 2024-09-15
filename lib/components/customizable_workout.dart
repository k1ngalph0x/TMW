import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/workout_provider.dart';

class CustomizableWorkoutList extends StatefulWidget {
  @override
  _CustomizableWorkoutListState createState() =>
      _CustomizableWorkoutListState();
}

class _CustomizableWorkoutListState extends State<CustomizableWorkoutList> {
  final TextEditingController _workoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        return Column(
          children: [
            MultiSelectDialogField(
              items: workoutProvider.availableWorkouts
                  .map((e) => MultiSelectItem(e, e))
                  .toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                workoutProvider.setSelectedWorkouts(values.cast<String>());
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  workoutProvider.setSelectedWorkouts(
                    workoutProvider.selectedWorkouts
                        .where((e) => e != value.toString())
                        .toList(),
                  );
                },
              ),
              title: Text("Select workouts"),
              selectedColor: Color.fromRGBO(64, 130, 175, 1),
              decoration: BoxDecoration(
                color: Color.fromRGBO(64, 130, 175, 0.1),
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  color: Color.fromRGBO(64, 130, 175, 1),
                  width: 2,
                ),
              ),
              buttonIcon: Icon(
                Icons.fitness_center,
                color: Color.fromRGBO(64, 130, 175, 1),
              ),
              buttonText: Text(
                "Select Workouts",
                style: TextStyle(
                  color: Color.fromRGBO(64, 130, 175, 1),
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _workoutController,
                    decoration: InputDecoration(
                      hintText: 'Add new workout',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_workoutController.text.isNotEmpty) {
                      workoutProvider.addCustomWorkout(_workoutController.text);
                      _workoutController.clear();
                    }
                  },
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(64, 130, 175, 1),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Custom Workouts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: workoutProvider.customWorkouts.map((workout) {
                return Chip(
                  label: Text(workout),
                  deleteIcon: Icon(Icons.close),
                  onDeleted: () {
                    workoutProvider.removeCustomWorkout(workout);
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _workoutController.dispose();
    super.dispose();
  }
}

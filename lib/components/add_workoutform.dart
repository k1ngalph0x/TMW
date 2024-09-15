import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tmw/models/workout_model.dart';
import 'package:tmw/provider/workout_provider.dart';

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

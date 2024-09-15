import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/workout_model.dart';
import 'package:intl/intl.dart';

class WorkoutBarChartScreen extends StatelessWidget {
  final List<Workout> workouts;

  const WorkoutBarChartScreen({Key? key, required this.workouts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutCounts = _getWorkoutCounts();
    final maxCount =
        workoutCounts.values.reduce((a, b) => a > b ? a : b).toDouble();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxCount,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            //tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${workoutCounts.keys.elementAt(groupIndex)}: ${rod.toY.round()}',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                int index = value.toInt();
                if (index >= 0 && index < workoutCounts.length) {
                  return Text(
                    DateFormat('dd/MM').format(
                        DateTime.parse(workoutCounts.keys.elementAt(index))),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: workoutCounts.entries.map((entry) {
          return BarChartGroupData(
            x: workoutCounts.keys.toList().indexOf(entry.key),
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(),
                color: Colors.red,
                width: 22,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Map<String, int> _getWorkoutCounts() {
    Map<String, int> counts = {};
    for (var workout in workouts) {
      String date = DateFormat('yyyy-MM-dd').format(workout.dateTime);
      counts[date] = (counts[date] ?? 0) + 1;
    }
    return Map.fromEntries(
        counts.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/database_service.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> exercises;

  const WorkoutDetailScreen({
    super.key,
    required this.title,
    required this.color,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // 1. GLASS HEADER
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              // FIXED: Updated from withOpacity to withValues
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),

      // 2. HARDCORE RED BACKGROUND
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8E0E00), // Blood Red
              Color(0xFF1F1C18), // Dark Charcoal
            ],
          ),
        ),

        // 3. GLASS LIST
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return GlassExerciseTile(
                      exerciseName: exercises[index],
                      color: color,
                    );
                  },
                ),
              ),

              // 4. GLASS START/SAVE BUTTON
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // FIXED: Updated from withOpacity to withValues
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          // FIXED: Updated from withOpacity to withValues
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // 1. Create some test data
                          List<Map<String, dynamic>> testExercises = [
                            {"name": "Bench Press", "weight": 60, "reps": 12},
                            {"name": "Flys", "weight": 20, "reps": 15},
                          ];

                          // 2. Call your Service
                          await DatabaseService().saveWorkoutLog(
                            title,
                            testExercises,
                          );

                          // 3. Show a message
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Workout Saved to Database!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.check_circle, size: 28),
                        label: const Text(
                          'SAVE WORKOUT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// THE GLASS TILE WIDGET
// ---------------------------------------------------------
class GlassExerciseTile extends StatefulWidget {
  final String exerciseName;
  final Color color;

  const GlassExerciseTile({
    super.key,
    required this.exerciseName,
    required this.color,
  });

  @override
  State<GlassExerciseTile> createState() => _GlassExerciseTileState();
}

class _GlassExerciseTileState extends State<GlassExerciseTile> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              // FIXED: Updated logic with .withValues
              color: isCompleted
                  ? Colors.green.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                // FIXED: Updated logic with .withValues
                color: isCompleted
                    ? Colors.green.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  activeColor: Colors.greenAccent,
                  checkColor: Colors.black,
                  title: Text(
                    widget.exerciseName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: Colors.white70,
                    ),
                  ),
                  value: isCompleted,
                  onChanged: (newValue) {
                    setState(() {
                      isCompleted = newValue!;
                    });
                  },
                ),
                if (!isCompleted)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Row(
                      children: [
                        _buildGlassInput("Weight (kg)", Icons.fitness_center),
                        const SizedBox(width: 12),
                        _buildGlassInput("Reps", Icons.repeat),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassInput(String hint, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          // FIXED: Updated from withOpacity to withValues
          color: Colors.black.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              // FIXED: Updated from withOpacity to withValues
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
            border: InputBorder.none,
            icon: Icon(icon, color: Colors.white70, size: 16),
          ),
        ),
      ),
    );
  }
}

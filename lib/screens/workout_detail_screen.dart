import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final String title;
  final String imagePath; // This matches what HomeScreen sends now

  const WorkoutDetailScreen({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  // 1. STATE: Keep track of completed exercises by their index
  final Set<int> completedExercises = {};

  final List<Map<String, String>> exercises = [
    {"name": "Bench Press", "reps": "4 sets x 10 reps"},
    {"name": "Incline Dumbbell Press", "reps": "3 sets x 12 reps"},
    {"name": "Cable Flys", "reps": "3 sets x 15 reps"},
    {"name": "Push-Ups", "reps": "3 sets x Failure"},
  ];

  void toggleDone(int index) {
    setState(() {
      if (completedExercises.contains(index)) {
        completedExercises.remove(index);
      } else {
        completedExercises.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Dark Blue Background
      body: CustomScrollView(
        slivers: [
          // Header Image
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: const Color(0xFF1A1A2E),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
              background: Container(
                color:
                    Colors.blueGrey.shade900, // Fallback color if image fails
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.4), // Darken image
                  colorBlendMode: BlendMode.darken,
                  errorBuilder: (context, error, stackTrace) {
                    // This prevents a crash if you haven't added the image file yet
                    return const Center(
                      child: Icon(
                        Icons.fitness_center,
                        color: Colors.white12,
                        size: 80,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Exercise List
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final exercise = exercises[index];
              final isDone = completedExercises.contains(index);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    // Change color if done
                    color: isDone
                        ? const Color(0xFF4E54C8).withValues(
                            alpha: 0.2,
                          ) // Blue tint when done
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDone
                          ? const Color(0xFF4E54C8)
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E54C8).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      exercise["name"]!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : null, // Cross out text
                        decorationColor: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      exercise["reps"]!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    trailing: IconButton(
                      // Checkbox Logic
                      icon: Icon(
                        isDone
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: isDone ? const Color(0xFF4E54C8) : Colors.grey,
                        size: 30,
                      ),
                      onPressed: () => toggleDone(index),
                    ),
                  ),
                ),
              );
            }, childCount: exercises.length),
          ),
        ],
      ),
    );
  }
}

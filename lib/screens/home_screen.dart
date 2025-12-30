import 'dart:ui';
import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // 1. GLASS HEADER
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'IronHome',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(
                0.4,
              ), // Slightly darker for "Hardcore" look
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // 2. HARDCORE RED GRADIENT BACKGROUND
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

        // 3. THE GLASS CARD LIST
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Plans",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: ListView.separated(
                    itemCount: myWorkouts.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final workout = myWorkouts[index];
                      return _buildGlassCard(context, workout);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, Workout workout) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05), // Very subtle glass
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailScreen(
                      title: workout.title,
                      color: workout.color,
                      exercises: workout.exercises,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(workout.icon, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          workout.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white.withOpacity(0.5),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- DATA MODEL ---

class Workout {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> exercises;

  Workout({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.exercises,
  });
}

final List<Workout> myWorkouts = [
  Workout(
    title: 'Chest & Triceps',
    subtitle: 'Width & Power',
    icon: Icons.fitness_center,
    color: Colors.redAccent, // Changed to match theme
    exercises: [
      'Warmup: Pushups - 2 x 20',
      'Dumbbell Bench Press - 3 x 12',
      'Incline Dumbbell Flys - 3 x 15',
      'Overhead Tricep Extension - 3 x 12',
      'Close Grip Press - 3 x 10',
    ],
  ),
  Workout(
    title: 'Back & Biceps',
    subtitle: 'Thickness Focus',
    icon: Icons.accessibility_new,
    color: Colors.orangeAccent, // Changed to match theme
    exercises: [
      'Warmup: Band Pull-aparts',
      'One Arm Dumbbell Row - 4 x 10',
      'Dumbbell Pullover - 3 x 12',
      'Hammer Curls - 3 x 12',
      'Concentration Curls - 3 x 15',
    ],
  ),
  Workout(
    title: 'Leg Day',
    subtitle: 'Don\'t skip this.',
    icon: Icons.directions_run,
    color: Colors.amberAccent, // Changed to match theme
    exercises: [
      'Goblet Squats - 4 x 12',
      'Dumbbell Lunges - 3 x 20 steps',
      'Calf Raises - 4 x 25',
      'Romanian Deadlifts - 3 x 12',
    ],
  ),
];

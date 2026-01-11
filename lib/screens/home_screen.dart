import 'dart:ui'; // Required for ImageFilter (Blur effect)
import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Extend Body: This is crucial for the Glass Effect.
      // It lets the background gradient stretch behind the App Bar.
      extendBodyBehindAppBar: true,

      // --- 1. GLASS APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the actual bar invisible
        elevation: 0, // Remove the shadow
        centerTitle: true,
        title: const Text(
          'IronHome',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        // This 'flexibleSpace' creates the blur effect on the App Bar
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              // Dark blue tinted glass look to match the new theme
              // FIXED: Updated withValues
              color: const Color(0xFF001F3F).withValues(alpha: 0.5),
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

      // --- 2. BRIGHTER BACKGROUND (BLUE & CYAN) ---
      // This solves the "Too Dark" issue
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000428), // Midnight Blue (Top)
              Color(0xFF004e92), // Electric Blue (Bottom)
            ],
          ),
        ),

        // --- 3. COMPACT LIST FOR PIXEL 3a ---
        // We use Padding and sizing adjustments here to fit the smaller screen
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10), // Small spacing at the top
                const Text(
                  "Your Plans (Dumbbells Only)",
                  style: TextStyle(
                    color: Colors.white, // Pure white for high visibility
                    fontSize: 16,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),

                Expanded(
                  child: ListView.separated(
                    itemCount: myWorkouts.length,
                    // Reduced spacing between cards to save vertical space
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
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

  // --- GLASS CARD WIDGET ---
  Widget _buildGlassCard(BuildContext context, Workout workout) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        20,
      ), // Reduced roundness for a sharper look
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            // Increased opacity slightly so the card stands out against the blue background
            // FIXED: Updated withValues
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              // FIXED: Updated withValues
              color: Colors.white.withValues(
                alpha: 0.2,
              ), // Made border brighter
              width: 1,
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
                      // We are passing imagePath now instead of color/exercises
                      // I've added a dummy path here to prevent errors,
                      // but you should update your Workout model to include image paths later.
                      imagePath: 'assets/images/dumbbells.jpg',
                    ),
                  ),
                );
              },
              child: Padding(
                // Reduced padding to make the card more compact for Pixel 3a
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    // Icon Box
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // FIXED: Updated withValues
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        workout.icon,
                        color: Colors.cyanAccent,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Text Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17, // Slightly reduced font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            workout.subtitle,
                            style: TextStyle(
                              // FIXED: Updated withValues
                              color: Colors.white.withValues(
                                alpha: 0.8,
                              ), // Lighter grey for contrast
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow Icon
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white70,
                      size: 16,
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

// Data List (Updated Colors for Blue Theme)
final List<Workout> myWorkouts = [
  Workout(
    title: 'Chest & Triceps',
    subtitle: 'Width & Power',
    icon: Icons.fitness_center,
    color: Colors.blueAccent, // Updated to match blue theme
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
    color: Colors.cyan, // Updated to match blue theme
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
    color: Colors.purpleAccent, // Updated to match blue theme
    exercises: [
      'Goblet Squats - 4 x 12',
      'Dumbbell Lunges - 3 x 20 steps',
      'Calf Raises - 4 x 25',
      'Romanian Deadlifts - 3 x 12',
    ],
  ),
];

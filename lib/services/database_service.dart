import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // <--- THIS LINE WAS MISSING

class DatabaseService {
  // Connect to the "workouts" collection in the database
  final CollectionReference workoutCollection = FirebaseFirestore.instance
      .collection('workouts');

  Future<void> saveWorkoutLog(
    String title,
    List<Map<String, dynamic>> exercises,
  ) async {
    // We use .add() to create a new document automatically
    await workoutCollection.add({
      'title': title, // "Chest & Triceps"
      'date': DateTime.now(), // Timestamp
      'exercises': exercises, // The list of weights/reps
      'userId': 'dilhara_123', // Hardcoded for now
    });

    debugPrint("✅ Workout Saved to Firebase!");
  }
}

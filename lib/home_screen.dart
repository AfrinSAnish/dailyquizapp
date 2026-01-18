import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getTodayId() {
    final now = DateTime.now();
    final y = now.year.toString();
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }

  @override
  Widget build(BuildContext context) {
    final todayId = getTodayId();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Coding Question"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("daily_questions")
            .doc(todayId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text("No question found for: $todayId"),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final title = (data["title"] ?? "Untitled") as String;

          return Center(
            child: Text(
              "Today's Question: $title",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),

    );
  }
}

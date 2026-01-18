import 'package:flutter/material.dart';

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
      body: Center(
        child: Text(
          "Today ID: $todayId",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

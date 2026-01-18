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
  final TextEditingController answerController = TextEditingController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
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

          final uid = FirebaseAuth.instance.currentUser!.uid;

          final attemptRef = FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .collection("attempts")
              .doc(todayId);

          final problem = (data["problem"] ?? "") as String;
          final solution = (data["solution"] ?? "") as String;

          return FutureBuilder<DocumentSnapshot>(
            future: attemptRef.get(),
            builder: (context, attemptSnap) {
              final hasAttempt = attemptSnap.hasData && attemptSnap.data!.exists;

              String submittedAnswer = "";
              if (hasAttempt) {
                final a = attemptSnap.data!.data() as Map<String, dynamic>;
                submittedAnswer = (a["answerText"] ?? "") as String;
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    const Text("Problem", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(problem),
                    const SizedBox(height: 20),

                    if (!hasAttempt) ...[
                      const Text(
                        "Your Answer (submit to unlock solution)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: answerController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: "Write your approach / pseudo-code...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          final text = answerController.text.trim();
                          if (text.isEmpty) return;

                          await attemptRef.set({
                            "answerText": text,
                            "submittedAt": FieldValue.serverTimestamp(),
                          });

                          setState(() {}); // refresh to show solution
                        },
                        child: const Text("Submit Answer"),
                      ),
                    ] else ...[
                      const Text(
                        "Your Submitted Answer",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(submittedAnswer),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        "Official Solution (Unlocked)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(solution),
                      ),
                    ],
                  ],
                ),
              );
            },
          );

        },
      ),

    );
  }
}

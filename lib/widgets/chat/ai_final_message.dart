import 'package:flutter/material.dart';

class AiFinalMessage extends StatelessWidget {
  const AiFinalMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🎉 All done!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your personalized Mews demo is ready. Choose where you’d like to go next:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/front-desk'),
                  child: const Text("Go to Front Desk"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/booking'),
                  child: const Text("Go to Booking"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/housekeeping'),
                  child: const Text("Go to Housekeeping"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

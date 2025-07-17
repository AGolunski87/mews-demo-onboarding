import 'package:flutter/material.dart';

class DemoDashboard extends StatelessWidget {
  final String propertyName;

  const DemoDashboard({super.key, required this.propertyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("$propertyName — Demo Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "🏨 Welcome to your Mews Demo!",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text("Here you’ll manage rooms, bookings, and more."),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Wizard"),
            ),
          ],
        ),
      ),
    );
  }
}

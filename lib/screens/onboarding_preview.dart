import 'package:flutter/material.dart';
import '../widgets/shared/RoomTypeEditorCard.dart';

class OnboardingPreviewScreen extends StatelessWidget {
  const OnboardingPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0E7),
      appBar: AppBar(
        title: const Text("🧙 Hotel Onboarding Preview"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hotel Setup",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Hotel Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Region",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "Key Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: Text("Booking"),
                    selected: true,
                    onSelected: (_) {},
                  ),
                  FilterChip(
                    label: Text("Housekeeping"),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  FilterChip(
                    label: Text("Front Desk"),
                    selected: false,
                    onSelected: (_) {},
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Text(
                "Room Types (from chatbot input)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              RoomTypeEditorCard(typeName: "Family Room"),
              RoomTypeEditorCard(typeName: "Standard Room"),

              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Generate My Demo"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


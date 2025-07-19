import 'package:flutter/material.dart';

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

class RoomTypeEditorCard extends StatelessWidget {
  final String typeName;
  const RoomTypeEditorCard({super.key, required this.typeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              typeName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "# of Rooms",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Occupancy",
                      suffixText: "guests",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Nightly Rate",
                      prefixText: "\$",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Cleaning Time",
                      suffixText: "mins",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                const Text("Upload Room Image:"),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text("Add Image"),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

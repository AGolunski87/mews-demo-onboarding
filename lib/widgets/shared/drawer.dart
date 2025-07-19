import 'package:flutter/material.dart';
import 'RoomTypeEditorCard.dart';

class RoomTypeDrawer extends StatelessWidget {
  final int numberOfRoomTypes;
  const RoomTypeDrawer({super.key, required this.numberOfRoomTypes});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 400,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🛏 Room Type Setup",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < numberOfRoomTypes; i++)
                RoomTypeEditorCard(
                  key: ValueKey('room-type-${i + 1}'),

                  typeName: "Edit Room Type ...",
                  editableName: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

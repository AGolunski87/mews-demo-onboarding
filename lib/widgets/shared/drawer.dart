import 'package:flutter/material.dart';
import 'RoomTypeEditorCard.dart';

class RoomTypeDrawer extends StatefulWidget {
  final int numberOfRoomTypes;
  final String summaryText;
  final VoidCallback onFinish; // ✅ just the declaration here

  const RoomTypeDrawer({
    super.key,
    required this.numberOfRoomTypes,
    required this.summaryText,
    required this.onFinish, // ✅ assigned, not defined
  });

  @override
  State<RoomTypeDrawer> createState() => _RoomTypeDrawerState();
}

class _RoomTypeDrawerState extends State<RoomTypeDrawer> {
  bool isComplete = false;
  int roomCardCount = 0;
  bool _botTyping = false;

  @override
  void initState() {
    super.initState();
    roomCardCount = widget.numberOfRoomTypes;
  }

  void addRoom() {
    setState(() => roomCardCount++);
  }

  void enableEditMode() {
    setState(() => isComplete = false);
  }

  void completeSetup() {
    setState(() => _botTyping = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      widget.onFinish();
      if (mounted) {
        setState(() {
          _botTyping = false;
          isComplete = true;
        });
      }
    });
  }

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
              Text(
                widget.summaryText,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "⚙️ Feature Focus",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text("Booking")),
                  Chip(label: Text("Front Desk")),
                  Chip(label: Text("Payments")),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "🏨 Upload Logo",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.upload),
                label: Text("Add Logo"),
              ),
              const SizedBox(height: 16),
              const Text(
                "🛏 Room Type Setup",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < roomCardCount; i++)
                RoomTypeEditorCard(
                  key: ValueKey('room-type-${i + 1}'),
                  typeName: "Edit Room Type ...",
                  editableName: true,
                ),
              const SizedBox(height: 20),
              if (_botTyping)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "🤖 thinking...",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              if (!isComplete && !_botTyping)
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: addRoom,
                      child: Text("Add Another Room Type"),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: completeSetup,
                      child: Text("Finish Setup"),
                    ),
                  ],
                )
              else if (isComplete && !_botTyping)
                Center(
                  child: ElevatedButton(
                    onPressed: enableEditMode,
                    child: Text("Edit Room Types"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

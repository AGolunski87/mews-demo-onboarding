import 'package:flutter/material.dart';
import '../../models/room_type.dart';
import '../../services/user_input_service.dart';
import 'RoomTypeEditorCard.dart';

class RoomTypeDrawer extends StatefulWidget {
  final int numberOfRoomTypes;
  final String summaryText;
  final void Function(List<RoomType> roomTypes) onFinish;

  const RoomTypeDrawer({
    super.key,
    required this.numberOfRoomTypes,
    required this.summaryText,
    required this.onFinish,
  });

  @override
  State<RoomTypeDrawer> createState() => _RoomTypeDrawerState();
}

class _RoomTypeDrawerState extends State<RoomTypeDrawer> {
  bool isComplete = false;
  int roomCardCount = 0;
  bool _botTyping = false;

  final List<String> defaultRoomTypes = [
    'Big Room',
    'Small Room',
    'Family Room',
    'Penthouse',
  ];

  @override
  void initState() {
    super.initState();
    roomCardCount = widget.numberOfRoomTypes;

    // Ensure we have enough names for the initial cards
    while (defaultRoomTypes.length < roomCardCount) {
      defaultRoomTypes.add("Room Type ${defaultRoomTypes.length + 1}");
    }
  }

  @override
  void didUpdateWidget(covariant RoomTypeDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.numberOfRoomTypes != oldWidget.numberOfRoomTypes) {
      setState(() {
        roomCardCount = widget.numberOfRoomTypes;

        // Again, ensure the name list stays long enough
        while (defaultRoomTypes.length < roomCardCount) {
          defaultRoomTypes.add("Room Type ${defaultRoomTypes.length + 1}");
        }
      });
    }
  }

  void addRoom() {
    setState(() {
      roomCardCount++;
      defaultRoomTypes.add("Room Type ${defaultRoomTypes.length + 1}");
    });
  }

  void enableEditMode() {
    setState(() => isComplete = false);
  }

  bool _allCardsValid() {
    final rooms = UserInputService().roomTypes;

    for (final r in rooms) {
      print(
        "🧪 Room: ${r.name}, \$${r.pricePerNight}, ${r.numberOfRooms} rooms, ${r.maxOccupancy} guests",
      );
    }

    return rooms.isNotEmpty &&
        rooms.every(
          (room) =>
              room.name.trim().isNotEmpty &&
              room.pricePerNight > 0 &&
              room.numberOfRooms > 0 &&
              room.maxOccupancy > 0,
        );
  }

  void completeSetup() {
    if (!_allCardsValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all room cards')),
      );
      return;
    }

    setState(() => _botTyping = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      final completed = UserInputService().roomTypes;
      widget.onFinish(completed);

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
    final totalValidRooms = UserInputService().roomTypes.length;

    return Container(
      width: 400,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    if (widget.summaryText.trim().isNotEmpty)
                      Text(
                        widget.summaryText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    if (widget.summaryText.trim().isNotEmpty)
                      const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    const Text(
                      "Features",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                      "Upload Logo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload),
                      label: const Text("Add Logo"),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Configure Rooms",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (int i = 0; i < roomCardCount; i++)
                      RoomTypeEditorCard(
                        key: ValueKey('room-type-${i + 1}'),
                        typeName: (i < defaultRoomTypes.length)
                            ? defaultRoomTypes[i]
                            : "Room Type ${i + 1}",
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
                            child: const Text("Add Another Room Type"),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: completeSetup,
                            child: const Text("Finish Setup"),
                          ),
                        ],
                      )
                    else if (isComplete && !_botTyping)
                      Center(
                        child: ElevatedButton(
                          onPressed: enableEditMode,
                          child: const Text("Edit Room Types"),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

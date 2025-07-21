import 'package:flutter/material.dart';
import '../../models/room_type.dart';
import '../../services/user_input_service.dart';

class RoomTypeEditorCard extends StatefulWidget {
  final String typeName;
  final bool editableName;

  const RoomTypeEditorCard({
    super.key,
    required this.typeName,
    this.editableName = false,
  });

  @override
  State<RoomTypeEditorCard> createState() => _RoomTypeEditorCardState();
}

class _RoomTypeEditorCardState extends State<RoomTypeEditorCard> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _roomCountController;
  late TextEditingController _occupancyController;
  bool _editingName = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.typeName);
    _priceController = TextEditingController();
    _roomCountController = TextEditingController();
    _occupancyController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => _notifyChange());
  }

  void _notifyChange() {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final roomCount = int.tryParse(_roomCountController.text.trim()) ?? 0;
    final occupancy = int.tryParse(_occupancyController.text.trim()) ?? 0;

    final updatedRoomType = RoomType(
      name: name,
      pricePerNight: price,
      numberOfRooms: roomCount,
      maxOccupancy: occupancy,
    );

    UserInputService().addOrUpdateRoomType(updatedRoomType);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.editableName
                ? GestureDetector(
                    onTap: () => setState(() => _editingName = true),
                    child: _editingName
                        ? TextField(
                            controller: _nameController,
                            autofocus: true,
                            onChanged: (_) => _notifyChange(),
                            onSubmitted: (_) =>
                                setState(() => _editingName = false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Room Type Name',
                            ),
                          )
                        : Text(
                            _nameController.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  )
                : Text(
                    widget.typeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price Per Night",
                prefixText: "\$",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _notifyChange(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _roomCountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Number of Rooms",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _notifyChange(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _occupancyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Max Occupancy",
                      suffixText: "guests",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _notifyChange(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _roomCountController.dispose();
    _occupancyController.dispose();
    super.dispose();
  }
}

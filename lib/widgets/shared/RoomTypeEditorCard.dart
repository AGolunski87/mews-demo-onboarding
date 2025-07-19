import 'package:flutter/material.dart';

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
  bool _editingName = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.typeName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  // Removed invalid constructor and field declaration.

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
            widget.editableName
                ? GestureDetector(
                    onTap: () => setState(() => _editingName = true),
                    child: _editingName
                        ? TextField(
                            controller: _nameController,
                            autofocus: true,
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

import 'package:flutter/material.dart';

class HousekeepingPage extends StatelessWidget {
  const HousekeepingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      CleaningTask(room: '101', type: 'Departure Clean', status: 'Pending'),
      CleaningTask(
        room: '102',
        type: 'Stayover Refresh',
        status: 'In Progress',
      ),
      CleaningTask(room: '103', type: 'Departure Clean', status: 'Completed'),
      CleaningTask(room: '104', type: 'Inspection', status: 'Pending'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        leadingWidth: 180,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/logo/demo_logo.png',
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          'Housekeeping Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: const [
            Icon(Icons.email_outlined, color: Colors.indigo),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Contact sales@mews.com to get started today',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today’s Cleaning Tasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...tasks.map((task) => HousekeepingCard(task: task)),
                      const SizedBox(height: 40),
                      const Divider(),
                      const SizedBox(height: 24),
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: const [
                          HousekeepingAction(
                            label: 'Mark as Done',
                            icon: Icons.check,
                          ),
                          HousekeepingAction(
                            label: 'Assign Staff',
                            icon: Icons.person_add_alt,
                          ),
                          HousekeepingAction(
                            label: 'View Schedule',
                            icon: Icons.schedule,
                          ),
                          HousekeepingAction(
                            label: 'Report Issue',
                            icon: Icons.report,
                          ),
                          HousekeepingAction(
                            label: 'Edit Task',
                            icon: Icons.edit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Why Hoteliers Choose Mews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          '✓ Modern automation that saves hours daily\n'
                          '✓ Seamless guest experience from booking to checkout\n'
                          '✓ Loved by boutique and independent hotels across Europe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'What Our Customers Say',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Testimonial(
                          quote:
                              'The Mews platform has transformed the way we work.',
                          author: '— The Gate Cornwall',
                        ),
                        Testimonial(
                          quote:
                              'Mews makes our team more efficient and our guests happier.',
                          author: '— Bush Hotel Farnham',
                        ),
                        Testimonial(
                          quote:
                              'We manage 200+ serviced apartments effortlessly with Mews.',
                          author: '— Your Apartment',
                        ),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Models & Components ---

class CleaningTask {
  final String room;
  final String type;
  final String status;

  CleaningTask({required this.room, required this.type, required this.status});
}

class HousekeepingCard extends StatelessWidget {
  final CleaningTask task;

  const HousekeepingCard({super.key, required this.task});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        title: Text(
          'Room ${task.room}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(task.type),
        trailing: Text(
          task.status,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: _getStatusColor(task.status),
          ),
        ),
      ),
    );
  }
}

class HousekeepingAction extends StatelessWidget {
  final String label;
  final IconData icon;

  const HousekeepingAction({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label tapped')));
      },
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class Testimonial extends StatelessWidget {
  final String quote;
  final String author;

  const Testimonial({super.key, required this.quote, required this.author});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Text(
            '“$quote”',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            author,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

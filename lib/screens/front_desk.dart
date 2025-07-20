import 'package:flutter/material.dart';

class FrontDeskPage extends StatelessWidget {
  const FrontDeskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkIns = [
      GuestInfo(
        name: 'Alice Johnson',
        room: '101',
        status: 'Arriving Today',
        eta: '14:00',
      ),
      GuestInfo(
        name: 'Miguel Sousa',
        room: '102',
        status: 'Checked In',
        eta: '—',
      ),
      GuestInfo(
        name: 'Emily Zhang',
        room: '103',
        status: 'Arriving Today',
        eta: '16:30',
      ),
      GuestInfo(
        name: 'Olivier Laurent',
        room: '104',
        status: 'No-show',
        eta: '—',
      ),
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
          'Front Desk Overview',
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
                        'Today’s Check-ins',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...checkIns.map((guest) => FrontDeskCard(guest: guest)),
                      const SizedBox(height: 40),
                      const Divider(),
                      const SizedBox(height: 24),
                      const Text(
                        'Instant Front Desk Tools',
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
                          FrontDeskAction(
                            label: 'Search Guest',
                            icon: Icons.search,
                          ),
                          FrontDeskAction(
                            label: 'Assign Room',
                            icon: Icons.vpn_key,
                          ),
                          FrontDeskAction(
                            label: 'Check Out',
                            icon: Icons.logout,
                          ),
                          FrontDeskAction(label: 'Issue Key', icon: Icons.key),
                          FrontDeskAction(
                            label: 'Message Guest',
                            icon: Icons.chat,
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
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Models & Widgets ---

class GuestInfo {
  final String name;
  final String room;
  final String status;
  final String eta;

  GuestInfo({
    required this.name,
    required this.room,
    required this.status,
    required this.eta,
  });
}

class FrontDeskCard extends StatelessWidget {
  final GuestInfo guest;

  const FrontDeskCard({super.key, required this.guest});

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
          guest.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Room ${guest.room} — ${guest.status}'),
        trailing: guest.eta != '—'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ETA'),
                  Text(
                    guest.eta,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}

class FrontDeskAction extends StatelessWidget {
  final String label;
  final IconData icon;

  const FrontDeskAction({super.key, required this.label, required this.icon});

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

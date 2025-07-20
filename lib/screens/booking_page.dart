import 'package:flutter/material.dart';

class BookingPageV2 extends StatelessWidget {
  const BookingPageV2({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = [
      RoomCardData(
        image: 'assets/rooms/bedroom_one.jpg',
        name: 'Junior Suite',
        guests: 2,
        description:
            'Spacious suite with a private terrace and elegant decor. Includes sea view, air conditioning, and high-speed Wi-Fi.',
        rateOptions: [
          RateOption(
            label: 'Book early & save',
            breakfastIncluded: true,
            price: 318,
            originalPrice: 346,
          ),
          RateOption(
            label: 'Standard rate',
            breakfastIncluded: true,
            price: 328,
            originalPrice: 364,
          ),
        ],
      ),
      RoomCardData(
        image: 'assets/rooms/bedroom_two.jpg',
        name: 'Double with Sea View',
        guests: 2,
        description:
            'Cozy double room with stunning sea views and modern amenities. Perfect for couples or business stays.',
        rateOptions: [
          RateOption(
            label: 'Non-refundable',
            breakfastIncluded: true,
            price: 295,
            originalPrice: 315,
          ),
          RateOption(
            label: 'Flexible booking',
            breakfastIncluded: true,
            price: 315,
            originalPrice: 340,
          ),
        ],
      ),
      RoomCardData(
        image: 'assets/rooms/bedroom_three.jpg',
        name: 'Standard Room',
        guests: 1,
        description:
            'A comfortable, compact room ideal for solo travelers. Features a desk, natural light, and plush bedding.',
        rateOptions: [
          RateOption(
            label: 'Value rate',
            breakfastIncluded: false,
            price: 180,
            originalPrice: 200,
          ),
          RateOption(
            label: 'Flexible stay',
            breakfastIncluded: true,
            price: 200,
            originalPrice: 225,
          ),
        ],
      ),
      RoomCardData(
        image: 'assets/rooms/bedroom_four.jpg',
        name: 'Penthouse Loft',
        guests: 4,
        description:
            'Our most luxurious offering, the Penthouse Loft features panoramic views, designer interiors, and a soaking tub for two.',
        rateOptions: [
          RateOption(
            label: 'Exclusive offer',
            breakfastIncluded: true,
            price: 490,
            originalPrice: 540,
          ),
          RateOption(
            label: 'Fully flexible',
            breakfastIncluded: true,
            price: 525,
            originalPrice: 580,
          ),
        ],
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
          'Reserve Your Stay',
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
              children: [
                const SizedBox(height: 30),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: rooms.length,
                  itemBuilder: (_, index) => RoomCard(room: rooms[index]),
                ),
                const SizedBox(height: 40),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      Text(
                        'Why Hoteliers Choose Mews',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Models & UI Components Below (same as before) ---

class RoomCardData {
  final String image;
  final String name;
  final int guests;
  final String description;
  final List<RateOption> rateOptions;

  RoomCardData({
    required this.image,
    required this.name,
    required this.guests,
    required this.description,
    required this.rateOptions,
  });
}

class RateOption {
  final String label;
  final bool breakfastIncluded;
  final double price;
  final double originalPrice;

  RateOption({
    required this.label,
    required this.breakfastIncluded,
    required this.price,
    required this.originalPrice,
  });
}

class RoomCard extends StatelessWidget {
  final RoomCardData room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              room.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${room.guests} guests',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  room.description,
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
          const Divider(height: 24, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: room.rateOptions
                  .map((rate) => RateOptionRow(rate: rate))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RateOptionRow extends StatelessWidget {
  final RateOption rate;

  const RateOptionRow({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rate.label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      rate.breakfastIncluded
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: rate.breakfastIncluded
                          ? Colors.green
                          : Colors.redAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      rate.breakfastIncluded
                          ? 'Breakfast included'
                          : 'No breakfast',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (rate.originalPrice > rate.price)
                Text(
                  '€${rate.originalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              Text(
                '€${rate.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking ${rate.label}...')),
                  );
                },
                child: const Text(
                  'Select',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
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

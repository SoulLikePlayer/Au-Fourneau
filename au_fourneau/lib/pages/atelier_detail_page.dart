import 'package:flutter/material.dart';

class AtelierDetailPage extends StatelessWidget {
  final Map<String, dynamic> atelier;

  const AtelierDetailPage({
    super.key,
    required this.atelier,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = atelier['image_url'] ??
        "https://images.unsplash.com/photo-1490645935967-10de6ba17061";

    final isPaid = atelier['is_paid'] ?? false;
    final price = atelier['price'];
    final date = DateTime.parse(atelier['start_at']);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.orange,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    atelier['titre'],
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isPaid
                          ? Colors.orange.withOpacity(0.15)
                          : Colors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPaid
                          ? "${price?.toStringAsFixed(0)}€"
                          : "Gratuit",
                      style: TextStyle(
                        color:
                            isPaid ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "${date.day}/${date.month}/${date.year} à ${date.hour}h${date.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "${atelier['location_name']}, ${atelier['location_city']}",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.group,
                          size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        "Max ${atelier['max_participants']} participants",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    atelier['description'] ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        debugPrint("Réservation atelier ${atelier['id']}");
                      },
                      child: Text(
                        isPaid
                            ? "Réserver pour ${price?.toStringAsFixed(0)}€"
                            : "Réserver ma place",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
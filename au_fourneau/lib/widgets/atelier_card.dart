import 'package:flutter/material.dart';

class AtelierCard extends StatelessWidget {
  final String titre;
  final String description;
  final String imageUrl;
  final DateTime date;
  final int participants;
  final int maxParticipants;
  final String location;
  final bool isPaid;
  final double? price;
  final VoidCallback? onTap;

  const AtelierCard({
    super.key,
    required this.titre,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.participants,
    required this.maxParticipants,
    required this.location,
    required this.isPaid,
    this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGE + BADGE PRIX
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPaid ? "${price!.toStringAsFixed(0)}€" : "Gratuit",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    titre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        "${date.day}/${date.month} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.people, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        "$participants/$maxParticipants",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),

                      const Text(
                        "Voir →",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
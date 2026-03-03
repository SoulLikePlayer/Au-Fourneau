import 'package:au_fourneau/widgets/atelier_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;

  List<dynamic> ateliers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAteliers();
  }

  Future<void> fetchAteliers() async {
    try {
      final response = await supabase
          .from('ateliers')
          .select()
          .gte('start_at', DateTime.now().toIso8601String())
          .order('start_at', ascending: true);

      setState(() {
        ateliers = response;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Erreur fetch ateliers: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Ateliers",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Découvrez nos prochains cours",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Rechercher un atelier (ex: Pâtes)",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // TODO : filtre plus tard
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ateliers.isEmpty
                      ? Center(
                          child: Text(
                            "Aucun atelier disponible",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: fetchAteliers,
                          child: ListView.builder(
                            physics:
                                const AlwaysScrollableScrollPhysics(),
                            itemCount: ateliers.length,
                            itemBuilder: (context, index) {
                              final atelier = ateliers[index];

                              final imageUrl =
                                  atelier['image_url'] ??
                                      "https://images.unsplash.com/photo-1490645935967-10de6ba17061";

                              return AtelierCard(
                                titre: atelier['titre'],
                                description:
                                    atelier['description'] ?? "",
                                imageUrl: imageUrl,
                                date: DateTime.parse(
                                    atelier['start_at']),
                                participants: 0,
                                maxParticipants:
                                    atelier['max_participants'],
                                location:
                                    "${atelier['location_name']}, ${atelier['location_city']}",
                                isPaid: atelier['is_paid'],
                                price: atelier['price'] != null
                                    ? (atelier['price'] as num)
                                        .toDouble()
                                    : null,
                                onTap: () {
                                  debugPrint(
                                      "Atelier ${atelier['id']} cliqué");
                                },
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
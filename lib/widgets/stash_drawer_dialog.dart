import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../theme/noir_theme.dart';

class StashDrawerDialog extends StatelessWidget {
  final GameController controller;

  const StashDrawerDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final customer = controller.currentCustomer;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 520,
          constraints: const BoxConstraints(maxHeight: 460),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1712), // Koyu ceviz çekmece ahşabı
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF8D5B30), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BAŞLIK
              Row(
                children: [
                  const Icon(Icons.lock_outline, color: NoirTheme.amberWarm, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'GİZLİ TEZGÂH ÇEKMECESİ (ZULA)',
                    style: NoirTheme.typewriterSubheading.copyWith(
                      color: NoirTheme.amberWarm,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: controller.toggleStash,
                  ),
                ],
              ),
              const Divider(color: Color(0xFF8D5B30)),
              const SizedBox(height: 8),

              if (controller.stash.isEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      'Zula şu an boş.\nTezgâha bırakılan şüpheli emanetler burada saklanır.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 13,
                        color: Colors.white38,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.stash.length,
                    separatorBuilder: (c, i) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = controller.stash[index];
                      bool isExpected = customer?.expectedContrabandId == item.id;

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C2219),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isExpected ? Colors.greenAccent : const Color(0xFF5A3C20),
                            width: isExpected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(item.icon, style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isExpected ? Colors.greenAccent : NoirTheme.amberWarm,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 11,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  if (item.ownerHint.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      'Hedef: "${item.ownerHint}"',
                                      style: const TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // MÜŞTERİ BU EŞYAYI BEKLİYORSA TESLİM BUTONU
                            if (isExpected) ...[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent.shade700,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: () => controller.deliverContraband(item),
                                child: const Text(
                                  'EMANETİ VER',
                                  style: TextStyle(
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.toggleStash,
                  child: const Text(
                    'ÇEKMECEYİ KİLİTLE & KAPAT',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      color: NoirTheme.amberWarm,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

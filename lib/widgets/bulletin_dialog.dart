import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../theme/noir_theme.dart';

class BulletinDialog extends StatelessWidget {
  final GameController controller;

  const BulletinDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final bulletin = controller.currentBulletin;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 560,
          constraints: const BoxConstraints(maxHeight: 520),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: NoirTheme.paperBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: NoirTheme.paperBorder, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.7),
                blurRadius: 28,
                spreadRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RESMİ DOSYA ÜST BAŞLIĞI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EMNİYET GENEL MÜDÜRLÜĞÜ - GİZLİ',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.red.shade900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        bulletin.title,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: NoirTheme.paperInk,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: NoirTheme.paperInk),
                    onPressed: controller.toggleBulletin,
                  ),
                ],
              ),
              Text(
                bulletin.dateString,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: NoirTheme.paperFadedInk,
                ),
              ),
              const Divider(color: NoirTheme.paperBorder, thickness: 2, height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GÜNÜN KURALLARI
                      const Text(
                        'BUGÜNÜN YÜRÜRLÜKTEKİ EMİRLERİ:',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: NoirTheme.paperInk,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...bulletin.rules.map((rule) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('▪ ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                  rule,
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 12,
                                    height: 1.3,
                                    color: NoirTheme.paperInk,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 14),

                      // KARA LİSTE SERİ NUMARALARI
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.08),
                          border: Border.all(color: Colors.red.shade800),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GEÇERSİZ / ÇALINTI BANKNOT SERİLERİ:',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              children: bulletin.blacklistedSerialNumbers.map((sn) {
                                return Chip(
                                  backgroundColor: Colors.red.shade100,
                                  label: Text(
                                    sn,
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ARANAN ŞAHIS
                      const Text(
                        'DİKKAT EDİLECEK ŞÜPHELİ:',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: NoirTheme.paperInk,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bulletin.wantedDescription,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 12,
                          color: NoirTheme.paperInk,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ŞEHİR FISILTILARI
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.04),
                          border: Border.all(color: NoirTheme.paperBorder),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Sokak Notu: "${bulletin.flavorNews}"',
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: NoirTheme.paperFadedInk,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NoirTheme.coffeeDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: controller.toggleBulletin,
                  child: const Text(
                    'DOSYAYI KAPAT & MASAYA DÖN',
                    style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold),
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

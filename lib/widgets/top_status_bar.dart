import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../theme/noir_theme.dart';

class TopStatusBar extends StatelessWidget {
  final GameController controller;

  const TopStatusBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: NoirTheme.surface,
        border: const Border(
          bottom: BorderSide(color: NoirTheme.surfaceBorder, width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
              // GÜN & VARDİYA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: NoirTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: NoirTheme.amberWarm, width: 1.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.nightlight_round, color: NoirTheme.amberWarm, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'GÜN ${controller.currentDay} / 3',
                      style: NoirTheme.typewriterSubheading.copyWith(
                        color: NoirTheme.amberWarm,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // KASA BAKİYESİ
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: NoirTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.greenAccent.shade700, width: 1.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, color: Colors.greenAccent, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'KASA: ${controller.cash} ₺',
                      style: NoirTheme.typewriterSubheading.copyWith(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // CEZA VE UYARI SAYAÇLARI
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: NoirTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: controller.penaltiesCount > 0
                        ? NoirTheme.stampRed
                        : Colors.white24,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: controller.penaltiesCount > 0
                          ? NoirTheme.stampRed
                          : Colors.white54,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'CEZALAR: ',
                      style: NoirTheme.typewriterSubheading.copyWith(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    ...List.generate(3, (index) {
                      bool hasPenalty = index < controller.penaltiesCount;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          hasPenalty ? Icons.cancel : Icons.circle_outlined,
                          size: 16,
                          color: hasPenalty ? NoirTheme.stampRed : Colors.white30,
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              // BÜLTEN BUTONU
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: NoirTheme.paperBg,
                  foregroundColor: NoirTheme.paperInk,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: const BorderSide(color: NoirTheme.paperBorder, width: 1.5),
                  ),
                ),
                onPressed: controller.toggleBulletin,
                icon: const Icon(Icons.assignment, size: 18),
                label: const Text(
                  'GÜNLÜK BÜLTEN',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // ZULA (GİZLİ ÇEKMECE) BUTONU
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.stash.isNotEmpty
                      ? Colors.deepOrange.shade900
                      : NoirTheme.surfaceLight,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: controller.stash.isNotEmpty
                          ? Colors.orangeAccent
                          : NoirTheme.surfaceBorder,
                      width: 1.5,
                    ),
                  ),
                ),
                onPressed: controller.toggleStash,
                icon: Badge(
                  isLabelVisible: controller.stash.isNotEmpty,
                  label: Text('${controller.stash.length}'),
                  backgroundColor: Colors.amber,
                  textColor: Colors.black,
                  child: const Icon(Icons.inventory_2, size: 18),
                ),
                label: const Text(
                  'ZULA ÇEKMECESİ',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),

          // ALT BİLGİLENDİRME ŞERİDİ (FEEDBACK TICKER)
          if (controller.bannerFeedback != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: NoirTheme.amberWarm),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      controller.bannerFeedback!,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 13,
                        color: NoirTheme.amberWarm,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

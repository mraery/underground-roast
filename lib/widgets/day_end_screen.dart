import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game_state.dart';
import '../theme/noir_theme.dart';

class DayEndScreen extends StatefulWidget {
  final GameController controller;

  const DayEndScreen({super.key, required this.controller});

  @override
  State<DayEndScreen> createState() => _DayEndScreenState();
}

class _DayEndScreenState extends State<DayEndScreen> {
  bool showShop = false;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final summary = controller.currentDaySummary;
    if (summary == null) return const SizedBox.shrink();

    bool isGameOver = controller.isGameOver;
    EndingType? ending = controller.achievedEnding;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 760,
          constraints: const BoxConstraints(maxHeight: 640),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: NoirTheme.paperBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: NoirTheme.paperBorder, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.9),
                blurRadius: 36,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ÜST BAŞLIK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ending != null
                        ? '★ KAMPANYA FİNALİ: ${ending.title} ★'
                        : 'GÜN ${summary.day} / 7 RAPORU - VARDİYA BİLANÇOSU',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: ending != null ? Colors.red.shade900 : NoirTheme.paperInk,
                    ),
                  ),
                  if (!isGameOver)
                    Row(
                      children: [
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: showShop ? NoirTheme.coffeeDark : Colors.transparent,
                            foregroundColor: showShop ? Colors.white : NoirTheme.paperInk,
                            side: const BorderSide(color: NoirTheme.paperBorder),
                          ),
                          onPressed: () => setState(() => showShop = !showShop),
                          icon: const Icon(Icons.storefront, size: 16),
                          label: Text(
                            showShop ? 'BİLANÇOYA DÖN' : 'DÜKKÂN PAZARI (GELİŞTİR)',
                            style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const Divider(color: NoirTheme.paperBorder, thickness: 2, height: 20),

              // ORTA ALAN: BİLANÇO vs DÜKKÂN PAZARI
              Expanded(
                child: showShop ? _buildShopMarket(controller) : _buildSummaryAndNews(controller, summary, ending),
              ),

              const SizedBox(height: 14),

              // ALT EYLEM DÜĞMELERİ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KASA: ${controller.cash} ₺',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: controller.cash >= 0 ? Colors.green.shade900 : Colors.red.shade900,
                    ),
                  ),
                  Row(
                    children: [
                      if (isGameOver) ...[
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: NoirTheme.coffeeDark,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: controller.restartGame,
                          icon: const Icon(Icons.replay),
                          label: const Text(
                            'YENİDEN BAŞLA',
                            style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold),
                          ),
                        ),
                      ] else ...[
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: NoirTheme.stampGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: controller.proceedToNextDay,
                          icon: const Icon(Icons.arrow_forward),
                          label: Text(
                            'GÜN ${controller.currentDay + 1}\'E BAŞLA >>',
                            style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryAndNews(GameController controller, DaySummary summary, EndingType? ending) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SOL: HESAP EKSTRESİ
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: NoirTheme.paperBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'HESAP EKSTRESİ:',
                  style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13, color: NoirTheme.paperInk),
                ),
                const SizedBox(height: 8),
                _buildLine('Kahve Satış Geliri', '+${summary.earnings} ₺', Colors.green.shade800),
                _buildLine('Bahşişler & Sus Payı', '+${summary.tips} ₺', Colors.green.shade800),
                _buildLine('Dükkân Kirası', '-${summary.rent} ₺', Colors.red.shade800),
                _buildLine('Kahve Çekirdeği & Süt', '-${summary.supplyCost} ₺', Colors.red.shade800),
                if (summary.penaltiesAmount > 0)
                  _buildLine('Sahte Para & Cezalar', '-${summary.penaltiesAmount} ₺', Colors.red.shade900),
                const Divider(color: Colors.black26, height: 18),
                _buildLine(
                  'KASADA KALAN',
                  '${summary.endingCash} ₺',
                  summary.endingCash >= 0 ? Colors.green.shade900 : Colors.red.shade900,
                  isBold: true,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        // SAĞ: GAZETE MANŞETİ VEYA OYUN SONU HİKAYESİ
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF2EAD8),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: NoirTheme.paperBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ending != null ? 'SONUÇ' : 'GECE POSTASI',
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 2, color: NoirTheme.paperInk),
                    ),
                    Text(
                      'Sayı: #${summary.day * 142}',
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
                const Divider(color: Colors.black45, thickness: 1, height: 14),
                Text(
                  summary.newspaperHeadline,
                  style: const TextStyle(fontFamily: 'Courier', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.2),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      summary.newspaperBody,
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 11, color: Colors.black87, height: 1.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShopMarket(GameController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: NoirTheme.paperBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DÜKKÂN GELİŞTİRME PAZARI (YATIRIM YAP):',
            style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13, color: NoirTheme.paperInk),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: controller.shopUpgrades.length,
              separatorBuilder: (c, i) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final up = controller.shopUpgrades[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: up.isPurchased ? Colors.green.shade50 : const Color(0xFFEFE8D8),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: up.isPurchased ? Colors.green : NoirTheme.paperBorder),
                  ),
                  child: Row(
                    children: [
                      Text(up.icon, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              up.name,
                              style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12, color: NoirTheme.paperInk),
                            ),
                            Text(
                              up.description,
                              style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      if (up.isPurchased) ...[
                        const Chip(
                          label: Text('SATIN ALINDI ✓', style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                          backgroundColor: Colors.green,
                          visualDensity: VisualDensity.compact,
                        ),
                      ] else ...[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.cash >= up.cost ? NoirTheme.coffeeDark : Colors.grey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          ),
                          onPressed: controller.cash >= up.cost ? () => controller.purchaseUpgrade(up) : null,
                          child: Text(
                            '${up.cost} ₺ SATIN AL',
                            style: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Widget _buildLine(String label, String value, Color color, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontFamily: 'Courier', fontSize: isBold ? 13 : 11, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: NoirTheme.paperInk)),
          Text(value, style: TextStyle(fontFamily: 'Courier', fontSize: isBold ? 14 : 11, fontWeight: isBold ? FontWeight.w900 : FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

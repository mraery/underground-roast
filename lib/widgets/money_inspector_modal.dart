import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../theme/noir_theme.dart';

class MoneyInspectorModal extends StatelessWidget {
  final GameController controller;

  const MoneyInspectorModal({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final customer = controller.currentCustomer;
    if (customer == null) return const SizedBox.shrink();

    final bill = customer.payment;
    final isUv = controller.isUvLightActive;
    final isRuler = controller.isRulerActive;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 620,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isUv ? const Color(0xFF1E1030) : const Color(0xFF1F232B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUv ? NoirTheme.uvPurple : (isRuler ? Colors.cyanAccent : NoirTheme.amberWarm),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isUv ? NoirTheme.uvGlow : Colors.black).withValues(alpha: 0.6),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ÜST BAR: BAŞLIK VE ARAÇLAR
              Row(
                children: [
                  Icon(
                    isUv ? Icons.flare : Icons.search,
                    color: isUv ? Colors.purpleAccent : NoirTheme.amberWarm,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isUv ? 'UV IŞIK TEFTİŞİ' : (isRuler ? 'MİLİMETRİK CETVEL MODU' : 'BANKNOT İNCELEME MASASI'),
                    style: NoirTheme.typewriterSubheading.copyWith(
                      color: isUv ? Colors.purpleAccent : (isRuler ? Colors.cyanAccent : NoirTheme.amberWarm),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),

                  // CETVEL BUTONU
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRuler ? Colors.cyanAccent : Colors.cyan.shade900,
                      foregroundColor: isRuler ? Colors.black : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: controller.toggleRuler,
                    icon: const Icon(Icons.straighten, size: 14),
                    label: Text(
                      isRuler ? 'CETVELİ KALDIR' : 'CETVELLE ÖLÇ',
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 6),

                  // UV IŞIK AÇ/KAPA BUTONU
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUv ? Colors.purpleAccent : Colors.purple.shade900,
                      foregroundColor: isUv ? Colors.black : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    onPressed: controller.toggleUvLight,
                    icon: const Icon(Icons.lightbulb, size: 14),
                    label: Text(
                      isUv ? 'UV KAPAT' : 'UV IŞIĞI AÇ',
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 6),

                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: controller.toggleMoneyInspection,
                  ),
                ],
              ),
              const Divider(color: Colors.white24),
              const SizedBox(height: 10),

              // BANKNOT GÖRSEL ALANI
              Container(
                width: double.infinity,
                height: 190,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isUv
                      ? const Color(0xFF130820)
                      : (bill.isCounterfeit ? const Color(0xFFE5D5BA) : const Color(0xFFD4E2D4)),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isUv ? Colors.purpleAccent.withValues(alpha: 0.5) : Colors.black45,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    // NORMAL IŞIK GÖRÜNÜMÜ
                    if (!isUv) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TÜRKİYE CUMHURİYETİ MERKEZ BANKASI',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: bill.isCounterfeit ? Colors.brown.shade800 : Colors.green.shade900,
                                ),
                              ),
                              Text(
                                '${bill.denomination} ₺',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: bill.isCounterfeit ? Colors.brown.shade800 : Colors.green.shade900,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    bill.isCounterfeit ? '👨🏻‍🎨' : '🇹🇷',
                                    style: const TextStyle(fontSize: 38),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SERİ NO: ${bill.serialNumber}',
                                      style: TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        color: bill.isCounterfeit ? Colors.red.shade900 : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    if (bill.fakeClue != null)
                                      Text(
                                        'Detay: "${bill.fakeClue}"',
                                        style: TextStyle(
                                          fontFamily: 'Courier',
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.brown.shade700,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],

                    // UV IŞIK GÖRÜNÜMÜ
                    if (isUv) ...[
                      if (bill.uvReactive && !bill.isCounterfeit) ...[
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.verified, size: 48, color: Colors.greenAccent),
                              const SizedBox(height: 4),
                              const Text(
                                '✓ RESMİ GÜVENLİK FİLİGRANI DOĞRULANDI',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                'Kılcal lifler parlıyor (${bill.serialNumber})',
                                style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.gpp_bad, size: 50, color: Colors.redAccent),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.redAccent, width: 2),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.red.withValues(alpha: 0.2),
                                ),
                                child: const Text(
                                  'SAHTE / GEÇERSİZ BANKNOT!',
                                  style: TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                bill.fakeClue ?? 'Filigran sahte veya yok!',
                                style: const TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 11,
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],

                    // CETVEL KATMANI (RULER OVERLAY)
                    if (isRuler) ...[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.yellow.withValues(alpha: 0.85),
                            border: Border.all(color: Colors.black87),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Text('0 mm', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                'ÖLÇÜLEN EN: ${bill.widthMm.toStringAsFixed(1)} mm ${bill.hasSizeDefect ? '(HATALI EBAT!)' : '(STANDART)'}',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 11,
                                  color: bill.hasSizeDefect ? Colors.red.shade900 : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Text('${bill.widthMm.toInt()} mm', style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // BİLGİ KUTUSU
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 14, color: NoirTheme.amberWarm),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        controller.currentBulletin.blacklistedSerialNumbers.contains(bill.serialNumber)
                            ? 'DİKKAT: Seri no (${bill.serialNumber}) BÜLTENDE KARA LİSTEDE!'
                            : (bill.hasSizeDefect
                                ? 'ŞÜPHELİ EBAT: Standart Türk Lirası 148 mm\'dir. Bu banknot ${bill.widthMm} mm olarak basılmış!'
                                : 'İpucu: UV ve Cetvel araçlarını kullanarak sahtekarlıkları ortaya çıkarın.'),
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 11,
                          color: (controller.currentBulletin.blacklistedSerialNumbers.contains(bill.serialNumber) || bill.hasSizeDefect)
                              ? Colors.redAccent
                              : Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

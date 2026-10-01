import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../theme/noir_theme.dart';

class InspectionDesk extends StatelessWidget {
  final GameController controller;

  const InspectionDesk({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final customer = controller.currentCustomer;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NoirTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NoirTheme.surfaceBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BAŞLIK
          Row(
            children: [
              const Icon(Icons.shield_outlined, color: Colors.amberAccent, size: 20),
              const SizedBox(width: 8),
              Text(
                'TEFTİŞ VE KARAR MASASI',
                style: NoirTheme.typewriterSubheading.copyWith(
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // TELSİZ BUTONU
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF132B1E),
                  foregroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: const BorderSide(color: Colors.greenAccent),
                  ),
                ),
                onPressed: controller.toggleRadioScanner,
                icon: const Icon(Icons.radio, size: 14, color: Colors.greenAccent),
                label: const Text(
                  'TELSİZ DİNLE',
                  style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(color: NoirTheme.surfaceBorder),
          const SizedBox(height: 4),

          Expanded(
            child: Row(
              children: [
                // SOL: TEZGÂHTAKİ PARA VE EŞYALAR
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TEZGÂHTAKİ ÖDEME:',
                            style: TextStyle(fontFamily: 'Courier', fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                          // Otomatik Sahte Dedektörü Işığı (Satın Alındıysa!)
                          if (controller.hasAutoFakeDetector && customer != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: customer.payment.isCounterfeit ? Colors.red.shade900 : Colors.green.shade900,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    customer.payment.isCounterfeit ? Icons.warning : Icons.check,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    customer.payment.isCounterfeit ? 'DEDEKTÖR: SAHTE!' : 'DEDEKTÖR: TEMİZ',
                                    style: const TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      if (customer != null) ...[
                        // PARA KARTI (Tıklanabilir İnceleme)
                        InkWell(
                          onTap: controller.toggleMoneyInspection,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF242A35),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.amber.shade700, width: 1.5),
                              boxShadow: [
                                BoxShadow(color: Colors.amber.withValues(alpha: 0.15), blurRadius: 6),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(Icons.attach_money, color: Colors.amberAccent, size: 20),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${customer.payment.denomination} ₺ BANKNOT',
                                        style: const TextStyle(
                                          fontFamily: 'Courier',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                      Text(
                                        'Seri No: ${customer.payment.serialNumber}',
                                        style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.zoom_in, color: Colors.amberAccent, size: 20),
                              ],
                            ),
                          ),
                        ),

                        // MÜŞTERİNİN BIRAKTIĞI GİZLİ EŞYA / EMANET
                        if (customer.contrabandToLeave != null) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.orangeAccent),
                            ),
                            child: Row(
                              children: [
                                Text(customer.contrabandToLeave!.icon, style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        customer.contrabandToLeave!.title,
                                        style: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                                      ),
                                      Text(
                                        customer.contrabandToLeave!.description,
                                        style: const TextStyle(fontFamily: 'Courier', fontSize: 9, color: Colors.white70),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ] else ...[
                        const Center(
                          child: Text('Tezgâh boş...', style: TextStyle(fontFamily: 'Courier', color: Colors.white30)),
                        ),
                      ],

                      const Spacer(),
                      // ALT BUTONLAR (BÜLTEN & ZULA)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                side: const BorderSide(color: Colors.white24),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: controller.toggleBulletin,
                              icon: const Icon(Icons.assignment, size: 14, color: Colors.white70),
                              label: const Text('BÜLTEN', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                side: const BorderSide(color: Colors.orangeAccent),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: controller.toggleStash,
                              icon: const Icon(Icons.inventory_2, size: 14, color: Colors.orangeAccent),
                              label: const Text('ZULA', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.orangeAccent)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // SAĞ: KARAR DÜĞMELERİ (KABUL, RET, ALARM)
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. SERVİS ET & KABUL ET
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: NoirTheme.stampGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: controller.interactionState == CustomerInteractionState.ordering
                              ? controller.serveDrinkAndAcceptPayment
                              : null,
                          icon: const Icon(Icons.check_circle_outline, size: 18),
                          label: const Text(
                            'KAHVEYİ VER & AL',
                            style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 2. REDDET / KOV (Kırmızı Damga)
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: NoirTheme.stampRed,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: controller.interactionState == CustomerInteractionState.ordering
                              ? controller.rejectCustomer
                              : null,
                          icon: const Icon(Icons.block, size: 18),
                          label: const Text(
                            'REDDET & KOV',
                            style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 3. GİZLİ POLİS ALARMI
                      SizedBox(
                        width: double.infinity,
                        height: 38,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue.withValues(alpha: 0.15),
                            side: const BorderSide(color: Colors.lightBlueAccent, width: 1.5),
                            foregroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: controller.interactionState == CustomerInteractionState.ordering
                              ? controller.triggerPoliceAlarm
                              : null,
                          icon: const Icon(Icons.notifications_active, size: 16),
                          label: const Text(
                            'GİZLİ ALARM (POLİS)',
                            style: TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

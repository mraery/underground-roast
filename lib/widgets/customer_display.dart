import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/customer.dart';
import '../theme/noir_theme.dart';

class CustomerDisplay extends StatelessWidget {
  final GameController controller;

  const CustomerDisplay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final customer = controller.currentCustomer;

    if (customer == null) {
      return Container(
        height: 200,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: NoirTheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: NoirTheme.surfaceBorder),
        ),
        child: const Center(
          child: Text(
            'Vardiya sona eriyor... Tezgâhta kimse kalmadı.',
            style: NoirTheme.typewriterSubheading,
          ),
        ),
      );
    }

    String currentDialogue;
    switch (controller.interactionState) {
      case CustomerInteractionState.ordering:
        currentDialogue = customer.orderDialogue;
        break;
      case CustomerInteractionState.served:
        currentDialogue = customer.onServedDialogue;
        break;
      case CustomerInteractionState.rejected:
        currentDialogue = customer.onRejectedDialogue;
        break;
      case CustomerInteractionState.reported:
        currentDialogue = customer.onReportedDialogue;
        break;
      case CustomerInteractionState.contrabandGiven:
        currentDialogue = customer.onContrabandReceivedDialogue ?? 'Emaneti aldı.';
        break;
    }

    return Container(
      height: 225,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NoirTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NoirTheme.surfaceBorder, width: 1.5),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E212B),
            Color(0xFF161820),
            Color(0xFF0F1014),
          ],
        ),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KARAKTER PORTRESİ (PAPERS, PLEASE RETRO PIXEL ART)
              _buildAvatar(customer),
              const SizedBox(width: 16),

              // DİYALOG VE SİPARİŞ BİLGİSİ
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // İSİM VE ROL ETİKETİ
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              customer.name,
                              style: NoirTheme.typewriterHeading.copyWith(
                                fontSize: 16,
                                color: Colors.amber.shade300,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                customer.role,
                                style: const TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SİPARİŞ ROZETİ
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: NoirTheme.coffeeDark,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: NoirTheme.amberWarm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.coffee, size: 14, color: NoirTheme.amberWarm),
                              const SizedBox(width: 4),
                              Text(
                                'SİPARİŞ: ${customer.requestedDrink.name.toUpperCase()}',
                                style: const TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: NoirTheme.amberWarm,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // KONUŞMA BALONU (PAPERS, PLEASE DAKTİLO TRANSKRİPTİ)
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181B22),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade900.withValues(alpha: 0.5), width: 1.5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '▶ ',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 16,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  '"$currentDialogue"',
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 16,
                                    color: Color(0xFFEEEEEE),
                                    fontWeight: FontWeight.w600,
                                    height: 1.35,
                                    letterSpacing: 0.4,
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
              ),
            ],
          ),

          // DAMGALAR (PAPERS, PLEASE TARZI RET VEYA KABUL DAMGASI)
          if (controller.interactionState == CustomerInteractionState.rejected)
            Positioned(
              right: 20,
              bottom: 10,
              child: _buildStamp(
                text: 'REDDEDİLDİ',
                color: NoirTheme.stampRed,
                angle: -0.15,
              ),
            ),

          if (controller.interactionState == CustomerInteractionState.reported)
            Positioned(
              right: 20,
              bottom: 10,
              child: _buildStamp(
                text: 'İHBAR EDİLDİ',
                color: Colors.blueAccent.shade400,
                angle: 0.12,
              ),
            ),

          if (controller.interactionState == CustomerInteractionState.served)
            Positioned(
              right: 20,
              bottom: 10,
              child: _buildStamp(
                text: 'SERVİS EDİLDİ',
                color: NoirTheme.stampGreen,
                angle: -0.08,
              ),
            ),

          // SONRAKİ MÜŞTERİYE GEÇİŞ BUTONU (Eğer karar verildiyse)
          if (controller.interactionState != CustomerInteractionState.ordering)
            Positioned(
              right: 12,
              top: 12,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: NoirTheme.amberWarm,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: controller.nextCustomer,
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text(
                  'SIRADAKİ MÜŞTERİ >>',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(Customer customer) {
    return Container(
      width: 125,
      height: 155,
      decoration: BoxDecoration(
        color: const Color(0xFF101216),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade700.withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                customer.portraitAssetPath,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.none, // Pixel-art için net pikseller
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackIcon(customer);
                },
              ),
            ),
            // Papers Please tarzı kimlik şeridi
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                color: Colors.black.withValues(alpha: 0.8),
                child: Text(
                  customer.id.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 10,
                    color: Colors.amber.shade300,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon(Customer customer) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (customer.avatarCode) {
      case 'baker':
        icon = Icons.bakery_dining;
        iconColor = Colors.orange.shade300;
        bgColor = const Color(0xFF332211);
        break;
      case 'shady_clown':
        icon = Icons.theater_comedy;
        iconColor = Colors.amberAccent;
        bgColor = const Color(0xFF2E2412);
        break;
      case 'syndicate_agent':
        icon = Icons.visibility;
        iconColor = Colors.purpleAccent;
        bgColor = const Color(0xFF1E1528);
        break;
      case 'courier_nervous':
        icon = Icons.delivery_dining;
        iconColor = Colors.cyanAccent;
        bgColor = const Color(0xFF11252B);
        break;
      case 'hitman':
        icon = Icons.crisis_alert;
        iconColor = Colors.redAccent;
        bgColor = const Color(0xFF2E1111);
        break;
      case 'detective':
        icon = Icons.local_police;
        iconColor = Colors.blueAccent;
        bgColor = const Color(0xFF111E2E);
        break;
      case 'trenchcoat_man':
        icon = Icons.person_search;
        iconColor = Colors.tealAccent;
        bgColor = const Color(0xFF112522);
        break;
      case 'assassin_mask':
        icon = Icons.masks;
        iconColor = Colors.red.shade400;
        bgColor = const Color(0xFF351212);
        break;
      default:
        icon = Icons.person;
        iconColor = Colors.white70;
        bgColor = const Color(0xFF222222);
    }

    return Container(
      color: bgColor,
      child: Center(
        child: Icon(icon, size: 54, color: iconColor),
      ),
    );
  }

  Widget _buildStamp({required String text, required Color color, required double angle}) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 12,
            ),
          ],
        ),
        child: Text(
          text,
          style: NoirTheme.stampText.copyWith(
            color: color,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

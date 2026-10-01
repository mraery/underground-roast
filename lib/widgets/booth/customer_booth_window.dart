import 'package:flutter/material.dart';
import '../../controllers/game_controller.dart';
import '../../models/customer.dart';
import '../../models/drink.dart';
import '../../theme/noir_theme.dart';

class CustomerBoothWindow extends StatelessWidget {
  final GameController controller;

  const CustomerBoothWindow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final customer = controller.currentCustomer;

    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF14171E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2C3240), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.7),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // 1. ARKA PLAN: SOKAK VE GİŞE PENCERESİ
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.2),
                    radius: 1.2,
                    colors: [
                      Color(0xFF232936),
                      Color(0xFF11141A),
                      Color(0xFF080A0D),
                    ],
                  ),
                ),
              ),
            ),

            // PENCERE DEMİR PARMAKLIKLARI VE ÇERÇEVE
            Positioned.fill(
              child: CustomPaint(
                painter: _BoothWindowPainter(),
              ),
            ),

            if (customer != null) ...[
              // 2. MÜŞTERİ (PAPERS PLEASE GİBİ TAM KARŞIMIZDA DURUYOR)
              Positioned(
                left: 24,
                bottom: 25,
                child: _buildCustomerInWindow(customer),
              ),

              // 3. İSİM VE SİPARİŞ KÜNYESİ (GİŞE CAMI ÜSTÜ)
              Positioned(
                left: 175,
                top: 12,
                right: 180,
                child: _buildCustomerHeader(customer),
              ),

              // 4. İNTERKOM / KONUŞMA BALONU
              Positioned(
                left: 175,
                top: 55,
                right: 180,
                bottom: 30,
                child: _buildSpeechTerminal(customer),
              ),

              // 5. MÜŞTERİ SERVİS TEPSİSİ (KAHVENİN BIRAKILACAĞI YER)
              Positioned(
                right: 16,
                top: 14,
                bottom: 22,
                width: 150,
                child: _buildServiceTray(context),
              ),
            ] else ...[
              // MÜŞTERİ YOKKEN (VARDİYA ARASI)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.door_sliding_outlined, size: 56, color: Colors.white.withValues(alpha: 0.3)),
                    const SizedBox(height: 8),
                    const Text(
                      'GİŞE BOŞ - SIRADAKİ MÜŞTERİ BEKLENİYOR...',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 14,
                        color: Colors.white54,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // 6. TEZGÂHIN ÖN KORKULUĞU (AHŞAP BANKO ÇİZGİSİ)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 18,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3D2B1F),
                      Color(0xFF5A402E),
                      Color(0xFF2B1D14),
                    ],
                  ),
                  border: Border(
                    top: BorderSide(color: Color(0xFF7A583F), width: 1.5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '--- TEZGÂH GİŞESİ ---',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 8,
                      color: Color(0xFFD4B996),
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInWindow(Customer customer) {
    return Container(
      width: 135,
      height: 185,
      decoration: BoxDecoration(
        color: const Color(0xFF0C0E12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4A5568), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 15,
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
                filterQuality: FilterQuality.none, // Net Papers Please pikselleri
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF1E2430),
                  child: Center(
                    child: Icon(Icons.person, size: 64, color: Colors.amber.shade200),
                  ),
                ),
              ),
            ),
            // Gişe camı parlaması
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.08),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.25),
                    ],
                  ),
                ),
              ),
            ),
            // Alt kimlik etiketi
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                color: Colors.black.withValues(alpha: 0.85),
                child: Text(
                  customer.id.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 9,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerHeader(Customer customer) {
    return Row(
      children: [
        Flexible(
          child: Text(
            customer.name.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF222938),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF3E4A63)),
          ),
          child: Text(
            customer.role,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ),
        const Spacer(),
        // SİPARİŞ
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF2B1D0E),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: NoirTheme.amberWarm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.coffee, size: 14, color: NoirTheme.amberWarm),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'SİPARİŞ: ${customer.requestedDrink.name.toUpperCase()}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: NoirTheme.amberWarm,
                      letterSpacing: 0.8,
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

  Widget _buildSpeechTerminal(Customer customer) {
    String dialogue;
    switch (controller.interactionState) {
      case CustomerInteractionState.ordering:
        dialogue = customer.orderDialogue;
        break;
      case CustomerInteractionState.served:
        dialogue = customer.onServedDialogue;
        break;
      case CustomerInteractionState.rejected:
        dialogue = customer.onRejectedDialogue;
        break;
      case CustomerInteractionState.reported:
        dialogue = customer.onReportedDialogue;
        break;
      case CustomerInteractionState.contrabandGiven:
        dialogue = customer.onContrabandReceivedDialogue ?? 'Emaneti aldı.';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1218),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2E384D), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mikrofon ikonu / Hoparlör
          Column(
            children: [
              const Icon(Icons.volume_up, size: 18, color: Colors.amber),
              const SizedBox(height: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                '"$dialogue"',
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 15,
                  color: Color(0xFFF0F0F0),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTray(BuildContext context) {
    final bool canServe = controller.interactionState == CustomerInteractionState.ordering;

    return DragTarget<PreparedDrink>(
      onWillAcceptWithDetails: (details) => canServe,
      onAcceptWithDetails: (details) {
        final drink = details.data;
        controller.servePreparedDrink(drink);
      },
      builder: (context, candidateData, rejectedData) {
        final bool isHovered = candidateData.isNotEmpty;

        return Container(
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF1E3A20) : const Color(0xFF151922),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHovered ? Colors.greenAccent : const Color(0xFF3B4860),
              width: isHovered ? 2.5 : 1.5,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: Colors.greenAccent.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.room_service,
                size: 38,
                color: isHovered ? Colors.greenAccent : const Color(0xFF8B9BB4),
              ),
              const SizedBox(height: 6),
              Text(
                isHovered ? 'BURAYA BIRAK!' : 'SERVİS TEPSİSİ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isHovered ? Colors.greenAccent : const Color(0xFF8B9BB4),
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                canServe ? 'Kahveyi buraya\nsürükle' : 'Karar verildi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 9,
                  color: isHovered ? Colors.white : Colors.white38,
                ),
              ),
              if (!canServe) ...[
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: const Size(100, 26),
                  ),
                  onPressed: controller.nextCustomer,
                  child: const Text(
                    'SIRADAKİ >>',
                    style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _BoothWindowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = const Color(0xFF2D3546)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Gişe pencere çerçevesi
    final rect = Rect.fromLTWH(18, 8, 145, 205);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), borderPaint);

    // Üst metal perçinler
    final rivetPaint = Paint()..color = const Color(0xFF4A5568);
    for (double x = 30; x < size.width - 20; x += 60) {
      canvas.drawCircle(Offset(x, 6), 2, rivetPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

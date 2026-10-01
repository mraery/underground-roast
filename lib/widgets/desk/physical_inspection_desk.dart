import 'package:flutter/material.dart';
import '../../controllers/game_controller.dart';
import '../../models/item.dart';

class PhysicalInspectionDesk extends StatefulWidget {
  final GameController controller;

  const PhysicalInspectionDesk({super.key, required this.controller});

  @override
  State<PhysicalInspectionDesk> createState() => _PhysicalInspectionDeskState();
}

class _PhysicalInspectionDeskState extends State<PhysicalInspectionDesk> {
  // Paranın masa üstündeki pozisyonu (Sürükleme)
  Offset banknoteOffset = const Offset(20, 20);
  bool isBanknoteUnderUv = false;
  bool isRulerAligned = false;

  @override
  void didUpdateWidget(covariant PhysicalInspectionDesk oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Müşteri değiştiğinde parayı başlangıç noktasına koy
    if (oldWidget.controller.currentCustomer?.id != widget.controller.currentCustomer?.id) {
      setState(() {
        banknoteOffset = const Offset(20, 20);
        isBanknoteUnderUv = false;
        isRulerAligned = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final customer = widget.controller.currentCustomer;
    final payment = customer?.payment;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1712), // Koyu Ahşap Masa Rengi
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF4A3828), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.7),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. MASA ÜSTÜ ARAÇ ÇUBUĞU (BÜLTEN, ZULA, TELSİZ)
          _buildDeskHeader(),

          // 2. FİZİKSEL MASA YÜZEYİ (PARANIN VE ARAÇLARIN BULUNDUĞU ALAN)
          Expanded(
            child: Stack(
              children: [
                // Ahşap masa dokusu
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF2C1F16),
                          Color(0xFF1F150E),
                          Color(0xFF140D08),
                        ],
                      ),
                    ),
                  ),
                ),

                // A. MOR UV IŞIK İSTASYONU (MASANIN SOL ORTA KISMINDA)
                Positioned(
                  left: 12,
                  top: 10,
                  bottom: 10,
                  width: 170,
                  child: _buildUvLightStation(),
                ),

                // B. SÜRÜKLENEBİLİR FİZİKSEL BANKNOT
                if (payment != null)
                  Positioned(
                    left: banknoteOffset.dx,
                    top: banknoteOffset.dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          banknoteOffset += details.delta;
                          // UV alanında mı kontrolü (Sol 12 - 180 piksel arası)
                          isBanknoteUnderUv = (banknoteOffset.dx < 160);
                        });
                      },
                      child: _buildPhysicalBanknote(payment),
                    ),
                  ),

                // C. MİLİMETRİK CETVEL (AÇIKSA PARANIN ALTINDA GÖZÜKÜR)
                if (isRulerAligned && payment != null)
                  Positioned(
                    left: banknoteOffset.dx,
                    top: banknoteOffset.dy + 95,
                    child: _buildPhysicalRuler(payment.widthMm),
                  ),

                // D. SAĞ TARAF: FİZİKSEL DAMGALAR VE ALARM BUTONU
                Positioned(
                  right: 12,
                  top: 10,
                  bottom: 10,
                  width: 140,
                  child: _buildStampAndAlarmRack(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeskHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF18120D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        border: Border(bottom: BorderSide(color: Color(0xFF38271A))),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, size: 16, color: Colors.amber),
          const SizedBox(width: 6),
          const Flexible(
            child: Text(
              '🛡️ TEFTİŞ MASASI & FİZİKSEL BANKNOT',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(width: 6),
          // CETVELİ ÇIKAR / GİZLE
          InkWell(
            onTap: () => setState(() => isRulerAligned = !isRulerAligned),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isRulerAligned ? Colors.amber.shade900 : Colors.black45,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isRulerAligned ? Colors.amber : Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.straighten, size: 13, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    isRulerAligned ? 'CETVEL KALDIR' : '📏 CETVEL',
                    style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          // BÜLTENİ AÇ
          InkWell(
            onTap: widget.controller.toggleBulletin,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF2C3E50),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.assignment, size: 13, color: Colors.cyanAccent),
                  SizedBox(width: 4),
                  Text('📋 BÜLTEN', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUvLightStation() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isBanknoteUnderUv ? const Color(0xFF250F38) : const Color(0xFF140C1A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isBanknoteUnderUv ? Colors.purpleAccent : const Color(0xFF5A2A7A),
          width: 2,
        ),
        boxShadow: [
          if (isBanknoteUnderUv)
            BoxShadow(
              color: Colors.purpleAccent.withValues(alpha: 0.4),
              blurRadius: 15,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wb_incandescent,
            size: 32,
            color: isBanknoteUnderUv ? Colors.purpleAccent : Colors.purple.shade300,
          ),
          const SizedBox(height: 6),
          Text(
            '💡 MOR UV IŞIK',
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isBanknoteUnderUv ? Colors.purpleAccent : Colors.purple.shade200,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isBanknoteUnderUv ? 'PARAYI AYDINLATIYOR!' : 'Parayı buraya\nsürükleyin',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 9,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhysicalBanknote(Banknote payment) {
    final bool underUv = isBanknoteUnderUv;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 215,
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: underUv
              ? const Color(0xFF2C1542) // Mor UV Işık Altında Koyu Neon Renk
              : (payment.denomination >= 200 ? const Color(0xFFD4A373) : const Color(0xFF90BE6D)),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: underUv ? Colors.purpleAccent : const Color(0xFF2B2B2B),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
            if (underUv)
              BoxShadow(
                color: Colors.purpleAccent.withValues(alpha: 0.5),
                blurRadius: 12,
              ),
          ],
        ),
        child: Stack(
          children: [
            // Klasik Banknot Çerçevesi
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: underUv ? Colors.purple.shade300 : Colors.black38,
                  width: 1,
                ),
              ),
            ),

            // 1. BANKNOT METİNLERİ VE BİLGİLERİ
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'TÜRKİYE CUMHURİYETİ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: underUv ? Colors.purple.shade200 : Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${payment.denomination} ₺',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: underUv ? Colors.cyanAccent : Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // ATATÜRK SİLUETİ VEYA SAHTE KARALAMA
                  Center(
                    child: underUv
                        ? (payment.isCounterfeit
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                color: Colors.black87,
                                child: Text(
                                  payment.fakeClue ?? '⚠️ PASTEL BOYA SAHTESİ!',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.verified, size: 14, color: Colors.cyanAccent),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      'GÜVENLİK FİLİGRANI ✓',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Courier',
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyanAccent.shade100,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.account_balance, size: 16, color: Colors.black45),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  '${payment.denomination} TL',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),

                  // SERİ NUMARASI
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'SERİ: ${payment.serialNumber}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: underUv ? Colors.pinkAccent : const Color(0xFF1E3A8A),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'BAŞKAN',
                        style: TextStyle(fontFamily: 'Courier', fontSize: 7, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicalRuler(double widthMm) {
    return Container(
      width: 215,
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDEB887),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xFF8B4513), width: 1.5),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('| 0', style: TextStyle(fontFamily: 'Courier', fontSize: 8, color: Colors.brown, fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              'ÖLÇÜ: ${widthMm.toInt()} mm ${widthMm < 145 ? "(STANDART ALTI!)" : ""}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 8.5,
                fontWeight: FontWeight.bold,
                color: widthMm < 145 ? Colors.red.shade900 : Colors.brown.shade900,
              ),
            ),
          ),
          const Text('160 |', style: TextStyle(fontFamily: 'Courier', fontSize: 8, color: Colors.brown, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStampAndAlarmRack() {
    final bool canDecide = widget.controller.interactionState == CustomerInteractionState.ordering;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF18130E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF38291B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 1. YEŞİL KABUL DAMGASI
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E5E2E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: canDecide ? widget.controller.serveDrinkAndAcceptPayment : null,
            icon: const Icon(Icons.check_circle, size: 16, color: Colors.greenAccent),
            label: const Text(
              '✓ KABUL ET',
              style: TextStyle(fontFamily: 'Courier', fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),

          // 2. KIRMIZI RET DAMGASI
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7A1E1E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: canDecide ? widget.controller.rejectCustomer : null,
            icon: const Icon(Icons.cancel, size: 16, color: Colors.redAccent),
            label: const Text(
              '✕ REDDET',
              style: TextStyle(fontFamily: 'Courier', fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),

          // 3. MASA ALTI GİZLİ ALARM BUTONU
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F2E5C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: canDecide ? widget.controller.triggerPoliceAlarm : null,
            icon: const Icon(Icons.emergency, size: 16, color: Colors.lightBlueAccent),
            label: const Text(
              '🚨 ALARM BAS',
              style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

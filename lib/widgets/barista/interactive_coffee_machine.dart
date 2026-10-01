import 'dart:async';
import 'package:flutter/material.dart';
import '../../controllers/game_controller.dart';
import '../../models/drink.dart';
import '../../theme/noir_theme.dart';

class InteractiveCoffeeMachine extends StatefulWidget {
  final GameController controller;

  const InteractiveCoffeeMachine({super.key, required this.controller});

  @override
  State<InteractiveCoffeeMachine> createState() => _InteractiveCoffeeMachineState();
}

class _InteractiveCoffeeMachineState extends State<InteractiveCoffeeMachine> {
  // Tezgâhtaki aktif fincan durumu
  PreparedDrink activeDrink = PreparedDrink();
  bool hasCupOnCounter = false;
  bool isCupUnderGroupHead = false;

  // Buhar ve Çekim Animasyon Durumları
  bool isBrewing = false;
  bool isSteamingMilk = false;
  bool isPitcherFoamed = false;
  int milkFoamSeconds = 0;
  Timer? _brewTimer;
  Timer? _steamTimer;

  @override
  void dispose() {
    _brewTimer?.cancel();
    _steamTimer?.cancel();
    super.dispose();
  }

  void _startBrewing(bool isDouble) {
    if (!hasCupOnCounter || isBrewing) return;

    setState(() {
      isBrewing = true;
      isCupUnderGroupHead = true;
    });

    _brewTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        isBrewing = false;
        activeDrink.espressoShots += isDouble ? 2 : 1;
        activeDrink.extractionQuality = ExtractionQuality.perfect;
        widget.controller.currentDrink = activeDrink;
      });
    });
  }

  void _addHotWater() {
    if (!hasCupOnCounter) return;
    setState(() {
      activeDrink.hasHotWater = true;
      widget.controller.currentDrink = activeDrink;
    });
  }

  void _startSteamingMilk() {
    if (isSteamingMilk) return;

    setState(() {
      isSteamingMilk = true;
      milkFoamSeconds = 0;
    });

    _steamTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (!mounted) return;
      setState(() {
        milkFoamSeconds++;
        if (milkFoamSeconds >= 3) {
          isSteamingMilk = false;
          isPitcherFoamed = true;
          timer.cancel();
        }
      });
    });
  }

  void _pourMilkIntoCup() {
    if (!hasCupOnCounter) return;

    setState(() {
      activeDrink.milkQuality = MilkQuality.perfect;
      activeDrink.foamLevel = (milkFoamSeconds >= 3) ? FoamLevel.high : FoamLevel.low;
      isPitcherFoamed = false;
      milkFoamSeconds = 0;
      widget.controller.currentDrink = activeDrink;
    });
  }

  void _resetCup() {
    setState(() {
      hasCupOnCounter = false;
      isCupUnderGroupHead = false;
      isPitcherFoamed = false;
      isBrewing = false;
      isSteamingMilk = false;
      activeDrink = PreparedDrink();
      widget.controller.currentDrink.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16181F),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2C3240), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // BAŞLIK VE GÖSTERGELER
          _buildMachineHeader(),

          // MAKİNE GÖVDESİ & ETKİLEŞİMLİ ALAN
          Expanded(
            child: Row(
              children: [
                // 1. SOL ALAN: KAHVE MAKİNESİ & BUHAR ÇUBUĞU
                Expanded(
                  flex: 6,
                  child: _buildEspressoMachineBody(),
                ),

                // 2. SAĞ ALAN: FİNCAN SEÇİMİ, ŞİŞELER & ÇÖP
                Expanded(
                  flex: 4,
                  child: _buildIngredientsAndCupsRack(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMachineHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF202530),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        border: Border(bottom: BorderSide(color: Color(0xFF3B465C))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.coffee_maker, size: 18, color: NoirTheme.amberWarm),
              SizedBox(width: 8),
              Text(
                '☕ İTALYAN ESPRESSO & BARİSTA MAKİNESİ',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: NoirTheme.amberWarm,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          // MANOMETRE / BASINÇ GÖSTERGESİ
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isBrewing ? Colors.greenAccent : (isSteamingMilk ? Colors.cyanAccent : Colors.orangeAccent),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  isBrewing ? 'BASINÇ: 9 BAR (ÇEKİLİYOR)' : (isSteamingMilk ? 'BUHAR: 1.2 BAR' : 'HAZIR: 93°C'),
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEspressoMachineBody() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A2E3B),
            Color(0xFF1E212B),
            Color(0xFF15171F),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4A5568)),
      ),
      child: Stack(
        children: [
          // 1. GRUP BAŞLIĞI VE ÇUBUKLAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // A. GRUP BAŞLIĞI (ESPRESSO AKITMA)
              Column(
                children: [
                  Container(
                    width: 70,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A5568),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.amber.shade700),
                    ),
                    child: const Center(
                      child: Text(
                        'GRUP 1',
                        style: TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold, color: Colors.amber),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 14,
                    color: const Color(0xFF1A1A1A),
                  ),
                  if (isBrewing)
                    Container(
                      width: 4,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B2211),
                        boxShadow: [
                          BoxShadow(color: Color(0xFF6A3B14), blurRadius: 4),
                        ],
                      ),
                    )
                  else
                    const SizedBox(height: 35),

                  // ESPRESSO ÇEKME BUTONLARI / KOLLARI
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3D2516),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          minimumSize: const Size(54, 26),
                        ),
                        onPressed: hasCupOnCounter ? () => _startBrewing(false) : null,
                        child: const Text('1 SHOT', style: TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5A341D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          minimumSize: const Size(54, 26),
                        ),
                        onPressed: hasCupOnCounter ? () => _startBrewing(true) : null,
                        child: const Text('DUBLE', style: TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),

              // B. SICAK SU MUSLUĞU (AMERICANO)
              Column(
                children: [
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B3A4A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text('SU', style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: Colors.lightBlueAccent)),
                    ),
                  ),
                  Container(width: 8, height: 18, color: Colors.grey.shade600),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A5F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: const Size(60, 26),
                    ),
                    onPressed: hasCupOnCounter ? _addHotWater : null,
                    child: const Text('+ SICAK SU', style: TextStyle(fontFamily: 'Courier', fontSize: 8)),
                  ),
                ],
              ),

              // C. BUHAR ÇUBUĞU & SÜT KÖPÜRTME
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF38404D),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text('BUHAR', style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: Colors.white70)),
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  if (isSteamingMilk)
                    const Text('💨💨💨', style: TextStyle(fontSize: 16))
                  else
                    const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPitcherFoamed ? Colors.green.shade800 : const Color(0xFF4A4E59),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      minimumSize: const Size(65, 26),
                    ),
                    onPressed: _startSteamingMilk,
                    child: Text(
                      isSteamingMilk ? 'KÖPÜRTÜLÜYOR' : (isPitcherFoamed ? 'SÜT KÖPÜRDÜ ✓' : 'SÜT KÖPÜRT'),
                      style: const TextStyle(fontFamily: 'Courier', fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isPitcherFoamed)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade800,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          minimumSize: const Size(65, 22),
                        ),
                        onPressed: hasCupOnCounter ? _pourMilkIntoCup : null,
                        child: const Text('FİNCANA DÖK', style: TextStyle(fontFamily: 'Courier', fontSize: 8)),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // 2. TEZGÂHTAKİ AKTİF FİNCAN (SÜRÜKLENEBİLİR OLAN ANA KAHVE)
          Positioned(
            left: 20,
            bottom: 8,
            right: 20,
            child: _buildCounterCupArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterCupArea() {
    if (!hasCupOnCounter) {
      // Fincan henüz tezgaha konulmamış
      return DragTarget<CupSize>(
        onWillAcceptWithDetails: (details) => true,
        onAcceptWithDetails: (details) {
          setState(() {
            hasCupOnCounter = true;
            activeDrink = PreparedDrink(cupSize: details.data);
            widget.controller.currentDrink = activeDrink;
          });
        },
        builder: (context, candidateData, rejectedData) {
          final isHover = candidateData.isNotEmpty;
          return Container(
            height: 65,
            decoration: BoxDecoration(
              color: isHover ? Colors.amber.withValues(alpha: 0.15) : Colors.black26,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isHover ? Colors.amber : Colors.white24,
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            child: const Center(
              child: Text(
                '⬇ SAĞDAN FİNCANI BURAYA SÜRÜKLE ⬇',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 11,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      );
    }

    // Tezgâhta fincan var ve dolduruluyor!
    // Bu fincan MÜŞTERİ SERVİS TEPSİSİNE SÜRÜKLENEBİLİR!
    return Draggable<PreparedDrink>(
      data: activeDrink,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.9,
          child: _buildVisualCup(activeDrink, isDragging: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildVisualCup(activeDrink),
      ),
      child: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF101217),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade600, width: 1.5),
        ),
        child: Row(
          children: [
            _buildVisualCup(activeDrink),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${activeDrink.cupSize?.label.toUpperCase() ?? "FİNCAN"} (DOLDURULUYOR)',
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getDrinkSummaryText(activeDrink),
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // SERVİSE GÖTÜR ETİKETİ
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade900,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.pan_tool_alt, size: 14, color: Colors.greenAccent),
                  Text(
                    'TEPSİYE SÜRÜKLE',
                    style: TextStyle(fontFamily: 'Courier', fontSize: 8, color: Colors.greenAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualCup(PreparedDrink drink, {bool isDragging = false}) {
    return Container(
      width: isDragging ? 55 : 45,
      height: isDragging ? 60 : 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
        border: Border.all(color: const Color(0xFF718096), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 4),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            // ESPRESSO KATMANI
            if (drink.espressoShots > 0)
              Container(
                height: (drink.espressoShots * 12.0).clamp(0, 30),
                color: const Color(0xFF331D0F),
              ),
            // SU KATMANI
            if (drink.hasHotWater)
              Container(
                height: 10,
                color: const Color(0xFF4A6B82).withValues(alpha: 0.7),
              ),
            // SÜT VE KÖPÜK KATMANI
            if (drink.milkQuality != MilkQuality.none)
              Container(
                height: 12,
                color: const Color(0xFFF7FAFC),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsAndCupsRack() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E222D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF384255)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '📦 FİNCANLAR & MALZEMELER',
            style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          const SizedBox(height: 6),

          // 1. BOŞ FİNCANLAR (SÜRÜKLENEBİLİR)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDraggableCupIcon(CupSize.small, 'Küçük (30ml)', 28),
              _buildDraggableCupIcon(CupSize.medium, 'Standart', 34),
              _buildDraggableCupIcon(CupSize.large, 'Büyük', 40),
            ],
          ),
          const Divider(color: Colors.white24, height: 16),

          // 2. ÖZEL MALZEMELER (TIKLAYARAK VEYA SÜRÜKLEYEREK EKLENİR)
          const Text(
            'ŞURUPLAR & EKLENTİLER:',
            style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: Colors.white54),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              _buildIngredientButton('🍨 Dondurma', activeDrink.hasIceCream, () {
                setState(() => activeDrink.hasIceCream = !activeDrink.hasIceCream);
              }),
              _buildIngredientButton('🍫 Çikolata', activeDrink.hasChocolate, () {
                setState(() => activeDrink.hasChocolate = !activeDrink.hasChocolate);
              }),
              _buildIngredientButton('🍾 Kaçak Viski', activeDrink.hasWhiskey, () {
                setState(() => activeDrink.hasWhiskey = !activeDrink.hasWhiskey);
              }),
              _buildIngredientButton('🧪 Zehir', activeDrink.hasPoisonDrop, () {
                setState(() => activeDrink.hasPoisonDrop = !activeDrink.hasPoisonDrop);
              }),
            ],
          ),

          const Spacer(),
          // DÖK & SIFIRLA BUTONU
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A1E1E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            onPressed: hasCupOnCounter ? _resetCup : null,
            icon: const Icon(Icons.delete_outline, size: 14),
            label: const Text('FİNCANI DÖK & TEMİZLE', style: TextStyle(fontFamily: 'Courier', fontSize: 9)),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableCupIcon(CupSize size, String label, double iconSize) {
    return Draggable<CupSize>(
      data: size,
      feedback: Material(
        color: Colors.transparent,
        child: Icon(Icons.local_cafe, size: iconSize + 10, color: Colors.amber),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(Icons.local_cafe, size: iconSize, color: Colors.white70),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontFamily: 'Courier', fontSize: 8, color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildIngredientButton(String label, bool isAdded, VoidCallback onTap) {
    return InkWell(
      onTap: hasCupOnCounter ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: isAdded ? Colors.green.shade800 : Colors.black38,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isAdded ? Colors.greenAccent : Colors.white24),
        ),
        child: Text(
          isAdded ? '$label ✓' : label,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 9,
            color: isAdded ? Colors.greenAccent : Colors.white70,
            fontWeight: isAdded ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _getDrinkSummaryText(PreparedDrink drink) {
    List<String> parts = [];
    if (drink.espressoShots > 0) parts.add('${drink.espressoShots} Shot Espresso');
    if (drink.hasHotWater) parts.add('Sıcak Su');
    if (drink.milkQuality != MilkQuality.none) parts.add('Süt');
    if (drink.hasIceCream) parts.add('Dondurma');
    if (drink.hasWhiskey) parts.add('Viski');
    if (drink.hasChocolate) parts.add('Çikolata');
    if (drink.hasPoisonDrop) parts.add('Zehir');
    if (parts.isEmpty) return 'Boş Fincan';
    return parts.join(' + ');
  }
}

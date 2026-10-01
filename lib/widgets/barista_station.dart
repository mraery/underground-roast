import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/drink.dart';
import '../theme/noir_theme.dart';

class BaristaStation extends StatelessWidget {
  final GameController controller;

  const BaristaStation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final drink = controller.currentDrink;

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
              const Icon(Icons.coffee_maker, color: NoirTheme.amberWarm, size: 20),
              const SizedBox(width: 8),
              Text(
                'BARİSTA İSTASYONU',
                style: NoirTheme.typewriterSubheading.copyWith(
                  color: NoirTheme.amberWarm,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (controller.hasItalianMachine) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade900,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '★ İTALYAN GRUP',
                    style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              const Spacer(),
              if (!drink.isEmpty)
                TextButton.icon(
                  onPressed: controller.clearDrink,
                  icon: const Icon(Icons.delete_outline, size: 16, color: Colors.redAccent),
                  label: const Text(
                    'DÖK & SIFIRLA',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      color: Colors.redAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(color: NoirTheme.surfaceBorder),
          const SizedBox(height: 4),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SOL: KONTROLLER VE DÜĞMELER
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. ADIM: BARDAK & ÖĞÜTÜCÜ AYARI
                        Row(
                          children: [
                            const Text(
                              '1. BARDAK:',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            const Spacer(),
                            // Öğütücü Boyutu
                            PopupMenuButton<GrindSize>(
                              tooltip: 'Öğütücü Ayarı',
                              color: NoirTheme.surfaceLight,
                              initialValue: drink.grindSize,
                              onSelected: controller.selectGrindSize,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.tune, size: 12, color: NoirTheme.amberWarm),
                                    const SizedBox(width: 4),
                                    Text(
                                      drink.grindSize.label.split(' ')[0],
                                      style: const TextStyle(fontFamily: 'Courier', fontSize: 10, color: NoirTheme.amberWarm),
                                    ),
                                  ],
                                ),
                              ),
                              itemBuilder: (context) => GrindSize.values.map((g) => PopupMenuItem(
                                value: g,
                                child: Text(g.label, style: const TextStyle(fontFamily: 'Courier', fontSize: 12)),
                              )).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: CupSize.values.map((size) {
                            bool isSelected = drink.cupSize == size;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? NoirTheme.amberWarm.withValues(alpha: 0.2)
                                        : Colors.transparent,
                                    side: BorderSide(
                                      color: isSelected ? NoirTheme.amberWarm : Colors.white24,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () => controller.selectCup(size),
                                  child: Text(
                                    size.label,
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 10,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? NoirTheme.amberWarm : Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),

                        // 2. ADIM: ESPRESSO ÇEKİMİ
                        const Text(
                          '2. ESPRESSO ÇEKİMİ:',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: NoirTheme.coffeeDark,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: const BorderSide(color: NoirTheme.amberWarm),
                                  ),
                                ),
                                onPressed: () => controller.grindAndExtractEspresso(isDouble: false),
                                icon: const Icon(Icons.coffee, size: 14, color: NoirTheme.amberWarm),
                                label: const Text(
                                  'TEK SHOT (30ml)',
                                  style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2C1609),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: const BorderSide(color: NoirTheme.amberWarm),
                                  ),
                                ),
                                onPressed: () => controller.grindAndExtractEspresso(isDouble: true),
                                icon: const Icon(Icons.flash_on, size: 14, color: Colors.amber),
                                label: const Text(
                                  'DUBLE SHOT (60ml)',
                                  style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 3. ADIM: SU & SÜT KÖPÜRTME
                        const Text(
                          '3. SU / SÜT / KÖPÜK:',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: drink.hasHotWater
                                      ? Colors.blue.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  side: BorderSide(
                                    color: drink.hasHotWater ? Colors.lightBlueAccent : Colors.white24,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: controller.addHotWater,
                                icon: const Icon(Icons.water_drop, size: 14, color: Colors.lightBlueAccent),
                                label: const Text(
                                  '+ SICAK SU',
                                  style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: drink.foamLevel == FoamLevel.low
                                      ? Colors.amber.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  side: BorderSide(
                                    color: drink.foamLevel == FoamLevel.low ? Colors.amberAccent : Colors.white24,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: () => controller.steamAndAddMilk(foam: FoamLevel.low, quality: MilkQuality.perfect),
                                icon: const Icon(Icons.waves, size: 14, color: Colors.amberAccent),
                                label: const Text(
                                  'LATTE SÜTÜ',
                                  style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.amberAccent, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: drink.foamLevel == FoamLevel.high
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  side: BorderSide(
                                    color: drink.foamLevel == FoamLevel.high ? Colors.white : Colors.white24,
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: () => controller.steamAndAddMilk(foam: FoamLevel.high, quality: MilkQuality.perfect),
                                icon: const Icon(Icons.cloud, size: 14, color: Colors.white),
                                label: const Text(
                                  'CAPPUCCINO',
                                  style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 4. ADIM: ÖZEL EKLEMELER (AFFOGATO, İRLANDA KAHVESİ, MOCHA)
                        const Text(
                          '4. ÖZEL MENÜ & ŞURUPLAR:',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            // DONDURMA (Affogato)
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: drink.hasIceCream ? Colors.amber.shade100 : Colors.transparent,
                                  foregroundColor: drink.hasIceCream ? Colors.black : Colors.amber.shade200,
                                  side: BorderSide(color: Colors.amber.shade300),
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: controller.addIceCreamScoop,
                                icon: const Icon(Icons.icecream, size: 14),
                                label: const Text('DONDURMA', style: TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // ÇİKOLATA ŞURUBU (Mocha)
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: drink.hasChocolate ? Colors.brown.shade800 : Colors.transparent,
                                  foregroundColor: Colors.white,
                                  side: BorderSide(color: Colors.brown.shade400),
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                onPressed: controller.addChocolateSyrup,
                                icon: const Icon(Icons.cake, size: 14),
                                label: const Text('ÇİKOLATA', style: TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // KAÇAK İRLANDA VİSKİSİ
                            if (controller.unlockedWhiskey) ...[
                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: drink.hasWhiskey ? Colors.amber.shade700 : Colors.deepOrange.shade900,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  ),
                                  onPressed: controller.addContrabandWhiskey,
                                  icon: const Icon(Icons.local_bar, size: 14),
                                  label: const Text('VİSKİ', style: TextStyle(fontFamily: 'Courier', fontSize: 9, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ],
                        ),

                        // GİZLİ ZEHİR DAMLASI
                        if (controller.stash.any((i) => i.id == 'item_poison_01')) ...[
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: drink.hasPoisonDrop ? Colors.red.shade900 : Colors.purple.shade900,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: controller.addPoisonDrop,
                              icon: const Icon(Icons.science, size: 14, color: Colors.purpleAccent),
                              label: Text(
                                drink.hasPoisonDrop ? 'ZEHİR DAMLATILDI! (ÖLÜMCÜL)' : 'KAHVEYE ZEHİR DAMLAT...',
                                style: const TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // SAĞ: GÖRSEL BARDAK VE İÇERİK DURUMU
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF14161C),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'FİNCAN İÇERİĞİ',
                          style: TextStyle(fontFamily: 'Courier', fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white60),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Center(child: _buildCupVisual(drink)),
                        ),
                        const SizedBox(height: 4),
                        _buildIngredientsBadges(drink),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCupVisual(PreparedDrink drink) {
    if (drink.cupSize == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.coffee_outlined, size: 40, color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 4),
          const Text('Bardak Boş', style: TextStyle(fontFamily: 'Courier', fontSize: 10, color: Colors.white38)),
        ],
      );
    }

    double cupHeight = drink.cupSize == CupSize.small ? 60 : (drink.cupSize == CupSize.medium ? 80 : 100);
    double cupWidth = 70;

    return Container(
      width: cupWidth,
      height: cupHeight,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        border: Border.all(color: Colors.white38, width: 2),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
        child: Stack(
          children: [
            Column(
              verticalDirection: VerticalDirection.up,
              children: [
                if (drink.espressoShots > 0)
                  Container(
                    height: (drink.espressoShots * 16.0).clamp(0, cupHeight * 0.45),
                    color: NoirTheme.coffeeDark,
                  ),
                if (drink.hasHotWater)
                  Container(height: 14, color: Colors.blue.withValues(alpha: 0.35)),
                if (drink.hasChocolate)
                  Container(height: 12, color: Colors.brown.shade900),
                if (drink.hasWhiskey)
                  Container(height: 14, color: Colors.amber.shade800.withValues(alpha: 0.6)),
                if (drink.milkQuality != MilkQuality.none)
                  Container(height: 20, color: NoirTheme.milkCream.withValues(alpha: 0.75)),
                if (drink.foamLevel != FoamLevel.none)
                  Container(
                    height: drink.foamLevel == FoamLevel.high ? 18 : 10,
                    color: Colors.white,
                  ),
              ],
            ),
            // Affogato Dondurma Topu
            if (drink.hasIceCream)
              Positioned(
                top: 8,
                left: 18,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFFDD0),
                    border: Border.all(color: Colors.amber.shade200, width: 1.5),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsBadges(PreparedDrink drink) {
    if (drink.isEmpty) {
      return const Text('Malzeme eklenmedi', style: TextStyle(fontFamily: 'Courier', fontSize: 9, color: Colors.white30));
    }

    List<String> items = [];
    if (drink.cupSize != null) items.add(drink.cupSize!.label.split(' ')[0]);
    if (drink.espressoShots > 0) items.add('${drink.espressoShots}xEsp');
    if (drink.hasHotWater) items.add('Su');
    if (drink.milkQuality != MilkQuality.none) items.add('Süt');
    if (drink.foamLevel != FoamLevel.none) items.add(drink.foamLevel.label.split(' ')[0]);
    if (drink.hasIceCream) items.add('🍨Dondurma');
    if (drink.hasWhiskey) items.add('🥃Viski');
    if (drink.hasChocolate) items.add('🍫Mocha');
    if (drink.hasPoisonDrop) items.add('☠️Zehir');

    return Wrap(
      spacing: 3,
      runSpacing: 3,
      children: items.map((tag) {
        bool isPoison = tag.contains('Zehir');
        bool isWhiskey = tag.contains('Viski');
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: isPoison ? Colors.red.shade900 : (isWhiskey ? Colors.amber.shade900 : Colors.white12),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            tag,
            style: const TextStyle(fontFamily: 'Courier', fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}

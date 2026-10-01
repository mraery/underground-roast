enum CupSize {
  small('Küçük Fincan'),
  medium('Standart Kupa'),
  large('Büyük Bardak');

  final String label;
  const CupSize(this.label);
}

enum GrindSize {
  fine('İnce Öğütüm (Espresso)'),
  medium('Orta Öğütüm (Filtre/Americano)'),
  coarse('Kalın Öğütüm (Soğuk/Fransız)');

  final String label;
  const GrindSize(this.label);
}

enum DrinkType {
  espresso('Espresso', 'Yoğun, kremalı saf kahve özü'),
  doubleEspresso('Duble Espresso', 'İki kat yoğunlukta sert kahve'),
  americano('Americano', 'Espresso üzerine sıcak su eklenmiş berrak kahve'),
  cappuccino('Cappuccino', 'Espresso, sıcak süt ve bol yoğun kadife köpük'),
  latte('Latte', 'Espresso üzerine bol sıcak süt ve hafif mikro köpük'),
  flatWhite('Flat White', 'Çift shot espresso ve pürüzsüz ince süt köpüğü'),
  affogato('Affogato', 'Duble espresso içine bir top vanilyalı dondurma'),
  irishCoffee('İrlanda Kahvesi', 'Espresso, sıcak su ve kaçak İrlanda viskisi'),
  mocha('Mocha', 'Espresso, çikolata şurubu, sıcak süt ve krema');

  final String name;
  final String description;
  const DrinkType(this.name, this.description);
}

enum ExtractionQuality {
  none('Çekilmedi'),
  underExtracted('Yetersiz (Ekşi & Sulu)'),
  perfect('Kusursuz (Kremalı & Yoğun)'),
  overExtracted('Yanmış (Acı & Fazla)');

  final String label;
  const ExtractionQuality(this.label);
}

enum MilkQuality {
  none('Sütsüz'),
  cold('Soğuk Süt'),
  warm('Ilık Süt'),
  perfect('İdeal Sıcaklıkta & Kadife'),
  burnt('Kaynamış & Yanık');

  final String label;
  const MilkQuality(this.label);
}

enum FoamLevel {
  none('Köpüksüz'),
  low('Hafif Mikro Köpük'),
  medium('Orta Köpük'),
  high('Yoğun Bol Köpük');

  final String label;
  const FoamLevel(this.label);
}

class PreparedDrink {
  CupSize? cupSize;
  GrindSize grindSize;
  int espressoShots;
  ExtractionQuality extractionQuality;
  bool hasHotWater;
  MilkQuality milkQuality;
  FoamLevel foamLevel;
  bool hasIceCream;    // Affogato için
  bool hasWhiskey;     // İrlanda Kahvesi (Kaçak Menü) için
  bool hasChocolate;   // Mocha için
  bool hasCinnamon;    // Tarçın
  bool hasPoisonDrop;  // Suçlu/kiralık katil hikaye dallanmaları için

  PreparedDrink({
    this.cupSize,
    this.grindSize = GrindSize.fine,
    this.espressoShots = 0,
    this.extractionQuality = ExtractionQuality.none,
    this.hasHotWater = false,
    this.milkQuality = MilkQuality.none,
    this.foamLevel = FoamLevel.none,
    this.hasIceCream = false,
    this.hasWhiskey = false,
    this.hasChocolate = false,
    this.hasCinnamon = false,
    this.hasPoisonDrop = false,
  });

  bool get isEmpty =>
      cupSize == null &&
      espressoShots == 0 &&
      !hasHotWater &&
      milkQuality == MilkQuality.none &&
      !hasIceCream &&
      !hasWhiskey &&
      !hasChocolate;

  void reset() {
    cupSize = null;
    grindSize = GrindSize.fine;
    espressoShots = 0;
    extractionQuality = ExtractionQuality.none;
    hasHotWater = false;
    milkQuality = MilkQuality.none;
    foamLevel = FoamLevel.none;
    hasIceCream = false;
    hasWhiskey = false;
    hasChocolate = false;
    hasCinnamon = false;
    hasPoisonDrop = false;
  }

  // İstenen içeceğe göre yapılan kahvenin doğruluğunu ve puanını hesaplar
  DrinkEvaluation evaluateAgainst(DrinkType expected) {
    if (cupSize == null) {
      return DrinkEvaluation(
        isCorrect: false,
        score: 0,
        feedback: 'Kahveyi bardaksız havaya mı yaptın barista?!',
      );
    }

    if (espressoShots == 0) {
      return DrinkEvaluation(
        isCorrect: false,
        score: 0,
        feedback: 'Bunun içinde kahve namına hiçbir şey yok!',
      );
    }

    int score = 100;
    List<String> notes = [];

    // Öğütüm boyutu kontrolü
    if (expected == DrinkType.espresso || expected == DrinkType.doubleEspresso || expected == DrinkType.affogato) {
      if (grindSize != GrindSize.fine) {
        score -= 20;
        notes.add('Öğütüm çok kalın kalmış, krema zayıf');
      }
    }

    // Çekim kalitesi kontrolü
    if (extractionQuality == ExtractionQuality.underExtracted) {
      score -= 25;
      notes.add('Kahve sulu ve ekşi olmuş');
    } else if (extractionQuality == ExtractionQuality.overExtracted) {
      score -= 25;
      notes.add('Kahve yanmış, boğazımı yaktı');
    }

    switch (expected) {
      case DrinkType.espresso:
        if (espressoShots != 1) { score -= 30; notes.add('Tek shot istedim'); }
        if (hasHotWater) { score -= 40; notes.add('Su katılmış, Americano gibi olmuş'); }
        if (milkQuality != MilkQuality.none) { score -= 50; notes.add('Sade istedim, süt nereden çıktı?'); }
        if (hasWhiskey || hasIceCream || hasChocolate) { score -= 50; notes.add('Sade saf espresso istedim'); }
        break;

      case DrinkType.doubleEspresso:
        if (espressoShots < 2) { score -= 40; notes.add('Duble demiştim, bu tek shot!'); }
        if (hasHotWater || milkQuality != MilkQuality.none) { score -= 40; notes.add('Saf ve sert duble espresso istedim'); }
        break;

      case DrinkType.americano:
        if (!hasHotWater) { score -= 40; notes.add('Americano sıcak suyla seyreltilir, su koymamışsın!'); }
        if (milkQuality != MilkQuality.none) { score -= 40; notes.add('Americano sütsüz olur'); }
        break;

      case DrinkType.cappuccino:
        if (milkQuality == MilkQuality.none) {
          score -= 50; notes.add('Cappuccino sütsüz olur mu hiç?');
        } else {
          if (foamLevel != FoamLevel.high && foamLevel != FoamLevel.medium) {
            score -= 25; notes.add('Cappuccino bol köpüklü olmalı');
          }
          if (milkQuality == MilkQuality.burnt) { score -= 20; notes.add('Sütü kaynatıp yakmışsın'); }
        }
        if (hasHotWater) { score -= 30; notes.add('Cappuccino içine fazladan su katılmaz'); }
        break;

      case DrinkType.latte:
        if (milkQuality == MilkQuality.none) {
          score -= 50; notes.add('Latte istedim, sütü nerede?');
        } else {
          if (foamLevel == FoamLevel.high) { score -= 15; notes.add('Latte köpüğü ince olmalı'); }
          if (milkQuality == MilkQuality.burnt) { score -= 20; notes.add('Süt yanık kokuyor'); }
        }
        if (hasHotWater) { score -= 30; notes.add('Su katılmış, tadı kaçmış'); }
        break;

      case DrinkType.flatWhite:
        if (espressoShots < 2) { score -= 30; notes.add('Flat White duble shot gerektirir'); }
        if (milkQuality == MilkQuality.none) { score -= 40; notes.add('Süt eklenmemiş'); }
        break;

      case DrinkType.affogato:
        if (!hasIceCream) { score -= 60; notes.add('Affogato dondurmasız olmaz!'); }
        if (espressoShots < 2) { score -= 20; notes.add('Duble espressoyla daha iyi olurdu'); }
        if (hasHotWater || milkQuality != MilkQuality.none) { score -= 30; notes.add('Fazladan su veya süt konulmamalı'); }
        break;

      case DrinkType.irishCoffee:
        if (!hasWhiskey) { score -= 60; notes.add('İrlanda Kahvesi dedik, içinde kaçak viski yok!'); }
        if (!hasHotWater) { score -= 20; notes.add('Biraz sıcak suyla yumuşatılmalıydı'); }
        break;

      case DrinkType.mocha:
        if (!hasChocolate) { score -= 50; notes.add('Mochada çikolata şurubu olmalı!'); }
        if (milkQuality == MilkQuality.none) { score -= 40; notes.add('Süt eklenmemiş'); }
        break;
    }

    bool isCorrect = score >= 50;
    String feedback = isCorrect
        ? (score >= 90
            ? 'Muazzam bir kahve... Bu tekinsiz şehirde içtiğim en iyi şey!'
            : 'Fena değil... Ama daha iyisini yapabilirdin (${notes.join(', ')}).')
        : 'Rezalet bir şey bu! (${notes.join(', ')})';

    return DrinkEvaluation(
      isCorrect: isCorrect,
      score: score.clamp(0, 100),
      feedback: feedback,
    );
  }
}

class DrinkEvaluation {
  final bool isCorrect;
  final int score;
  final String feedback;

  DrinkEvaluation({
    required this.isCorrect,
    required this.score,
    required this.feedback,
  });
}

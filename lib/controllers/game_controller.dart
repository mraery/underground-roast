import 'package:flutter/foundation.dart';
import '../data/story_data.dart';
import '../models/customer.dart';
import '../models/drink.dart';
import '../models/game_state.dart';
import '../models/item.dart';

enum CustomerInteractionState {
  ordering,
  served,
  rejected,
  reported,
  contrabandGiven,
}

class GameController extends ChangeNotifier {
  int currentDay = 1;
  int cash = 150;
  int penaltiesCount = 0;
  int dailyEarnings = 0;
  int dailyTips = 0;
  int dailyPenalties = 0;

  int currentCustomerIndex = 0;
  List<Customer> currentCustomers = [];
  CustomerInteractionState interactionState = CustomerInteractionState.ordering;

  // Barista İstasyonu
  PreparedDrink currentDrink = PreparedDrink();
  bool isGrinding = false;
  bool isExtracting = false;
  bool isSteaming = false;
  bool unlockedWhiskey = false; // Kaçak İrlanda Viskisi açık mı?

  // Zula (Gizli Çekmece)
  List<ContrabandItem> stash = [];

  // Dükkân Geliştirmeleri (Shop Upgrades)
  List<ShopUpgrade> shopUpgrades = [];

  // Pencereler / Modallar
  bool isInspectingMoney = false;
  bool isBulletinOpen = false;
  bool isStashOpen = false;
  bool isRadioScannerOpen = false;
  bool isShopOpen = false;
  bool isUvLightActive = false;
  bool isRulerActive = false; // Para ölçüm cetveli

  // Telsiz Yayınları
  List<RadioBroadcast> radioBroadcasts = [];

  // Gün Sonu ve Oyun Sonu
  bool isDayEnd = false;
  DaySummary? currentDaySummary;
  bool isGameOver = false;
  String gameOverReason = '';
  EndingType? achievedEnding;

  // Hikaye Dallanma Bayrakları
  bool hasCard = false;
  bool hasGun = false;
  bool gaveGunToBuyer = false;
  bool reportedGunToPolice = false;
  bool poisonedDetective = false;
  bool savedDetective = false;
  bool helpedReporter = false;
  bool alliedWithMob = false;

  String? bannerFeedback;

  GameController() {
    shopUpgrades = StoryData.getInitialShopUpgrades();
    _loadDay(1);
  }

  DailyBulletin get currentBulletin => StoryData.getBulletinForDay(currentDay);

  Customer? get currentCustomer {
    if (currentCustomerIndex < currentCustomers.length) {
      return currentCustomers[currentCustomerIndex];
    }
    return null;
  }

  bool get hasAutoFakeDetector => shopUpgrades.any((u) => u.id == 'upgrade_counter' && u.isPurchased);
  bool get hasItalianMachine => shopUpgrades.any((u) => u.id == 'upgrade_machine' && u.isPurchased);
  bool get hasSecretSafe => shopUpgrades.any((u) => u.id == 'upgrade_safe' && u.isPurchased);
  bool get hasSteelArmor => shopUpgrades.any((u) => u.id == 'upgrade_armor' && u.isPurchased);

  void _loadDay(int day) {
    currentDay = day;
    currentCustomerIndex = 0;
    currentCustomers = StoryData.getCustomersForDay(day);
    radioBroadcasts = StoryData.getRadioBroadcasts(day);
    interactionState = CustomerInteractionState.ordering;
    dailyEarnings = 0;
    dailyTips = 0;
    dailyPenalties = 0;
    currentDrink.reset();
    isDayEnd = false;
    isShopOpen = false;
    achievedEnding = null;

    // Eğer zulamızda veya dükkânda viski varsa kaçak viski butonu açılır
    if (stash.any((item) => item.id == 'item_whiskey_01') || currentDay >= 3) {
      unlockedWhiskey = true;
    }

    bannerFeedback = 'Gün $day / 7 başladı. Masadaki asayiş bültenini ve telsizi kontrol edin!';
    notifyListeners();
  }

  // --- BARİSTA İSTASYONU EYLEMLERİ ---

  void selectCup(CupSize size) {
    currentDrink.cupSize = size;
    bannerFeedback = '${size.label} tezgâha koyuldu.';
    notifyListeners();
  }

  void selectGrindSize(GrindSize grind) {
    currentDrink.grindSize = grind;
    bannerFeedback = 'Öğütücü ayarlandı: ${grind.label}';
    notifyListeners();
  }

  void grindAndExtractEspresso({bool isDouble = false}) {
    if (currentDrink.cupSize == null) {
      bannerFeedback = 'Önce bir bardak seçmelisin!';
      notifyListeners();
      return;
    }

    currentDrink.espressoShots += (isDouble ? 2 : 1);
    currentDrink.extractionQuality = ExtractionQuality.perfect;
    bannerFeedback = isDouble ? 'Duble Espresso çekildi (Yoğun Krema).' : 'Tek Shot Espresso çekildi.';
    notifyListeners();
  }

  void addHotWater() {
    if (currentDrink.cupSize == null) {
      bannerFeedback = 'Önce bir bardak seçmelisin!';
      notifyListeners();
      return;
    }
    currentDrink.hasHotWater = true;
    bannerFeedback = 'Kaynar su eklendi (Americano bazlı).';
    notifyListeners();
  }

  void steamAndAddMilk({required FoamLevel foam, required MilkQuality quality}) {
    if (currentDrink.cupSize == null) {
      bannerFeedback = 'Önce bir bardak seçmelisin!';
      notifyListeners();
      return;
    }
    currentDrink.milkQuality = quality;
    currentDrink.foamLevel = foam;
    bannerFeedback = 'Buharlanmış süt eklendi (${foam.label}).';
    notifyListeners();
  }

  void addIceCreamScoop() {
    if (currentDrink.cupSize == null) return;
    currentDrink.hasIceCream = true;
    bannerFeedback = 'Vanilyalı dondurma topu eklendi (Affogato hazırlığı).';
    notifyListeners();
  }

  void addContrabandWhiskey() {
    if (currentDrink.cupSize == null) return;
    currentDrink.hasWhiskey = true;
    bannerFeedback = 'Tezgah altından kaçak İrlanda Viskisi damlatıldı!';
    notifyListeners();
  }

  void addChocolateSyrup() {
    if (currentDrink.cupSize == null) return;
    currentDrink.hasChocolate = true;
    bannerFeedback = 'Koyu çikolata şurubu eklendi (Mocha).';
    notifyListeners();
  }

  void addPoisonDrop() {
    if (currentDrink.cupSize == null) return;
    currentDrink.hasPoisonDrop = true;
    bannerFeedback = 'Ölümcül zehir bardağa damlatıldı...';
    notifyListeners();
  }

  void clearDrink() {
    currentDrink.reset();
    bannerFeedback = 'Tezgâh ve bardak temizlendi.';
    notifyListeners();
  }

  // --- TEFTİŞ & İNCELEME EYLEMLERİ ---

  void toggleMoneyInspection() {
    isInspectingMoney = !isInspectingMoney;
    isUvLightActive = false;
    isRulerActive = false;
    notifyListeners();
  }

  void toggleUvLight() {
    isUvLightActive = !isUvLightActive;
    notifyListeners();
  }

  void toggleRuler() {
    isRulerActive = !isRulerActive;
    notifyListeners();
  }

  void toggleBulletin() {
    isBulletinOpen = !isBulletinOpen;
    notifyListeners();
  }

  void toggleStash() {
    isStashOpen = !isStashOpen;
    notifyListeners();
  }

  void toggleRadioScanner() {
    isRadioScannerOpen = !isRadioScannerOpen;
    notifyListeners();
  }

  void toggleShop() {
    isShopOpen = !isShopOpen;
    notifyListeners();
  }

  void purchaseUpgrade(ShopUpgrade upgrade) {
    if (cash >= upgrade.cost && !upgrade.isPurchased) {
      cash -= upgrade.cost;
      upgrade.isPurchased = true;
      bannerFeedback = 'Satın alındı: ${upgrade.name}!';
      notifyListeners();
    } else {
      bannerFeedback = 'Yetersiz bakiye!';
      notifyListeners();
    }
  }

  // --- KARAR VE EYLEM DÜĞMELERİ (PAPERS, PLEASE MANTIĞI) ---

  void servePreparedDrink(PreparedDrink drink) {
    currentDrink = drink;
    serveDrinkAndAcceptPayment();
  }

  void serveDrinkAndAcceptPayment() {
    final customer = currentCustomer;
    if (customer == null || interactionState != CustomerInteractionState.ordering) return;

    if (currentDrink.isEmpty) {
      bannerFeedback = 'Müşteriye boş fincan veremezsin!';
      notifyListeners();
      return;
    }

    final evaluation = currentDrink.evaluateAgainst(customer.requestedDrink);

    // Zehir kontrolü (Dedektif zehirlendi mi?)
    if ((customer.id.contains('Orhan') || customer.name.contains('Orhan')) && currentDrink.hasPoisonDrop) {
      poisonedDetective = true;
      bannerFeedback = 'Dedektif kahveyi içti ve yere yığıldı... Şehri mafyaya teslim ettin!';
      interactionState = CustomerInteractionState.served;
      cash += 500;
      dailyEarnings += 500;
      notifyListeners();
      return;
    }

    // Sahte para kontrolü
    final payment = customer.payment;
    bool acceptedFake = payment.isCounterfeit;

    if (acceptedFake) {
      penaltiesCount++;
      dailyPenalties += 60;
      cash -= 60;
      bannerFeedback = 'DİKKAT: Sahte parayı kabul ettiniz! Emniyet 60₺ ceza kesti!';
    } else {
      int earned = payment.denomination;
      int tip = evaluation.isCorrect ? customer.tipAmount : 0;
      if (hasItalianMachine) tip = (tip * 1.3).round(); // Dükkân geliştirmesi bonusu!

      dailyEarnings += earned;
      dailyTips += tip;
      cash += (earned + tip);
      bannerFeedback = 'Kahve servis edildi. +${earned + tip}₺ kasaya girdi.';
    }

    // Müşterinin bıraktığı emanet varsa zulanıza eklenir!
    if (customer.contrabandToLeave != null) {
      stash.add(customer.contrabandToLeave!);
      if (customer.contrabandToLeave!.id == 'item_card_01') hasCard = true;
      if (customer.contrabandToLeave!.id == 'item_gun_01') hasGun = true;
      if (customer.contrabandToLeave!.id == 'item_whiskey_01') unlockedWhiskey = true;
      bannerFeedback = '${bannerFeedback!} (Müşteri tezgâha [${customer.contrabandToLeave!.title}] bıraktı!)';
    }

    interactionState = CustomerInteractionState.served;
    notifyListeners();
  }

  void rejectCustomer() {
    final customer = currentCustomer;
    if (customer == null || interactionState != CustomerInteractionState.ordering) return;

    if (customer.payment.isCounterfeit) {
      bannerFeedback = 'KUSURSUZ REFLEKS: Sahte parayı yakalayıp sahtekarı kovdunuz!';
    } else {
      bannerFeedback = 'Müşteriyi sebepsiz yere kovdunuz. Şöhretiniz sarsıldı.';
    }

    interactionState = CustomerInteractionState.rejected;
    notifyListeners();
  }

  void triggerPoliceAlarm() {
    final customer = currentCustomer;
    if (customer == null || interactionState != CustomerInteractionState.ordering) return;

    if (customer.payment.isCounterfeit || customer.isWanted || customer.contrabandToLeave?.isDangerous == true) {
      cash += 100;
      dailyEarnings += 100;
      bannerFeedback = 'BAŞARILI İHBAR: Polis suçluyu yakaladı! 100₺ ödül verildi!';
    } else {
      penaltiesCount++;
      dailyPenalties += 50;
      cash -= 50;
      bannerFeedback = 'YANLIŞ ALARM: Masum vatandaşı ihbar ettiniz. Polis 50₺ ceza kesti!';
    }

    interactionState = CustomerInteractionState.reported;
    notifyListeners();
  }

  void deliverContraband(ContrabandItem item) {
    final customer = currentCustomer;
    if (customer == null) return;

    if (customer.expectedContrabandId == item.id) {
      stash.removeWhere((i) => i.id == item.id);
      if (item.id == 'item_gun_01') gaveGunToBuyer = true;
      if (item.id == 'item_cassette_01') helpedReporter = true;

      int reward = item.blackMarketValue;
      cash += reward;
      dailyTips += reward;
      bannerFeedback = 'Emanet teslim edildi. +$reward₺ sus payı aldınız!';
      interactionState = CustomerInteractionState.contrabandGiven;
      isStashOpen = false;
      notifyListeners();
    } else {
      bannerFeedback = 'Bu müşteri bu eşyayı beklemiyor!';
      notifyListeners();
    }
  }

  void nextCustomer() {
    currentDrink.reset();
    isInspectingMoney = false;
    currentCustomerIndex++;

    if (currentCustomerIndex >= currentCustomers.length) {
      _endDay();
    } else {
      interactionState = CustomerInteractionState.ordering;
      bannerFeedback = 'Yeni müşteri tezgâha yanaştı.';
    }
    notifyListeners();
  }

  void _endDay() {
    isDayEnd = true;
    int rent = 80 + (currentDay * 15);
    int supplies = 30 + (currentDay * 8);

    cash -= (rent + supplies);
    bool survived = cash >= 0 && penaltiesCount < 3;

    String headline = '';
    String body = '';

    if (currentDay == 1) {
      headline = 'LİMANDA SAHTE PARA PANİĞİ';
      body = 'Dün gece polis, amatör sahte paralarla piyasayı dolandırmaya çalışan çeteyi takibe aldı.';
    } else if (currentDay == 2) {
      headline = gaveGunToBuyer ? 'LİMAN MAHALLESİNDE ÇATIŞMA' : 'SİLAH SEVKİYATINA DARBE';
      body = gaveGunToBuyer
          ? 'Gece saatlerinde 9mm susturuculu tabancayla pusu kuruldu.'
          : 'Polis limana giren kaçak silahları ele geçirdi.';
    } else if (currentDay == 3) {
      headline = 'GÜMRÜKTE KAÇAK VİSKİ BASKINI';
      body = 'Liman depolarında kaçak İrlanda viskisi operasyonu yapıldı.';
    } else if (currentDay == 4) {
      headline = helpedReporter ? 'EMNİYETTE DEPREM: KASET SIZDIRILDI' : 'GAZETECİ CAN SIRRA KADEM BASTI';
      body = helpedReporter
          ? 'Rüşvet kasetleri emniyet içindeki köstebekleri deşifre etti.'
          : 'Şüpheli ses kasetinin kaybolduğu bildirildi.';
    } else if (currentDay == 5) {
      headline = 'DON SELİM LİMANDA GÖRÜLDÜ';
      body = 'Yeraltı dünyasının lideri Don Selim şehirde güç gösterisi yaptı.';
    } else if (currentDay == 6) {
      headline = poisonedDetective ? 'KOMİSER ORHAN ŞÜPHELİ ŞEKİLDE ÖLDÜ' : 'DEDEKTİF ORHAN SUİKASTTEN KURTULDU';
      body = poisonedDetective
          ? 'Cinayet masası şefi fenalaşarak hayatını kaybetti. Şehirde kaos hakim.'
          : 'Emniyet şefi hayatını kurtaran baristayı takdir etti.';
    } else {
      // 7. GÜN: FİNAL DEĞERLENDİRMESİ
      if (poisonedDetective && gaveGunToBuyer) {
        achievedEnding = EndingType.underworldBaron;
        headline = 'YERALTI DÜNYASININ YENİ GÖLGE BARONU';
        body = achievedEnding!.story;
      } else if (!poisonedDetective && cash >= 400 && helpedReporter) {
        achievedEnding = EndingType.nightEscape;
        headline = 'LİMANDAN GECE GEMİSİYLE KAÇIŞ';
        body = achievedEnding!.story;
      } else if (!poisonedDetective && penaltiesCount == 0) {
        achievedEnding = EndingType.policeHero;
        headline = 'ŞEHRİ KURTARAN KAHRAMAN BARİSTA';
        body = achievedEnding!.story;
      } else if (penaltiesCount >= 3) {
        achievedEnding = EndingType.imprisoned;
        headline = 'BARİSTAYA MÜEBBET HAPİS';
        body = achievedEnding!.story;
      } else {
        achievedEnding = cash >= 0 ? EndingType.policeHero : EndingType.bankrupt;
        headline = achievedEnding!.title;
        body = achievedEnding!.story;
      }
    }

    currentDaySummary = DaySummary(
      day: currentDay,
      startingCash: cash + rent + supplies - dailyEarnings - dailyTips + dailyPenalties,
      earnings: dailyEarnings,
      tips: dailyTips,
      rent: rent,
      supplyCost: supplies,
      penaltiesAmount: dailyPenalties,
      endingCash: cash,
      newspaperHeadline: headline,
      newspaperBody: body,
      survived: survived,
    );

    if (!survived) {
      isGameOver = true;
      gameOverReason = cash < 0
          ? 'İflas ettin! Dükkan kirasını ve masrafları ödeyemedin.'
          : 'Çok fazla ceza aldın! Polis dükkanını mühürledi ve seni tutukladı.';
    } else if (currentDay >= 7) {
      isGameOver = true;
      gameOverReason = achievedEnding != null ? achievedEnding!.title : 'KAMPANYA TAMAMLANDI!';
    }

    notifyListeners();
  }

  void proceedToNextDay() {
    if (currentDay < 7) {
      _loadDay(currentDay + 1);
    }
  }

  void restartGame() {
    currentDay = 1;
    cash = 150;
    penaltiesCount = 0;
    stash.clear();
    for (var u in shopUpgrades) {
      u.isPurchased = false;
    }
    hasCard = false;
    hasGun = false;
    gaveGunToBuyer = false;
    reportedGunToPolice = false;
    poisonedDetective = false;
    savedDetective = false;
    helpedReporter = false;
    isGameOver = false;
    gameOverReason = '';
    achievedEnding = null;
    _loadDay(1);
  }
}

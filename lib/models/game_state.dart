class DailyBulletin {
  final int day;
  final String dateString;
  final String title;
  final List<String> rules;
  final List<String> blacklistedSerialNumbers;
  final String wantedDescription;
  final String flavorNews;

  const DailyBulletin({
    required this.day,
    required this.dateString,
    required this.title,
    required this.rules,
    required this.blacklistedSerialNumbers,
    required this.wantedDescription,
    required this.flavorNews,
  });
}

class ShopUpgrade {
  final String id;
  final String name;
  final String description;
  final int cost;
  final String icon;
  bool isPurchased;

  ShopUpgrade({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.icon,
    this.isPurchased = false,
  });
}

class RadioBroadcast {
  final double frequencyMhz;
  final String channelName;
  final String transmission;
  final int day;

  const RadioBroadcast({
    required this.frequencyMhz,
    required this.channelName,
    required this.transmission,
    required this.day,
  });
}

enum EndingType {
  underworldBaron('YERALTI BARONU', 'Suç örgütleriyle tam sadakat kurdun. Şehirdeki yeraltı kahve ve kaçakçılık imparatorluğunun gölge baronu oldun!'),
  policeHero('EMNİYET KAHRAMANI', 'Komiser Orhan ile omuz omuza verip tüm çeteyi parmaklıklar ardına gönderdin. Devlet üstün cesaret madalyası aldın!'),
  nightEscape('GECE GEMİSİYLE KAÇIŞ', 'Tüm çatışmaların ortasında yüklü bir servet biriktirip gece limandan kalkan bir yük gemisiyle Güney Amerika\'ya kaçtın. Orada sakin bir sahil kafesi açtın.'),
  imprisoned('MÜEBBET HAPİS', 'Polis baskınında tezgâhının altındaki silah ve zehirle yakalandın. Ömrünün geri kalanında koğuştakilere kahve yapacaksın.'),
  bankrupt('İFLAS & MÜHÜR', 'Kiranı ve masraflarını ödeyemedin. Şehrin en karanlık kahvehanesi kapısına mühür vurularak tarihe karıştı.');

  final String title;
  final String story;
  const EndingType(this.title, this.story);
}

class DaySummary {
  final int day;
  final int startingCash;
  final int earnings;
  final int tips;
  final int rent;
  final int supplyCost;
  final int penaltiesAmount;
  final int endingCash;
  final String newspaperHeadline;
  final String newspaperBody;
  final bool survived;

  const DaySummary({
    required this.day,
    required this.startingCash,
    required this.earnings,
    required this.tips,
    required this.rent,
    required this.supplyCost,
    required this.penaltiesAmount,
    required this.endingCash,
    required this.newspaperHeadline,
    required this.newspaperBody,
    required this.survived,
  });
}

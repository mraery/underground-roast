enum ItemType {
  money,
  businessCard,
  weapon,
  poisonVial,
  secretLetter,
  whiskeyBottle,
  blackmailTape,
  bloodDiamond,
}

class Banknote {
  final int denomination; // 50₺, 100₺, 200₺
  final String serialNumber;
  final bool isCounterfeit;
  final String? fakeClue; // Örn: 'Jordi Usulü Pastel Boya Çizim!', 'Filigran Yok', 'Seri No Sahte Listesinde'
  final bool uvReactive; // UV ışığında parlayan gizli damga var mı?
  final String? funnyNote; // "Valla gerçek para yeğenim"
  final double widthMm; // Standart: 148.0 mm
  final double heightMm; // Standart: 72.0 mm

  const Banknote({
    required this.denomination,
    required this.serialNumber,
    required this.isCounterfeit,
    this.fakeClue,
    required this.uvReactive,
    this.funnyNote,
    this.widthMm = 148.0,
    this.heightMm = 72.0,
  });

  bool get hasSizeDefect => (widthMm - 148.0).abs() > 3.0 || (heightMm - 72.0).abs() > 2.0;
}

class ContrabandItem {
  final String id;
  final String title;
  final String description;
  final ItemType type;
  final String icon; // emoji veya sembol
  final String ownerHint; // "Gri pardösülü bir adama verilecek"
  final bool isDangerous;
  final int blackMarketValue;

  const ContrabandItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
    this.ownerHint = '',
    this.isDangerous = false,
    this.blackMarketValue = 150,
  });
}

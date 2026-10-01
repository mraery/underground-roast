import '../models/customer.dart';
import '../models/drink.dart';
import '../models/game_state.dart';
import '../models/item.dart';

class StoryData {
  // GÜNLÜK BÜLTENLER (1 - 7)
  static const DailyBulletin day1Bulletin = DailyBulletin(
    day: 1,
    dateString: '14 EYLÜL 1988 - ÇARŞAMBA',
    title: 'GÜVENLİK BÜLTENİ & ASAYİŞ RAPORU',
    rules: [
      'Kural 1: Liman bölgesinde tükenmez ve pastel boyayla taklit edilen amatör sahte paralar dolaşmaktadır.',
      'Kural 2: Sahte banknot kabul eden işletmelerden 60₺ idari para cezası tahsil edilecektir.',
      'Kural 3: Şüpheli kişileri tezgahın altındaki [ALARM] butonu ile polise ihbar edebilirsiniz.',
    ],
    blacklistedSerialNumbers: ['TR-9901', 'TR-9902'],
    wantedDescription: 'Tornacı Şinasi (Jordi): El yapımı komik paralarla kahve almaya çalışan bir dolandırıcı.',
    flavorNews: 'Liman bölgesindeki grev devam ederken, gece sokaklarında tekinsiz hareketlilik sürüyor.',
  );

  static const DailyBulletin day2Bulletin = DailyBulletin(
    day: 2,
    dateString: '15 EYLÜL 1988 - PERŞEMBE',
    title: 'SIKIYÖNETİM & ASAYİŞ BÜLTENİ',
    rules: [
      'Kural 1: Suç örgütlerinin liman bölgesinde silah ve kaçak emanet transferi yaptığı tespit edilmiştir.',
      'Kural 2: Dükkânında kaçak emanet veya silah saklayan işletmeciler derhal tutuklanacaktır.',
      'Kural 3: Seri numarası "KZ-7744" olan banknotlar banka soygunundan çalınmıştır, geçersizdir!',
    ],
    blacklistedSerialNumbers: ['KZ-7744', 'KZ-7745'],
    wantedDescription: 'Gölge Tetikçi Cemil: Siyah kasketli, yaralı yüzlü, soğukkanlı bir çete elemanı.',
    flavorNews: 'Dün gece 3. bölgede patlayan bir araba mafya hesaplaşmasının fitilini ateşledi.',
  );

  static const DailyBulletin day3Bulletin = DailyBulletin(
    day: 3,
    dateString: '16 EYLÜL 1988 - CUMA',
    title: 'GÜMRÜK & KAÇAKÇILIK BÜLTENİ',
    rules: [
      'Kural 1: Limana yanaşan yabancı yük gemisinden kaçak İrlanda viskisi kolileri çalınmıştır.',
      'Kural 2: Masanızdaki TELSİZİ (104.2 MHz) dinleyerek emniyet devriyelerini takip edebilirsiniz.',
      'Kural 3: Seri no "SMUG-301" olan banknotlar kaçakçıların elindedir!',
    ],
    blacklistedSerialNumbers: ['SMUG-301', 'SMUG-302'],
    wantedDescription: 'Kaçakçı Kaptan Salih: Ağzında puro, deri kasketli yaşlı deniz kurdu.',
    flavorNews: 'Liman depolarında kaçak alkol baskını yapıldı, çok sayıda şüpheli aranıyor.',
  );

  static const DailyBulletin day4Bulletin = DailyBulletin(
    day: 4,
    dateString: '17 EYLÜL 1988 - CUMARTESİ',
    title: 'ŞANTAJ & İSTİHBARAT BÜLTENİ',
    rules: [
      'Kural 1: Şehirde üst düzey emniyet yetkililerini hedef alan şantaj kasetleri dolaşmaktadır.',
      'Kural 2: Şüpheli ses kaseti veya belge taşıyan kişileri derhal ihbar ediniz!',
      'Kural 3: Kara liste serisi: "TAPE-8800"',
    ],
    blacklistedSerialNumbers: ['TAPE-8800', 'TAPE-8801'],
    wantedDescription: 'Muhabir Can: Gözlüklü, sürekli etrafına bakınan nevrotik bir gazeteci.',
    flavorNews: 'Emniyet müdürlüğünde teftiş krizi: Bazı dosyaların sızdırıldığı iddia ediliyor.',
  );

  static const DailyBulletin day5Bulletin = DailyBulletin(
    day: 5,
    dateString: '18 EYLÜL 1988 - PAZAR',
    title: 'KIRMIZI ALARM & SIKIYÖNETİM',
    rules: [
      'Kural 1: Şehrin büyük mafya babası Don Selim\'in liman bölgesinde toplantı yaptığı bilinmektedir.',
      'Kural 2: Çatışma riski en üst seviyededir. Dükkân zırhınızı güçlendirmeniz önerilir!',
    ],
    blacklistedSerialNumbers: ['MOB-001', 'MOB-002'],
    wantedDescription: 'Yeraltı Mafya Fedaileri ve kiralık tetikçiler.',
    flavorNews: 'Şehir merkezinde lüks araç konvoyu görüldü. Sokaklar tekinsiz bir sessizliğe büründü.',
  );

  static const DailyBulletin day6Bulletin = DailyBulletin(
    day: 6,
    dateString: '19 EYLÜL 1988 - PAZARTESİ',
    title: 'ZEHİR & SUİKAST ALARMI',
    rules: [
      'Kural 1: Cinayet masası dedektiflerine yönelik suikast hazırlığı istihbaratı alınmıştır.',
      'Kural 2: Zehirli kimyasallar, siyanür tüpleri taşıyanlar derhal yakalanmalıdır!',
    ],
    blacklistedSerialNumbers: ['POIS-999'],
    wantedDescription: 'Zehirbaz Kerim: Yüzü cerrahi maskeli kiralık suikastçı.',
    flavorNews: 'Komiser Orhan emniyetteki köstebeği bulmak üzere olduğunu açıkladı.',
  );

  static const DailyBulletin day7Bulletin = DailyBulletin(
    day: 7,
    dateString: '20 EYLÜL 1988 - SALI',
    title: 'BÜYÜK HESAPLAŞMA GÜNÜ',
    rules: [
      'Kural 1: Son vardiya. Şehrin geleceği bugün belirlenecek.',
      'Kural 2: Kimin yanında saf tuttuğuna dikkat et: Kanun mu, yeraltı mı, yoksa kendi özgürlüğün mü?',
    ],
    blacklistedSerialNumbers: ['FINAL-777'],
    wantedDescription: 'Tüm aranan şahıslar ve son temaslar.',
    flavorNews: 'Şehir fırtınanın kopmasını bekliyor. Limandaki gece gemisi sabaha karşı kalkıyor.',
  );

  // TELSİZ ANONS VERİLERİ (POLİS FREKANSLARI)
  static List<RadioBroadcast> getRadioBroadcasts(int day) {
    return [
      RadioBroadcast(
        frequencyMhz: 98.4,
        channelName: 'Merkez Asayiş Telsizi',
        transmission: 'Merkezden 34-12 ekibine: Liman caddesinde tornacı Şinasi görüldü, sahte paralarla esnafı taciz ediyor, takibe alın.',
        day: 1,
      ),
      RadioBroadcast(
        frequencyMhz: 104.2,
        channelName: 'Narkotik & Kaçakçılık Kanalı',
        transmission: 'Tüm birimlere: Yük gemisinden çalınan kaçak İrlanda viskisi 2. bölgedeki kahvehanelere dağıtılıyor olabilir, dikkatli olun.',
        day: 3,
      ),
      RadioBroadcast(
        frequencyMhz: 108.0,
        channelName: 'Şifreli Emniyet Özel Hattı',
        transmission: 'Şef Orhan konuşuyor: Emniyet içindeki köstebeğe ait kaset gazeteci Candaymış. Gazeteciyi canlı ele geçirmemiz lazım!',
        day: 4,
      ),
      RadioBroadcast(
        frequencyMhz: 98.4,
        channelName: 'Merkez Asayiş Telsizi',
        transmission: 'KIRMIZI KOD: Don Selimin adamları limana indi! Çatışma bekleniyor, bölgeye zırhlı takviye sevk edin!',
        day: 5,
      ),
      RadioBroadcast(
        frequencyMhz: 108.0,
        channelName: 'Şifreli Emniyet Özel Hattı',
        transmission: 'Komiser Orhana yönelik suikast ihbarı var! Zehirbaz Kerim sahada, baristaları ve içecekleri kontrol edin!',
        day: 6,
      ),
    ];
  }

  // DÜKKÂN GELİŞTİRMELERİ (SHOP UPGRADES)
  static List<ShopUpgrade> getInitialShopUpgrades() {
    return [
      ShopUpgrade(
        id: 'upgrade_machine',
        name: 'İtalyan Çift Gruplu Makine',
        description: 'Kahve yapım hızını artırır ve müşterilerden gelen bahşişleri %30 çoğaltır.',
        cost: 150,
        icon: '☕',
      ),
      ShopUpgrade(
        id: 'upgrade_counter',
        name: 'Otomatik Sahte Para Dedektörü',
        description: 'Müşteri sahte para verdiğinde tezgâhta kırmızı ışık yakarak seni sesli uyarır.',
        cost: 200,
        icon: '🚨',
      ),
      ShopUpgrade(
        id: 'upgrade_safe',
        name: 'Çift Kilitli Çelik Zula',
        description: 'Polis aramalarında tezgah altındaki kaçak eşyaların ve silahların bulunmasını engeller.',
        cost: 120,
        icon: '🔐',
      ),
      ShopUpgrade(
        id: 'upgrade_armor',
        name: 'Çelik Tezgâh Kalkanı',
        description: '5. ve 7. günlerdeki mafya çatışmalarında dükkânı kurşun geçirmez yapar.',
        cost: 180,
        icon: '🛡️',
      ),
    ];
  }

  static DailyBulletin getBulletinForDay(int day) {
    switch (day) {
      case 1: return day1Bulletin;
      case 2: return day2Bulletin;
      case 3: return day3Bulletin;
      case 4: return day4Bulletin;
      case 5: return day5Bulletin;
      case 6: return day6Bulletin;
      default: return day7Bulletin;
    }
  }

  static List<Customer> getCustomersForDay(int day) {
    switch (day) {
      case 1:
        return [
          const Customer(
            id: 'd1_c1', name: 'Ahmet Usta', role: 'Gece Vardiyası Fırıncısı', avatarCode: 'baker',
            imagePath: 'assets/portraits/portrait_baker.jpg',
            requestedDrink: DrinkType.espresso,
            orderDialogue: 'Fırın sıcağı yaktı... Sert bir Espresso. Sade. Çabuk.',
            payment: Banknote(denomination: 50, serialNumber: 'TR-4421', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Oh... Eline sağlık evlat. Helal para, helal kahve.',
            onRejectedDialogue: 'Ne?! Alnımın terine mi şüphe ettin?!',
            onReportedDialogue: 'Polis mi?! Fırıncıyım ben be adam!', tipAmount: 15,
          ),
          const Customer(
            id: 'd1_c2', name: 'Şinasi (Jordi)', role: 'Amatör Sahtekar & Şair', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.cappuccino,
            orderDialogue: 'Şinasi ben! Bol köpüklü Cappuccino patlat! 100 kağıt temiz, lafı uzatma!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-JORD-01', isCounterfeit: true, fakeClue: 'Pastel boyayla çizilmiş!', uvReactive: false, widthMm: 141.0),
            onServedDialogue: 'Hehehe! Ticaret budur yeğenim. Afiyet olsun bana!',
            onRejectedDialogue: 'Aman be usta, sanatçının el emeğine hiç mi saygı yok?!',
            onReportedDialogue: 'Polis mi bastı?! Şinasi kaçar!', tipAmount: 30,
          ),
          const Customer(
            id: 'd1_c3', name: 'Gözlüklü Yabancı', role: 'Yeraltı Örgütü Habercisi', avatarCode: 'syndicate_agent',
            imagePath: 'assets/portraits/portrait_tetikci.jpg',
            requestedDrink: DrinkType.americano,
            orderDialogue: 'Americano. Ve şu kartviziti tezgah altına at. Gece 03:00\'te ara.',
            payment: Banknote(denomination: 100, serialNumber: 'TR-1022', isCounterfeit: false, uvReactive: true),
            contrabandToLeave: ContrabandItem(id: 'item_card_01', title: 'Karanlık Kartvizit', description: 'Tel: 555-NOIR', type: ItemType.businessCard, icon: '📇'),
            onServedDialogue: 'Akıllı adamsın barista. Vakti gelince görüşürüz.',
            onRejectedDialogue: 'Kiminle dans ettiğini bilmiyorsun.',
            onReportedDialogue: 'Gölgeye karışıp kaçtı!', tipAmount: 25,
          ),
          const Customer(
            id: 'd1_c4', name: 'Aceleci Murat', role: 'Motosikletli Kurye', avatarCode: 'courier_nervous',
            imagePath: 'assets/portraits/portrait_kurye.jpg',
            requestedDrink: DrinkType.flatWhite,
            orderDialogue: 'Çift shot Flat White! Acelem var, motor çalışıyor. Al 100\'lüğü!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-9901', isCounterfeit: true, fakeClue: 'Seri no TR-9901 kara listede!', uvReactive: true),
            onServedDialogue: 'Kurtardın beni abi! Sağ ol!',
            onRejectedDialogue: 'Geçersiz mi?! Kazıkladılar beni!',
            onReportedDialogue: 'Polis mi?! Abi valla suçsuzum!', tipAmount: 10,
          ),
        ];

      case 2:
        return [
          const Customer(
            id: 'd2_c1', name: 'Gölge Cemil', role: 'Tetikçi & Kaçakçı', avatarCode: 'hitman',
            imagePath: 'assets/portraits/portrait_tetikci.jpg',
            requestedDrink: DrinkType.doubleEspresso,
            orderDialogue: 'Duble Espresso. Şu emaneti çekmeceye at. Gri pardösülü alacak. Ötersen bittin.',
            payment: Banknote(denomination: 200, serialNumber: 'TR-8812', isCounterfeit: false, uvReactive: true),
            contrabandToLeave: ContrabandItem(id: 'item_gun_01', title: 'Susturuculu Tabanca', description: '9mm tabanca', type: ItemType.weapon, icon: '🔫', isDangerous: true),
            onServedDialogue: 'Aferin barista. Ağzını sıkı tut.',
            onRejectedDialogue: 'Bana kafa mı tutuyorsun lan sen?!',
            onReportedDialogue: 'Silahını çekip ara sokağa fırladı!', tipAmount: 50,
          ),
          const Customer(
            id: 'd2_c2', name: 'Şinasi (Jordi)', role: 'Usta (!) Ressam', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.americano,
            orderDialogue: 'Americano koy! Gece uyumadım 200\'lük çizdim! Bıyıklar on numara oldu bak!',
            payment: Banknote(denomination: 200, serialNumber: 'TR-JORD-02', isCounterfeit: true, fakeClue: 'Portreye bıyık çizilmiş!', uvReactive: false, widthMm: 154.0),
            onServedDialogue: 'Gördün mü? Emeğin önünde kimse duramaz!',
            onRejectedDialogue: 'Bıyıklar yüzünden mi çaktın yine?!',
            onReportedDialogue: 'Adalet arkamda, ben önde!', tipAmount: 20,
          ),
          const Customer(
            id: 'd2_c3', name: 'Komiser Orhan', role: 'Cinayet Masası Şefi', avatarCode: 'detective',
            imagePath: 'assets/portraits/portrait_komiser.jpg',
            requestedDrink: DrinkType.espresso,
            orderDialogue: 'Sert bir Espresso. Gözüm kan çanağı. Buralarda silahlı şüpheli gördün mü?',
            payment: Banknote(denomination: 50, serialNumber: 'TR-7711', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Sağ ol evlat. Şüpheli bir şey olursa hemen alarma bas.',
            onRejectedDialogue: 'Polise kahve yok mu?! Teftişe boğarım burayı!',
            onReportedDialogue: 'Ne oldu barista?! Ekipleri yönlendiriyorum!', tipAmount: 20,
          ),
          const Customer(
            id: 'd2_c4', name: 'Pardösülü Alıcı', role: 'Örgüt Kuryesi', avatarCode: 'trenchcoat_man',
            imagePath: 'assets/portraits/portrait_tetikci.jpg',
            requestedDrink: DrinkType.latte,
            orderDialogue: 'Latte. Arkadaşım sana paket bıraktı. Emanet hazır mı barista?',
            payment: Banknote(denomination: 100, serialNumber: 'TR-5590', isCounterfeit: false, uvReactive: true),
            expectedContrabandId: 'item_gun_01',
            onServedDialogue: 'Kahve güzel... Ama emanet nerede?',
            onRejectedDialogue: 'Yanlış adama diklendin.',
            onReportedDialogue: 'Sirenleri duyunca küfrederek kaçtı!',
            onContrabandReceivedDialogue: 'Güzel. Al şu 200\'ü, sus payın.', tipAmount: 40,
          ),
        ];

      case 3: // KAÇAK MENÜ & İRLANDA VİSKİSİ
        return [
          const Customer(
            id: 'd3_c1', name: 'Kaptan Salih', role: 'Kaçakçı Kaptan', avatarCode: 'hitman',
            imagePath: 'assets/portraits/portrait_kaptan.jpg',
            requestedDrink: DrinkType.doubleEspresso,
            orderDialogue: 'Duble Espresso. Şu viski şişesini çekmeceye sakla. Bob\'a İrlanda kahvesi yaparsın. Telsiz açık kalsın.',
            payment: Banknote(denomination: 100, serialNumber: 'TR-3120', isCounterfeit: false, uvReactive: true),
            contrabandToLeave: ContrabandItem(id: 'item_whiskey_01', title: 'Kaçak İrlanda Viskisi', description: 'Tezgah altından kahvelere katılabilecek özel kaçak viski!', type: ItemType.whiskeyBottle, icon: '🍾'),
            onServedDialogue: 'Eyvallah evlat. Şişeyi iyi koru.',
            onRejectedDialogue: 'Deniz kurduna artistlik ha?!',
            onReportedDialogue: 'Düdüğü çalıp liman karanlığına daldı!', tipAmount: 40,
          ),
          const Customer(
            id: 'd3_c2', name: 'Sarhoş Bob', role: 'İrlandalı Denizci', avatarCode: 'courier_nervous',
            imagePath: 'assets/portraits/portrait_kurye.jpg',
            requestedDrink: DrinkType.irishCoffee,
            orderDialogue: 'Heyyy barista! Kaptanın viskisinden bolca damlat, sert bir İrlanda Kahvesi ver!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-8840', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'OHHH! İşte limanın gerçek lezzeti!',
            onRejectedDialogue: 'Hani viskili kahve nerede?!',
            onReportedDialogue: 'Sendeleyerek kaçtı!', tipAmount: 50,
          ),
          const Customer(
            id: 'd3_c3', name: 'Şinasi (Jordi)', role: 'Gazete Kesicisi', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.americano,
            orderDialogue: 'Americano! Gazeteden kupon keser gibi kestim 100\'lüğü. Cetvelle ölç tam milimetrik!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-JORD-03', isCounterfeit: true, fakeClue: 'Ebatları cetvelle 138mm çıkıyor (Standart 148mm)!', uvReactive: false, widthMm: 138.0),
            onServedDialogue: 'Haha! Gazete baskısı da para sayılır!',
            onRejectedDialogue: 'Cetvelle ölçeceğini hiç düşünmemiştim!',
            onReportedDialogue: 'Yine mi siren?! Ben yokum!', tipAmount: 10,
          ),
        ];

      case 4: // ŞANTAJ KASETİ
        return [
          const Customer(
            id: 'd4_c1', name: 'Muhabir Can', role: 'Korkak Araştırmacı Gazeteci', avatarCode: 'courier_nervous',
            imagePath: 'assets/portraits/portrait_kurye.jpg',
            requestedDrink: DrinkType.flatWhite,
            orderDialogue: 'Flat White! Ve şu kaseti sakla! Emniyet müdürünün rüşvet kaydı var içinde! Peşimdeler!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-4481', isCounterfeit: false, uvReactive: true),
            contrabandToLeave: ContrabandItem(id: 'item_cassette_01', title: 'Şantaj Kaseti', description: 'Emniyet müdürünün rüşvet kaydı kaseti', type: ItemType.blackmailTape, icon: '📼', isDangerous: true),
            onServedDialogue: 'Hayatımı kurtardın... Kaseti kimseye verme.',
            onRejectedDialogue: 'Beni ölüme terk ettin!',
            onReportedDialogue: 'Çığlık atarak sokağa fırladı!', tipAmount: 30,
          ),
          const Customer(
            id: 'd4_c2', name: 'Komiser Orhan', role: 'Cinayet Masası Şefi', avatarCode: 'detective',
            imagePath: 'assets/portraits/portrait_komiser.jpg',
            requestedDrink: DrinkType.espresso,
            orderDialogue: 'Espresso. Muhabir Can buraya uğradı mı? Elinde siyah bir kaset var mıydı?',
            payment: Banknote(denomination: 50, serialNumber: 'TR-1190', isCounterfeit: false, uvReactive: true),
            expectedContrabandId: 'item_cassette_01',
            onServedDialogue: 'Bir şey saklıyorsan başın çok fena yanar.',
            onRejectedDialogue: 'Kanuna karşı duran herkes suçludur!',
            onReportedDialogue: 'Baskın hazırlığı yapıyorum!',
            onContrabandReceivedDialogue: 'Kaset sende miydi?! Tüm teşkilatı kurtardın! 200₺ ödülün cebinde!', tipAmount: 20,
          ),
          const Customer(
            id: 'd4_c3', name: 'Şinasi (Jordi)', role: 'Fotokopi Ustası', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.cappuccino,
            orderDialogue: 'Cappuccino! Kırtasiyeden renkli fotokopi çektim, taze çıktı! Bol köpük koy!',
            payment: Banknote(denomination: 100, serialNumber: 'TAPE-8800', isCounterfeit: true, fakeClue: 'Seri no TAPE-8800 kara listede!', uvReactive: false),
            onServedDialogue: 'Fotokopiye de kahve veren koca yürekli esnaf!',
            onRejectedDialogue: 'Renkli toner bile kurtarmadı...',
            onReportedDialogue: 'Devriyeler bastı, kaçtım!', tipAmount: 15,
          ),
        ];

      case 5: // BÜYÜK PATRON "DON SELİM" & AFFOGATO
        return [
          const Customer(
            id: 'd5_c1', name: 'Don Selim', role: 'Yeraltı Mafya Baronu', avatarCode: 'syndicate_agent',
            imagePath: 'assets/portraits/portrait_don_selim.jpg',
            requestedDrink: DrinkType.affogato,
            orderDialogue: 'Affogato. Duble espresso, vanilyalı dondurma. Kusursuz olsun. Şehirde sırtın yere gelmez.',
            payment: Banknote(denomination: 200, serialNumber: 'TR-GOLD-99', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Nefis. Sadakatini unutmam barista. Al şu 100\'lüğü.',
            onRejectedDialogue: 'Don Selim\'e ret ha? Bu dükkân sabaha çıkmaz.',
            onReportedDialogue: 'Gözlerini kısıp gülümsedi: "Polis bana dokunamaz evlat..."', tipAmount: 100,
          ),
          const Customer(
            id: 'd5_c2', name: 'Gölge Tetikçi', role: 'Don Selim\'in Koruması', avatarCode: 'hitman',
            imagePath: 'assets/portraits/portrait_tetikci.jpg',
            requestedDrink: DrinkType.doubleEspresso,
            orderDialogue: 'Patronun ardından Duble Espresso. Hata istemem.',
            payment: Banknote(denomination: 100, serialNumber: 'TR-9932', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Temiz.',
            onRejectedDialogue: 'Eceline susadın.',
            onReportedDialogue: 'Kaşlarını çatıp çekip gitti.', tipAmount: 30,
          ),
          const Customer(
            id: 'd5_c3', name: 'Şinasi (Jordi)', role: 'Gölge Şair', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.mocha,
            orderDialogue: 'Mocha! Çikolatası bol olsun. Üzerinde Don Selim resmi olan 200\'lük verdim, geçerli mi?!',
            payment: Banknote(denomination: 200, serialNumber: 'MOB-001', isCounterfeit: true, fakeClue: 'Seri no MOB-001 mafya sahtesi kara listede!', uvReactive: false),
            onServedDialogue: 'Mocha değil cennet şerbeti!',
            onRejectedDialogue: 'Don Selim resmini de mi beğenmedin?!',
            onReportedDialogue: 'Şinasi ara sokaklara kaçar!', tipAmount: 20,
          ),
        ];

      case 6: // ZEHİR & KOMPLO
        return [
          const Customer(
            id: 'd6_c1', name: 'Zehirbaz Kerim', role: 'Kiralık Suikastçı', avatarCode: 'assassin_mask',
            imagePath: 'assets/portraits/portrait_zehirci.jpg',
            requestedDrink: DrinkType.doubleEspresso,
            orderDialogue: 'Duble Espresso. Şu zehir şişesini al. Komiser gelince 3 damla damlat! 500₺ sus payı! Yoksa ölürsün!',
            payment: Banknote(denomination: 200, serialNumber: 'TR-3399', isCounterfeit: false, uvReactive: true),
            contrabandToLeave: ContrabandItem(id: 'item_poison_01', title: 'Renksiz Zehir Şişesi', description: 'Komiserin kahvesine katılması istendi!', type: ItemType.poisonVial, icon: '🧪', isDangerous: true),
            onServedDialogue: 'Gözüm üzerinde barista... Komiserin bardağını unutma.',
            onRejectedDialogue: 'Eceline susadın sen...',
            onReportedDialogue: 'Pencereden karanlığa atladı!', tipAmount: 80, asksForPoison: true,
          ),
          const Customer(
            id: 'd6_c2', name: 'Komiser Orhan', role: 'Cinayet Masası Şefi', avatarCode: 'detective',
            imagePath: 'assets/portraits/portrait_komiser.jpg',
            requestedDrink: DrinkType.americano,
            orderDialogue: 'Büyük Americano. Zehirci Kerim limanda görülmüş. Operasyon sabaha kadar sürecek.',
            payment: Banknote(denomination: 100, serialNumber: 'TR-9110', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Sağ ol barista... Dürüst esnaflar bu şehrin vicdanıdır.',
            onRejectedDialogue: 'Neyin peşindesin sen?! Şüphelendiriyorsun beni!',
            onReportedDialogue: 'Ne?! Kahveme zehir mi katacaklardı?! Hayatımı kurtardın barista!', tipAmount: 50,
          ),
          const Customer(
            id: 'd6_c3', name: 'Şinasi (Jordi)', role: 'Final Provacısı', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.cappuccino,
            orderDialogue: 'Yarın jübilemi yapıyorum, bir Cappuccino ver! Bu sefer parayı simli tükenmezle süsledim!',
            payment: Banknote(denomination: 100, serialNumber: 'POIS-999', isCounterfeit: true, fakeClue: 'Simli jel kalemle çizilmiş sahte para!', uvReactive: false),
            onServedDialogue: 'Yarınki jübileme seni de beklerim!',
            onRejectedDialogue: 'Simleri de mi beğenmedin be!',
            onReportedDialogue: 'Polis amcalar yine mesaide!', tipAmount: 10,
          ),
        ];

      default: // GÜN 7: BÜYÜK HESAPLAŞMA & FİNAL
        return [
          const Customer(
            id: 'd7_c1', name: 'Liman Kaptanı', role: 'Kaçak Gece Gemisi', avatarCode: 'hitman',
            imagePath: 'assets/portraits/portrait_kaptan.jpg',
            requestedDrink: DrinkType.irishCoffee,
            orderDialogue: 'Gece 04:00\'te gemi kalkıyor. 400₺ biletin varsa kaçırırım seni. Yolluk bir İrlanda Kahvesi yap!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-7700', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Hazırlan barista, gece gemide yerin hazır.',
            onRejectedDialogue: 'Sen bilirsin, bu şehirde çürürsün.',
            onReportedDialogue: 'Liman düdüğünü çalıp gemiye kaçtı!', tipAmount: 50,
          ),
          const Customer(
            id: 'd7_c2', name: 'Şinasi Dayı (Jordi)', role: 'Efsanevi Sahtekar (Jübile)', avatarCode: 'shady_clown',
            imagePath: 'assets/portraits/portrait_sinasi.jpg',
            requestedDrink: DrinkType.cappuccino,
            orderDialogue: 'SÜRPRİZ! Büyük final! Altın yaldızlı 200\'lük bastım, arkasına "Emekli Jordi Hatırası" damgası vurdum! Cappuccino ver helalleşelim!',
            payment: Banknote(denomination: 200, serialNumber: 'FINAL-777', isCounterfeit: true, fakeClue: 'Arkasına mühürle "Emekli Jordi Hatırası" basılmış!', uvReactive: false),
            onServedDialogue: 'Hakkını helal et barista! Unutulmazdı!',
            onRejectedDialogue: 'Hahaha yakalandık yine! Denemeye değerdi!',
            onReportedDialogue: 'Emeklilik ikramiyesi yerine kelepçe mi?! Kaçtım!', tipAmount: 50,
          ),
          const Customer(
            id: 'd7_c3', name: 'Komiser Orhan', role: 'Emniyet Müdürü Vekili', avatarCode: 'detective',
            imagePath: 'assets/portraits/portrait_komiser.jpg',
            requestedDrink: DrinkType.espresso,
            orderDialogue: 'Son vardiya barista... Çeteleri temizledik. Bana sert bir zafer Espresso\'su yap!',
            payment: Banknote(denomination: 100, serialNumber: 'TR-0001', isCounterfeit: false, uvReactive: true),
            onServedDialogue: 'Tebrikler evlat. Bu şehri birlikte kurtardık.',
            onRejectedDialogue: 'Hala mı sır saklıyorsun?',
            onReportedDialogue: 'Ekipler hazır!', tipAmount: 100,
          ),
        ];
    }
  }
}

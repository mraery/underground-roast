# Underground Roast (Karanlık Barista) ☕🕵️‍♂️🔫

> *"Papers, Please" mantığında teftiş, ahlaki ikilemler, sahte para tespiti ve yeraltı örgütleri ile "Coffee Talk" tarzı barista kahve hazırlama simülasyonunu birleştiren atmosferik kara-mizah oyunu.*

---

## 🎮 Nasıl Oynanır? (Oynanış Rehberi)

Oyunda tehlikeli bir liman bölgesinde gece açık tek kahvehaneyi işleten bir baristasınız. Amacınız hem doğru kahveleri hazırlayıp para kazanmak, hem de gelen suçlular, dolandırıcılar, polisler ve tetikçiler arasında hayatta kalmak!

### 1. Barista İstasyonu (Kahve Hazırlama)
- **Bardak Seçimi:** Küçük Fincan, Standart Kupa veya Büyük Bardak.
- **Espresso Çekimi:** 
  - Tek Shot (30ml) -> Espresso, Cappuccino, Latte için.
  - Duble Shot (60ml) -> Duble Espresso, Flat White için.
- **Sıcak Su:** Americano için espresso üzerine sıcak su ekleyin.
- **Süt & Köpük:**
  - Latte Sütü (İnce kadife mikro-köpük).
  - Cappuccino Köpüğü (Yoğun zengin bol köpük).
- **Zehir Damlası:** Eğer kiralık katil tezgaha zehir bıraktıysa ve dedektifi zehirlemek isterseniz gizli seçenek açılır!

### 2. Teftiş ve Karar Masası (Papers, Please Mantığı)
- **Banknot İnceleme:**
  - Müşterinin bıraktığı paraya tıklayarak inceleme masasını açın.
  - **Normal Işık:** Banknot detayları, seri numarası, çizim kalitesi.
  - **UV Mor Işık:** Gerçek parada resmi filigran ve kılcal lifler parlar. Sahte parada ise Jordi usulü kurşun kalemle çizimler, "GEÇERSİZ" damgaları veya eksik filigran ortaya çıkar!
- **Günlük Asayiş Bülteni (Dosya):**
  - Polis emniyetinin her gün yayınladığı kuralları, yasaklı seri numaralarını ve aranan şüphelileri inceleyin.
- **Gizli Tezgâh Çekmecesi (Zula):**
  - Müşterilerin tezgâha bıraktığı emanetleri (susturuculu tabanca, karanlık kartvizit, zehir şişesi) saklayın veya doğru alıcıya teslim edin.
- **Karar Düğmeleri:**
  - `[KAHVEYİ VER & ÜCRETİ AL]`: Servis yapar ve parayı kasaya atar. (Sahte parayı kabul ederseniz 60₺ ceza yersiniz!)
  - `[REDDET & KOV]`: Sahte para veren dolandırıcıları veya şüphelileri dükkandan kovar!
  - `[GİZLİ ALARM (POLİS ÇAĞIR)]`: Tezgâh altındaki butona basarak polisi çağırır. Suçluyu yakalatırsanız 100₺ ödül; masum birini ihbar ederseniz 50₺ ceza alırsınız!

---

## ⚡ Oyunu Başlatma (Windows)

Dizin: `C:\Users\roy\.gemini\antigravity\scratch\underground_roast`

1. Klasördeki **`baslat.bat`** dosyasına çift tıklayın.
2. Oyun otomatik olarak tam ekran masaüstü penceresi modunda açılacaktır!
3. Alternatif olarak tarayıcınızdan `http://localhost:8085` adresine gidebilirsiniz.

---

## 📱 İleride Mobil (Android / iOS) Derleme

Bu proje saf Flutter mimarisiyle geliştirildiği için kod değişikliği yapmadan doğrudan mobile derlenebilir:

```bash
# Android APK Derleme
flutter build apk --release

# Android App Bundle (Google Play Store)
flutter build appbundle --release
```

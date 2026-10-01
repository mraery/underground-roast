import 'drink.dart';
import 'item.dart';

class Customer {
  final String id;
  final String name;
  final String role;
  final String avatarCode; // Avatar görsel tipi
  final DrinkType requestedDrink;
  final String orderDialogue;
  final Banknote payment;
  final ContrabandItem? contrabandToLeave; // Bırakmak istediği eşya
  final String? expectedContrabandId; // Almak istediği emanet eşya ID'si
  final String onServedDialogue;
  final String onRejectedDialogue;
  final String onReportedDialogue;
  final String? onContrabandReceivedDialogue;
  final bool isWanted; // Polisin aradığı biri mi?
  final int tipAmount;
  final bool asksForPoison; // Hedef için zehir istiyor mu?
  final String? imagePath;

  const Customer({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarCode,
    required this.requestedDrink,
    required this.orderDialogue,
    required this.payment,
    this.contrabandToLeave,
    this.expectedContrabandId,
    required this.onServedDialogue,
    required this.onRejectedDialogue,
    required this.onReportedDialogue,
    this.onContrabandReceivedDialogue,
    this.isWanted = false,
    this.tipAmount = 10,
    this.asksForPoison = false,
    this.imagePath,
  });

  String get portraitAssetPath {
    if (imagePath != null && imagePath!.isNotEmpty) return imagePath!;
    switch (avatarCode) {
      case 'baker':
        return 'assets/portraits/portrait_baker.jpg';
      case 'shady_clown':
        return 'assets/portraits/portrait_sinasi.jpg';
      case 'detective':
        return 'assets/portraits/portrait_komiser.jpg';
      case 'courier_nervous':
        return 'assets/portraits/portrait_kurye.jpg';
      case 'hitman':
        return 'assets/portraits/portrait_tetikci.jpg';
      case 'assassin_mask':
        return 'assets/portraits/portrait_zehirci.jpg';
      case 'syndicate_agent':
        return 'assets/portraits/portrait_don_selim.jpg';
      case 'trenchcoat_man':
        return 'assets/portraits/portrait_kaptan.jpg';
      default:
        return 'assets/portraits/portrait_sinasi.jpg';
    }
  }
}

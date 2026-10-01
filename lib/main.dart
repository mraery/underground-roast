import 'package:flutter/material.dart';
import 'controllers/game_controller.dart';
import 'theme/noir_theme.dart';
import 'widgets/booth/customer_booth_window.dart';
import 'widgets/barista/interactive_coffee_machine.dart';
import 'widgets/bulletin_dialog.dart';
import 'widgets/day_end_screen.dart';
import 'widgets/desk/physical_inspection_desk.dart';
import 'widgets/money_inspector_modal.dart';
import 'widgets/radio_scanner_dialog.dart';
import 'widgets/stash_drawer_dialog.dart';
import 'widgets/top_status_bar.dart';

void main() {
  runApp(const UndergroundRoastApp());
}

class UndergroundRoastApp extends StatelessWidget {
  const UndergroundRoastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Underground Roast - Karanlık Barista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: NoirTheme.background,
        colorScheme: const ColorScheme.dark(
          primary: NoirTheme.amberWarm,
          surface: NoirTheme.surface,
        ),
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Stack(
            children: [
              // ANA OYUN ARAYÜZÜ
              SafeArea(
                child: Column(
                  children: [
                    // 1. ÜST DURUM ÇUBUĞU (GÜN, KASA, CEZALAR, BÜLTEN & ZULA BUTONLARI)
                    TopStatusBar(controller: _controller),

                    // 2. GİŞE PENCERESİ (MÜŞTERİ CAMIN ARKASINDA VE DOĞRUDAN KARŞIMIZDA)
                    CustomerBoothWindow(controller: _controller),

                    // 3. ALT TEZGÂH (SOLDA FİZİKSEL KAHVE MAKİNESİ, SAĞDA TEFTİŞ MASASI & BANKNOT)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 800) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: InteractiveCoffeeMachine(controller: _controller),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 5,
                                    child: PhysicalInspectionDesk(controller: _controller),
                                  ),
                                ],
                              );
                            } else {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 380,
                                      child: InteractiveCoffeeMachine(controller: _controller),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 360,
                                      child: PhysicalInspectionDesk(controller: _controller),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- AÇILIR MODALLAR VE DİYALOGLAR ---

              // 1. PARA İNCELEME (UV / BÜYÜTEÇ) MODALI
              if (_controller.isInspectingMoney)
                Container(
                  color: Colors.black54,
                  child: MoneyInspectorModal(controller: _controller),
                ),

              // 2. GÜNLÜK ASAYİŞ BÜLTENİ
              if (_controller.isBulletinOpen)
                Container(
                  color: Colors.black54,
                  child: BulletinDialog(controller: _controller),
                ),

              // 3. ZULA (GİZLİ ÇEKMECE)
              if (_controller.isStashOpen)
                Container(
                  color: Colors.black54,
                  child: StashDrawerDialog(controller: _controller),
                ),

              // 4. GİZLİ POLİS TELSİZİ
              if (_controller.isRadioScannerOpen)
                Container(
                  color: Colors.black54,
                  child: RadioScannerDialog(controller: _controller),
                ),

              // 5. GÜN SONU BİLANÇOSU & GECE GAZETESİ
              if (_controller.isDayEnd)
                Container(
                  color: Colors.black87,
                  child: DayEndScreen(controller: _controller),
                ),
            ],
          ),
        );
      },
    );
  }
}

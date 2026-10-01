import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game_state.dart';
import '../theme/noir_theme.dart';

class RadioScannerDialog extends StatefulWidget {
  final GameController controller;

  const RadioScannerDialog({super.key, required this.controller});

  @override
  State<RadioScannerDialog> createState() => _RadioScannerDialogState();
}

class _RadioScannerDialogState extends State<RadioScannerDialog> {
  double currentFreq = 98.4;

  @override
  Widget build(BuildContext context) {
    // Aktif frekansta yayın var mı?
    RadioBroadcast? activeBroadcast;
    for (var b in widget.controller.radioBroadcasts) {
      if ((b.frequencyMhz - currentFreq).abs() < 0.4 && b.day <= widget.controller.currentDay) {
        activeBroadcast = b;
        break;
      }
    }

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 580,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF14171A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.greenAccent.shade700, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withValues(alpha: 0.25),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ÜST PANEL: TELSİZ BAŞLIĞI & LED
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeBroadcast != null ? Colors.greenAccent : Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color: (activeBroadcast != null ? Colors.greenAccent : Colors.redAccent).withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'GİZLİ POLİS TELSİZİ & FREKANS DİNLEME',
                    style: NoirTheme.typewriterSubheading.copyWith(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: widget.controller.toggleRadioScanner,
                  ),
                ],
              ),
              const Divider(color: Colors.white24),
              const SizedBox(height: 12),

              // FREKANS GÖSTERGESİ (YEŞİL RETRO LCD)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A120D),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${currentFreq.toStringAsFixed(1)} MHz',
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.greenAccent,
                        letterSpacing: 4,
                      ),
                    ),
                    Text(
                      activeBroadcast != null ? '[SİNYAL KİLİTLENDİ]' : '[PARAZİT / STATİK]',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: activeBroadcast != null ? Colors.greenAccent : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // FREKANS AYAR ÇUBUĞU (TUNER SLIDER)
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.greenAccent,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: Colors.greenAccent,
                  overlayColor: Colors.greenAccent.withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: currentFreq,
                  min: 88.0,
                  max: 110.0,
                  divisions: 110,
                  onChanged: (val) {
                    setState(() {
                      currentFreq = double.parse(val.toStringAsFixed(1));
                    });
                  },
                ),
              ),

              // HIZLI KANAL BUTONLARI
              Row(
                children: [
                  _buildPresetButton('98.4 MHz (Merkez)', 98.4),
                  const SizedBox(width: 8),
                  _buildPresetButton('104.2 MHz (Gümrük)', 104.2),
                  const SizedBox(width: 8),
                  _buildPresetButton('108.0 MHz (Özel Hat)', 108.0),
                ],
              ),

              const SizedBox(height: 16),

              // GELEN CANLI TELSİZ ANONSU
              Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                ),
                child: activeBroadcast != null
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KANAL: ${activeBroadcast.channelName.toUpperCase()}',
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '"${activeBroadcast.transmission}"',
                              style: const TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 13,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Cızzzzzz... (Frekansı çevirerek polisin gizli anons kanalını yakala)',
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: Colors.white30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 14),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.controller.toggleRadioScanner,
                  child: const Text(
                    'TELSİZİ TEZGÂH ALTINA İNDİR',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPresetButton(String label, double freq) {
    bool isSelected = (currentFreq - freq).abs() < 0.1;
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.greenAccent.withValues(alpha: 0.2) : Colors.transparent,
          side: BorderSide(color: isSelected ? Colors.greenAccent : Colors.white24),
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          setState(() {
            currentFreq = freq;
          });
        },
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.greenAccent : Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

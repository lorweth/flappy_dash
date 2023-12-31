import 'package:flappy_dash/audio/audio_controller.dart';
import 'package:flappy_dash/audio/sounds.dart';
import 'package:flappy_dash/settings/settings.dart';
import 'package:flappy_dash/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final audioController = context.read<AudioController>();
    final settingsController = context.watch<SettingsController>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings.color,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: ListView(
                    children: [
                      _gap,
                      const Text(
                        'Settings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Press Start 2P',
                          fontSize: 30,
                          height: 1,
                        ),
                      ),
                      _gap,
                      ValueListenableBuilder(
                        valueListenable: settingsController.isDebugMode,
                        builder: (key, value, child) => _SettingsCheckbox(
                          title: 'Debug Mode',
                          value: value,
                          onTap: () {
                            audioController.playSfx(SfxType.buttonTap);
                            settingsController.toggleDebugMode();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NesButton(
                type: NesButtonType.normal,
                onPressed: () {
                  audioController.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).pop();
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 60);
}

class _SettingsCheckbox extends StatelessWidget {
  final String title;

  final VoidCallback? onTap;

  final bool? value;

  const _SettingsCheckbox({
    required this.title,
    this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Press Start 2P',
                fontSize: 20,
              ),
            ),
          ),
          NesCheckBox(
            value: value ?? false,
            onChange: (isChecked) => onTap!(),
          ),
        ],
      ),
    );
  }
}

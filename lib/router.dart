import 'package:flappy_dash/flame_game/game_scene.dart';
import 'package:flappy_dash/main_menu/main_menu.dart';
import 'package:flappy_dash/settings/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const MainMenu(key: Key('main menu'));
      },
      routes: [
        GoRoute(
          path: 'play',
          builder: (context, state) {
            return const GameScene(key: ValueKey('play'));
          }
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) {
            return const SettingsScreen(key: ValueKey('settings'));
          }
        )
      ]
    )
  ],
);

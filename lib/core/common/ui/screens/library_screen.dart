import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  static const routePath = '/';
  static const routeName = 'library';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Library',
              style: TextStyle(color: context.colors.foregroundPrimary),
            ),
            backgroundColor: context.colors.backgroundSecondary,
            border: null,
            heroTag: 'library_screen',
          ),
        ],
      ),
    );
  }
}

import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/info_card.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DemoVideoDisplay extends StatefulWidget {
  const DemoVideoDisplay({super.key});

  static const routeName = 'video_demo';
  static const routPath = 'exercise/video_demo';

  @override
  State<DemoVideoDisplay> createState() => _DemoVideoDisplayState();
}

class _DemoVideoDisplayState extends State<DemoVideoDisplay> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'puxOweptIMs',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        controller: _controller,
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: context.colors.backgroundSecondary,
        appBar: CupertinoNavigationBar(
          middle: Text(
            'Video Demo',
            style: TextStyle(color: context.colors.foregroundPrimary),
          ),
          leading: const FlexBackButton(
            icon: Symbols.close,
          ),
          backgroundColor: context.colors.backgroundSecondary,
          border: null,
          padding: EdgeInsetsDirectional.zero,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppLayout.p4,
            vertical: AppLayout.p6,
          ),
          child: Column(
            children: [
              player,
              const SizedBox(height: AppLayout.p4),
              const InfoCard(
                icon: Symbols.info,
                info:
                    'This video provides a quick demonstration of the exercise '
                    'showcasing the technique, and highlighting some queues '
                    'to keep in mind while performing this exercise.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

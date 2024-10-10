import 'package:flex_workout_mobile/core/common/ui/components/back_button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/button.dart';
import 'package:flex_workout_mobile/core/common/ui/components/info_card.dart';
import 'package:flex_workout_mobile/core/extensions/ui_extensions.dart';
import 'package:flex_workout_mobile/core/theme/app_layout.dart';
import 'package:flex_workout_mobile/features/exercise/controllers/exercise_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DemoVideoDisplay extends ConsumerStatefulWidget {
  const DemoVideoDisplay({required this.id, super.key});

  final String id;

  static const routeName = 'video_demo';
  static const routPath = 'video_demo';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DemoVideoDisplayState();
}

class _DemoVideoDisplayState extends ConsumerState<DemoVideoDisplay> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final exercise = ref.read(exerciseViewControllerProvider(widget.id));

    _controller = YoutubePlayerController(
      initialVideoId: exercise.youtubeVideoId!,
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
    final exercise = ref.watch(exerciseViewControllerProvider(widget.id));

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: AppLayout.p4,
          vertical: AppLayout.p2,
        ),
        bottomActions: const [
          Expanded(
            child: VideoDisplayControls(),
          ),
        ],
        controller: _controller,
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: context.colors.backgroundSecondary,
        appBar: CupertinoNavigationBar(
          middle: Text(
            '${exercise.name} Demo',
            style: TextStyle(color: context.colors.foregroundPrimary),
          ),
          leading: const FlexBackButton(),
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
              Container(
                decoration: BoxDecoration(
                  color: context.colors.blue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppLayout.cornerRadius),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Container(child: player),
              ),
              const SizedBox(height: AppLayout.p4),
              const InfoCard(
                icon: Symbols.info,
                info: 'This video provides a quick demo of the exercise '
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

class VideoDisplayControls extends StatefulWidget {
  const VideoDisplayControls({this.controller, super.key});

  final YoutubePlayerController? controller;

  @override
  State<VideoDisplayControls> createState() => _VideoDisplayControlsState();
}

class _VideoDisplayControlsState extends State<VideoDisplayControls> {
  late YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = YoutubePlayerController.of(context);
    if (controller == null) {
      assert(
        widget.controller != null,
        '\n\nNo controller could be found in the provided context.\n\n'
        'Try passing the controller explicitly.',
      );
      _controller = widget.controller!;
    } else {
      _controller = controller;
    }
    _controller
      ..removeListener(listener)
      ..addListener(listener);
  }

  @override
  void dispose() {
    _controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: AppLayout.p2),
            RichText(
              text: TextSpan(
                text: durationFormatter(_controller.value.position),
                style: context.typography.labelMedium
                    .copyWith(fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: ' / ',
                    style: context.typography.labelMedium.copyWith(
                      color: context.colors.foregroundSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: durationFormatter(_controller.metadata.duration),
                    style: context.typography.labelMedium.copyWith(
                      color: context.colors.foregroundSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            FlexButton(
              padding: const EdgeInsets.all(AppLayout.p2),
              icon: Symbols.fullscreen,
              iconWeight: 900,
              backgroundColor: Colors.transparent,
              onPressed: () => _controller.toggleFullScreenMode(),
            ),
          ],
        ),
        ProgressBar(
          colors: ProgressBarColors(
            backgroundColor: context.colors.foregroundSecondary,
            bufferedColor: context.colors.foregroundPrimary,
            playedColor: context.colors.blue,
            handleColor: context.colors.blue,
          ),
        ),
      ],
    );
  }
}

String durationFormatter(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  return '${duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : ''}'
      '$twoDigitMinutes:'
      '$twoDigitSeconds';
}

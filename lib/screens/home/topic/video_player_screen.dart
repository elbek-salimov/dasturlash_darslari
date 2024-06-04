import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.controller});

  final YoutubePlayerController controller;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   widget.controller.pause();
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Future.delayed(const Duration(seconds: 2));
            Navigator.pop(context);
            // SystemChrome.setPreferredOrientations([
            //   DeviceOrientation.portraitUp,
            //   DeviceOrientation.portraitDown,
            // ]);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: YoutubePlayerBuilder(
          onExitFullScreen: () {
            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          player: YoutubePlayer(
            controller: widget.controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            thumbnail: Image.network(
                'https://img.youtube.com/vi/${widget.controller.initialVideoId}/maxresdefault.jpg'),
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            // onReady: () {
            //   _controller.addListener((){});
            // },
          ),
          builder: (context, player) {
            return player;
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dasturlash_darslari/utils/colors/app_colors.dart';
import 'package:dasturlash_darslari/utils/size/app_size.dart';
import 'package:dasturlash_darslari/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/models/course/course_model.dart';
import '../../../data/models/course/lesson_model.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key, required this.selectedLesson, required this.selectedCourse});
  final LessonModel selectedLesson;
  final CourseModel selectedCourse;

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  late YoutubePlayerController _controller;
  late String videoId;

  @override
  void initState() {
    videoId = widget.selectedLesson.lessonVideoId;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        loop: true,
        // hideControls: true,
        enableCaption: false,
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final CarouselController _carouselController = CarouselController();
  double _scale = 1.0;

  void _zoomIn() {
    setState(() {
      _scale = (_scale + 0.1).clamp(1.0, 4.0);
    });
  }

  void _zoomOut() {
    setState(() {
      _scale = (_scale - 0.1).clamp(1.0, 4.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cD4E0E8,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.cD4E0E8,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return MyHomePage();
              // }));
            },
            icon: const Icon(Icons.cast),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.selectedLesson.lessonTitle,
                style:
                    AppTextStyle.sfProRoundedBold.copyWith(color: Colors.black),
              ),
              10.getH(),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.w),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  thumbnail: Image.network(
                    'https://img.youtube.com/vi/$videoId/maxresdefault.jpg',
                  ),
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
              ),
              10.getH(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: Colors.white70.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            height: 40.w,
                            width: 40.w,
                            fit: BoxFit.cover,
                            imageUrl: widget.selectedLesson.lessonVideoId.isNotEmpty
                                ? widget.selectedCourse.mentorImageUrl
                                : 'https://www.sleepworld.com/on/demandware.static/Sites-Sleepworld-Site/-/default/dw5a35aafc/images/large_missing.jpg',
                            placeholder: (context, url) => Shimmer.fromColors(
                              enabled: true,
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(6.w),
                                ),
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Text(
                          widget.selectedCourse.mentorName,
                          style: AppTextStyle.sfProRoundedSemiBold
                              .copyWith(color: Colors.black, fontSize: 16.w),
                        ),
                        Text(
                          'Mentor',
                          style: AppTextStyle.sfProRoundedRegular
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              20.getH(),
              Text(
                'Documentation',
                style: AppTextStyle.sfProRoundedMedium
                    .copyWith(color: Colors.black, fontSize: 20.w),
              ),
              10.getH(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: Colors.white70.withOpacity(0.3),
                ),
                child: Text(
                  textAlign: TextAlign.justify,
                 widget.selectedLesson.lessonDescription,
                  style: AppTextStyle.sfProRoundedRegular
                      .copyWith(color: Colors.black),
                ),
              ),
              20.getH(),
              Text(
                'Other',
                style: AppTextStyle.sfProRoundedMedium
                    .copyWith(color: Colors.black, fontSize: 20.w),
              ),
              10.getH(),
              CarouselSlider(
                items: List.generate(
                  widget.selectedLesson.lessonImages.length,
                  (index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.w),
                      child: InteractiveViewer(
                        minScale: 1.0,
                        maxScale: 4.0,
                        scaleEnabled: false,
                        transformationController: TransformationController()
                          ..value = Matrix4.identity().scaled(_scale),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: widget.selectedLesson.lessonImages.isNotEmpty
                              ? widget.selectedLesson.lessonImages[index]
                              : 'https://www.sleepworld.com/on/demandware.static/Sites-Sleepworld-Site/-/default/dw5a35aafc/images/large_missing.jpg',
                          placeholder: (context, url) => Shimmer.fromColors(
                            enabled: true,
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6.w),
                              ),
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                    );
                  },
                ),
                options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  // height: double.infinity,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _scale = 1.0;
                    });
                  },
                ),
                carouselController: _carouselController,
              ),
              10.getH(),
              Container(
                width: double.infinity,
                // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: Colors.black54.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        _carouselController.previousPage();
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_out, color: Colors.white),
                      onPressed: _zoomOut,
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_in, color: Colors.white),
                      onPressed: _zoomIn,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

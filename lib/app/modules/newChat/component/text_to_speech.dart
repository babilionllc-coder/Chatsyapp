import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../elevenLabLib/elevenlabs_flutter.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';

class TextToSpeechView extends StatefulWidget {
  TextToSpeechView({
    required this.text,
    required this.isShowElevenLab,
    Rx<String?>? resultData,
    super.key,
  }) : resultData = resultData ?? Rx(null);

  final RxString text;
  RxInt endIndex = 0.obs;

  RxBool isPlaying = false.obs;
  final player = AudioPlayer();

  final FlutterTts flutterTts = FlutterTts();

  String isShowElevenLab = "0";

  speak(String answer) async {
    text.value = answer;
    debugPrint("Initializing TTS...");
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    debugPrint("TTS Initialized. Speaking...");
    await flutterTts.speak(answer);
  }

  RxInt seconds = 0.obs;

  int totalLength = 0;

  showTextToSpeech(String askData) {
    if (isShowElevenLab == "1") {
      if (!isPlaying.value) {
        player.play();
        isPlaying.value = true;
      } else {
        if (player.playing) {
          player.pause();
          printAction("pause pause pause pause pause");
          isPlaying.value = false;
        }
      }
    } else {
      totalLength = askData.length;
      debugPrint("-=-=-totalLength $totalLength");
      if (!isPlaying.value) {
        isPlaying.value = true;
        speak(askData);
      } else {
        flutterTts.stop();
        isPlaying.value = false;
      }
      debugPrint("-=-=-totalLength $totalLength");
    }

    // update();
  }

  Rx<String?> resultData;

  RxBool isAudioReady = false.obs;

  setUpAudio() async {
    try {
      if (resultData.value == null) {
        var file = await Global.elevenLabSynthesSize(
          text: text.value.toString(),
          voiceId: Constants.elevenLabId,
        );
        if (file != null) {
          resultData = (file.path).obs;
        }
      }
      if (resultData.value != null) {
        // await AssetsAudioPlayer.newPlayer().open(Audio.file(resultData.path));
        await player.setFilePath(resultData.value!, preload: false);
        showTextToSpeech(text.value);
      }
    } on RequestCanceledException catch (e) {
      printAction("cancel ${e.message}");
    } catch (e) {
      isShowElevenLab = "0";
      showTextToSpeech(text.value);
    }
  }

  Timer? timer;

  @override
  State<TextToSpeechView> createState() => _TextToSpeechViewState();
}

StreamSubscription? sub;

class _TextToSpeechViewState extends State<TextToSpeechView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    widget.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.isPlaying.value) {
        widget.seconds.value++;
      }
    });

    sub = widget.player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (widget.isPlaying.value) {
          widget.isPlaying.value = false;
          debugPrint("TTS Initialized. playerStateStream...");
          if (Platform.isAndroid) {
            Get.back();
            return;
          } else {
            debugPrint("-=-=-totalLength ${widget.endIndex.value}");
            debugPrint("-=-=-totalLength ${widget.totalLength}");

            if (widget.endIndex.value == widget.totalLength) {
              Get.back();
              return;
            }
          }
        }

        sub?.cancel();
      } else if (state.processingState == ProcessingState.ready) {
        widget.isAudioReady.value = true;
      } else if (state.playing) {
        debugPrint("Audio Playing");
      } else {
        debugPrint("Audio Paused");
      }
    });

    widget.flutterTts.setCompletionHandler(() {
      widget.isPlaying.value = false;
      debugPrint("TTS Initialized. setCompletionHandler...");
      if (Platform.isAndroid) {
        Get.back();
      } else {
        debugPrint("-=-=-totalLength ${widget.endIndex.value}");
        debugPrint("-=-=-totalLength ${widget.totalLength}");

        if (widget.endIndex.value == widget.totalLength) {
          Get.back();
        }
      }
    });
    widget.flutterTts.setProgressHandler((text, start, end, word) {
      widget.endIndex.value = end;
    });

    widget.flutterTts.setStartHandler(() {
      widget.isPlaying.value = true;
    });

    widget.flutterTts.setCancelHandler(() {
      widget.isPlaying.value = false;
    });
    if (widget.isShowElevenLab == "1") {
      widget.setUpAudio();
    } else {
      widget.showTextToSpeech(widget.text.value);
    }

    super.initState();
  }

  @override
  void dispose() {
    widget.flutterTts.stop();
    widget.timer?.cancel();
    widget.player.pause();
    widget.player.dispose();
    ElevenLabsAPI.cancelRequests();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        debugPrint('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        debugPrint('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;

      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 80.px,
        width: 200.px,
        padding: EdgeInsets.all(8.px),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.changeOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.px)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: WaveformWidget(isPlaying: widget.isPlaying)),
                AppText(
                  utils.formatDuration(widget.seconds.value),
                  fontSize: 12.px,
                  fontFamily: FontFamily.helveticaBold,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(height: 8.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BGIcon(
                  icon: ImagePath.close,
                  padding: 10.px,
                  marginHorizontal: 6.px,
                  checkOnPress: () {
                    if (widget.isShowElevenLab == "1") {
                      widget.player.dispose();
                    } else {
                      widget.flutterTts.stop();
                    }
                    widget.isPlaying.value = false;
                    Get.back();

                    // Get.back();
                  },
                ),
                BGIcon(
                  icon:
                      (widget.isShowElevenLab == "1" && (widget.isAudioReady.value == false))
                          ? null
                          : widget.isPlaying.value
                          ? ImagePath.pause
                          : ImagePath.play,
                  padding: 7.px,
                  marginHorizontal: 6.px,
                  checkOnPress: () {
                    if (widget.isShowElevenLab == "1") {
                      if (widget.isAudioReady.value) {
                        widget.showTextToSpeech(widget.text.value);
                      }
                      //
                    } else {
                      if (widget.isPlaying.value) {
                        widget.flutterTts.stop();
                        widget.isPlaying.value = false;
                      } else {
                        widget.showTextToSpeech(
                          widget.text.substring(widget.endIndex.value, widget.text.value.length),
                        );
                      }
                    }
                  },
                  child: const CircularProgressIndicator(color: AppColors.black, strokeWidth: 2),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class WaveformWidget extends StatefulWidget {
  const WaveformWidget({required this.isPlaying, super.key});

  final RxBool? isPlaying;

  @override
  _WaveformWidgetState createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();
    if (widget.isPlaying?.value ?? false) {
    } else {
      _controller.stop();
      // widget.controller.update();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(20, (index) {
            double heightFactor =
                (widget.isPlaying?.value ?? false)
                    ? (1 + sin(_controller.value * 2 * pi * index / 2)) / 2
                    : 0.5;
            return Container(width: 2, height: 20 * heightFactor, color: AppColors.toolColor3);
          }),
        );
      },
    );
  }
}

class BGIcon extends StatelessWidget {
  final double? height;
  final double? width;
  final double? padding;
  final Color? color;
  final Color? iconColor;
  final String? icon;
  final double? marginHorizontal;
  final VoidCallback? checkOnPress;
  final Widget? child;

  const BGIcon({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.marginHorizontal,
    this.color,
    this.iconColor,
    this.icon,
    this.child,
    this.checkOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checkOnPress != null) {
          checkOnPress!();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal ?? 6.px),
        height: height ?? 32.px,
        width: width ?? 32.px,
        padding: EdgeInsets.all(padding ?? 7.px),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color ?? AppColors.grey),
        child:
            (icon != null)
                ? SvgPicture.asset(icon ?? "", color: iconColor ?? AppColors.black)
                : child ?? SizedBox(),
      ),
    );
  }
}

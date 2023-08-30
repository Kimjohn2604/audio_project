import 'dart:async';
import 'dart:math';
import 'package:app/route/name.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart' as path;
import 'package:app/component/colors.dart';
import 'package:app/component/storage_key.dart';
import 'package:app/component/style.dart';
import 'package:app/widget/appar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

late FlutterSoundRecorder _audioRecorder;

bool _isRecordingLongPress = false;
bool _isRecording = false;

String _recordedFilePath = "";
Codec codec = Codec.defaultCodec;

late Timer _recordingTimer;
int _elapsedSeconds = 0;
final LocalStorage storage = LocalStorage(StorageKey.username);
final LocalStorage storageSentence = LocalStorage(StorageKey.sentence);

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioRecorder.openRecorder();
  }

  Future<void> _checkPermissionAndStartRecording() async {
    if (await Permission.microphone.request().isGranted) {
      _startRecording();
    } else {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  Future<String> _getRecordedFilePath(String extension) async {
    /* Directory appDir = await getApplicationDocumentsDirectory(); */
    String folderPath = "/sdcard/Documents/";
    final random = Random();
    final fileName = "audio_${random.nextInt(10000)}.$extension";
    return path.join(folderPath, fileName);
  }

  Future<void> _startRecording() async {
    if (!_isRecording) {
      _recordedFilePath = await _getRecordedFilePath("wav");
      await _audioRecorder.startRecorder(
        toFile: _recordedFilePath,
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
        _isRecordingLongPress = true;
      });
      _startRecordingTimer();
      print(_recordedFilePath);
    }
  }

  Future<void> _stopRecording() async {
    if (_isRecording) {
      await _audioRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
        _isRecordingLongPress = false;
      });
      _stopRecordingTimer();
    }
  }

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedSeconds >= 30) {
        _stopRecording();
      }
      setState(() {
        _elapsedSeconds += 1;
      });
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer.cancel();
    setState(() {
      _elapsedSeconds = 0;
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Approutes.SUCCESS_SIGNIN, (route) => false);
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Sign in",
        leadingIcon: Icons.chevron_left,
        leadingTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "Please press “Record” button and say something",
                  style: AppStyle.headlineStyle1
                      .copyWith(color: Appcolor.mainBlackColor),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                "Listening",
                style: AppStyle.headlineStyle1,
              ),
              _isRecordingLongPress
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Appcolor.mainBlackColor,
                      size: 50,
                    )
                  : Container()
            ],
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(children: [
          GestureDetector(
            onLongPress: () {
              _checkPermissionAndStartRecording();
            },
            onLongPressUp: () {
              _stopRecording();
            },
            child: AvatarGlow(
              glowColor: Appcolor.backupColor,
              endRadius: 70.0,
              duration: const Duration(milliseconds: 1000),
              repeat: true,
              showTwoGlows: true,
              animate: _isRecordingLongPress,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: SvgPicture.asset(
                'assets/items/ic_mic.svg',
                height: 77,
              ),
            ),
          ),
          Text(
            "00 : ${_elapsedSeconds.toString().padLeft(2, '0')}",
            style:
                AppStyle.headlineStyle2.copyWith(color: Appcolor.backupColor),
          ),
        ]),
      ),
    );
  }
}

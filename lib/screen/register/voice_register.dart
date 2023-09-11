import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:app/component/storage_key.dart';
import 'package:app/route/name.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:path/path.dart' as path;
import 'package:app/component/colors.dart';
import 'package:app/component/style.dart';
import 'package:app/widget/appar.dart';
import 'package:app/widget/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

late FlutterSoundRecorder _audioRecorder;

bool _isRecordingLongPress = false;
bool _isRecording = false;

String _recordedFilePath = "";
Codec codec = Codec.defaultCodec;

late Timer _recordingTimer;
int _elapsedSeconds = 0;

NoiseReading? _latestReading;
StreamSubscription<NoiseReading>? _noiseSubscription;
NoiseMeter? _noiseMeter;

class _RegisterScreenState extends State<RegisterScreen> {
  final LocalStorage storage = LocalStorage(StorageKey.username);
  final LocalStorage storageSentence = LocalStorage(StorageKey.sentence);
  late final RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioRecorder.openRecorder();
    _noiseMeter = NoiseMeter(onError);
    recorderController = RecorderController();
  }

  void onError(Object error) {
    print(error);
    _isRecording = false;
  }

  Future<void> _checkPermissionAndStartRecording() async {
    if (await Permission.microphone.request().isGranted) {
      _startRecording();
    } else {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  Future<String> _getRecordedFilePath(String extension) async {
    /* / Directory appDir = await getApplicationDocumentsDirectory(); / */
    String folderPath = "/sdcard/Download/";
    final random = Random();
    String fileName = "audio_${random.nextInt(10000)}.$extension";
    return path.join(folderPath, fileName);
  }

  Future<void> _startRecording() async {
    _noiseSubscription = _noiseMeter?.noise.listen(onData);

    if (!_isRecording) {
      await recorderController.checkPermission();
      recorderController.record(path: await _getRecordedFilePath("wav"));
      _recordedFilePath = await _getRecordedFilePath(
          "wav"); //Hàm _getRecordedFilePath() trả về đường dẫn tới tệp ghi âm
      await _audioRecorder.startRecorder(
        toFile: _recordedFilePath,
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
        _isRecordingLongPress = true;
      });
      _startRecordingTimer();
    }
  }

  void onData(NoiseReading noiseReading) {
    if (kDebugMode) {
      print("alooo: " + noiseReading.toString());
    }
    setState(() {
      _latestReading = noiseReading;
      if (!_isRecording) _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    _noiseSubscription?.cancel();
    if (_isRecording) {
      await _audioRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
        _isRecordingLongPress = false;
      });
      _stopRecordingTimer();
    }
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
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
    Navigator.of(context).pushNamedAndRemoveUntil(
        Approutes.REGISTER_VALIDATION, (route) => false);
  }

  String _loadSentence() {
    String sentence = "Sentence 1 (i.e: Hanoi is the capital of Vietnam)";
    int? number = storageSentence.getItem(StorageKey.sentence);

    if (number == null) {
      storageSentence.setItem(StorageKey.sentence, 1);
      return sentence;
    }
    if (number == 2) {
      sentence =
          "Sentence 2 (i.e: Team, our manager came to the office this morning and will have a meeting our team this afternoon)";
    }
    if (number == 3) {
      sentence =
          "Sentence 3 (i.e: Manager, the printer is broken, we need to purchase a new one.)";
    }
    return sentence;
  }

  List<Widget> getContent() => <Widget>[
        AudioWaveforms(
            enableGesture: true,
            size: Size(MediaQuery.of(context).size.width, 200.0),
            recorderController: recorderController,
            waveStyle: const WaveStyle(
                extendWaveform: true,
                showMiddleLine: false,
                durationStyle: TextStyle(fontSize: 30)))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Register",
        leadingIcon: Icons.chevron_left,
        leadingTap: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Approutes.USER, (route) => false);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "Could you please press “Record” button and speak following sentense:",
              style: AppStyle.headlineStyle2
                  .copyWith(color: Appcolor.mainBlackColor),
              maxLines: 3,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Appcolor.backgroundcolor,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  children: [
                    detailedContent(context, text: _loadSentence()),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getContent()),
            )
          ],
        ),
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
              glowColor: Appcolor.mainColor,
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

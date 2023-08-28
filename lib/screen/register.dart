import 'dart:async';
import 'dart:math';
import 'package:app/route/name.dart';
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

bool _isLongPressing = false;
bool _isRecordingLongPress = false;
bool _isRecording = false;

String _recordedFilePath = "";
Codec codec = Codec.defaultCodec;

late Timer _recordingTimer;
int _elapsedSeconds = 0;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioRecorder.openRecorder().then((value) {
      print("Audio session opened: $value");
    });
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
    final fileName = 'audio_${random.nextInt(10000)}.$extension';
    return path.join(folderPath, fileName);
  }

  /*  String getExtension(Codec codec) {
    String extension = "aac";
    if (codec == Codec.aacADTS) extension = "aac";
    if (codec == Codec.aacMP4) extension = "aac";
    if (codec == Codec.amrNB) extension = "amr";
    if (codec == Codec.amrWB) extension = "amr";
    if (codec == Codec.pcm16WAV) extension = "wav";
    return extension;
  } */

  Future<void> _startRecording() async {
    if (!_isRecording) {
      //kiểm tra xem liệu ứng dụng có đang trong trạng thái ghi âm
      _recordedFilePath = await _getRecordedFilePath(
          "wav"); //Hàm _getRecordedFilePath() trả về đường dẫn tới tệp ghi âm
      await _audioRecorder.startRecorder(
          toFile: _recordedFilePath,
          /* codec: Codec.values.where((element) => element == codec).first, */
          codec: Codec.pcm16WAV);
      setState(() {
        _isRecording = true;
      });
      _startRecordingTimer();
      print(_isRecording);
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

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
  }

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Register",
        leadingIcon: Icons.chevron_left,
        leadingTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Could you please press “Record” button and speak following sentense:",
                style: AppStyle.headlineStyle2
                    .copyWith(color: Appcolor.mainBlackColor),
                maxLines: 2,
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Appcolor.backgroundcolor,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  children: [
                    detailedContent(context,
                        text:
                            "Sentence 1 (i.e: Hanoi is the capital of Vietnam)"),
                    /* detailedContent(context,
                        text:
                            "Sentence 2 (i.e: Team, our manager came to the office this morning and will have a meeting our team this afternoon)"),
                    detailedContent(context,
                        text:
                            "Sentence 3 (i.e: Manager, the printer is broken, we need to purchase a new one.)"), */
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onLongPress: () {
              setState(() {
                _isLongPressing = true;
                _isRecordingLongPress = true;
              });
              _checkPermissionAndStartRecording();
            },
            onLongPressUp: () {
              setState(() {
                _isLongPressing = false;
                _isRecordingLongPress = false;
              });
              _stopRecording();
              Navigator.of(context).pushNamed(Approutes.VALIDATION);
            },
            child: SvgPicture.asset(
              "assets/items/ic_mic.svg",
            ),
          ),
          Text(
            "00 : ${_elapsedSeconds.toString().padLeft(2, '0')}",
          ),
        ]),
      ),
    );
  }
}

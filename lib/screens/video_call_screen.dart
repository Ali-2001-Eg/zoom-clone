import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController _roomNameController;
  late TextEditingController _nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  _joinMeeting() {
    _jitsiMeetMethods.creatNewMeeting(
      roomName: '${_roomNameController.text} - meeting',
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      userName: _nameController.text,
    );
  }

  onAudioMuted(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  onVideoMuted(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  @override
  void initState() {
    _roomNameController = TextEditingController();
    _nameController = TextEditingController(
      text: _authMethods.currentUserData.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(
          height: 60,
          child: TextField(
            controller: _roomNameController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              hintText: 'Meeting ID',
              hintStyle: TextStyle(
                fontSize: 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextField(
            controller: _nameController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            cursorColor: buttonColor,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              hintText: 'Name',
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: _joinMeeting,
          child: const Text(
            'Join',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        MeetingOption(
          text: 'Mute Audio',
          isMuted: isAudioMuted,
          onChanged: onAudioMuted,
        ),
        MeetingOption(
          text: 'Mute Video',
          isMuted: isVideoMuted,
          onChanged: onVideoMuted,
        ),
      ]),
    );
  }
}

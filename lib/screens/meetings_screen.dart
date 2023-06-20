import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';

import '../widgets/home_meeting_button.dart';

class MeetingsScreen extends StatelessWidget {
  MeetingsScreen({super.key});

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  final String roomName = '';

  creatNewMeeting({required String roomName}) async {
    String initName = ' - meeting';
    _jitsiMeetMethods.creatNewMeeting(
      roomName: roomName + initName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  askForRoomName(BuildContext context, String roomName) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: const Text('Enter Room Name'),
        content: TextField(
          onChanged: (value) {
            roomName = value;
          },
          decoration: const InputDecoration(
            hintText: 'Room Name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              creatNewMeeting(roomName: roomName);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onTap: () {
                askForRoomName(context, roomName);
              },
              icon: Icons.video_call,
              text: 'New Meeting',
            ),
            HomeMeetingButton(
              onTap: () {
                Navigator.pushNamed(context, '/video-Call');
              },
              icon: Icons.add_box_rounded,
              text: 'Join Meeting',
            ),
            HomeMeetingButton(
              onTap: () {},
              icon: Icons.calendar_today_rounded,
              text: 'Schedule',
            ),
            HomeMeetingButton(
              onTap: () {},
              icon: Icons.screen_share_rounded,
              text: 'Share Screen',
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with just one click!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

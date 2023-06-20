import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void creatNewMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String userName = '',
  }) async {
    try {
      Map<FeatureFlag, Object> featureFlags = {
        FeatureFlag.isWelcomePageEnabled: false,
        FeatureFlag.resolution: '480',
        FeatureFlag.isMeetingPasswordEnabled: true,
        FeatureFlag.areSecurityOptionsEnabled: true,
      };

      String name;
      if (userName.isEmpty) {
        name = _authMethods.currentUserData.displayName!;
      } else {
        name = userName;
      }
      // Define meetings options here
      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomName,
        userDisplayName: name,
        userAvatarUrl: _authMethods.currentUserData.photoURL,
        userEmail: _authMethods.currentUserData.email,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        featureFlags: featureFlags,
      );

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}

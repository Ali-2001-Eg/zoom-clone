import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

class MeetingOption extends StatelessWidget {
  const MeetingOption({
    required this.text,
    required this.isMuted,
    required this.onChanged,
    super.key,
  });
  final String text;
  final bool isMuted;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Switch.adaptive(
            value: isMuted,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

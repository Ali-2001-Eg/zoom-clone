import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';
import 'package:zoom_clone/utils/colors.dart';

class HistoryMeetingsScreen extends StatelessWidget {
  const HistoryMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('No meetings yet', style: TextStyle(fontSize: 20)),
          );
        }

        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) {
            return Container(
              color: secondaryBackgroundColor,
              child: ListTile(
                title: Text(
                  'Room Name : ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                    'Joined at : ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}'),
              ),
            );
          },
        );
      },
    );
  }
}

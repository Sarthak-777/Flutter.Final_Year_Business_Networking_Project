import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final snap;
  const NotificationCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    print(snap);
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: Colors.grey.shade800),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  snap['message'],
                  style: TextStyle(color: Colors.grey[200]),
                )),
                Text(
                  DateFormat.yMd().format(
                    snap['date'].toDate(),
                  ),
                  // DateFormat.HOUR24().format(
                  //   widget.snap['date'].toDate(),
                  // ),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[200],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

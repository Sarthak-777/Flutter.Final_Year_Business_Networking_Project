import 'package:flutter/material.dart';

class ApplyJobsScreen extends StatefulWidget {
  const ApplyJobsScreen({super.key});

  @override
  State<ApplyJobsScreen> createState() => _ApplyJobsScreenState();
}

class _ApplyJobsScreenState extends State<ApplyJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Job"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

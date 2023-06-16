import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:email_validator/email_validator.dart';

class ResumeForm extends StatefulWidget {
  @override
  _ResumeFormState createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  final _formKey = GlobalKey<FormState>();
  String id = const Uuid().v1();

  // Declare variables to hold user inputs
  late String? _name;
  late String? _email;
  late int? _phone;
  late String? _education;
  late String? _workExperience;
  late String? _skills;

  @override
  void initState() {
    // TODO: implement initState
    var data = requestPermission();
    super.initState();
  }

  void requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    //PermissionStatus status1 = await Permission.accessMediaLocation.request();
    PermissionStatus status2 = await Permission.manageExternalStorage.request();
    print('status $status   -> $status2');
    if (status.isGranted && status2.isGranted) {
      print('granted');
    } else if (status.isPermanentlyDenied || status2.isPermanentlyDenied) {
      await openAppSettings();
    } else if (status.isDenied) {
      print('Permission Denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resume Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null; // No validation error
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length != 10) {
                    return 'Phone number should be 10 digits';
                  } else {
                    try {
                      _phone = int.parse(
                          value); // Convert the input value to an integer
                      return null; // No validation error
                    } catch (e) {
                      return 'Invalid phone number';
                    }
                  }
                },
                onSaved: (value) {},
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Education',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your education';
                  }
                  return null;
                },
                onSaved: (value) {
                  _education = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Work Experience',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your work experience';
                  }
                  return null;
                },
                onSaved: (value) {
                  _workExperience = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Add skills',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your skills';
                  }
                  return null;
                },
                onSaved: (value) {
                  _skills = value;
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Call the function to generate the resume
                      await generateResume();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all the fields'),
                        ),
                      );
                    }
                  },
                  child: Text('Generate Resume'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> generateResume() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(_name!,
                style: pw.TextStyle(
                    fontSize: 20.0, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10.0),
            pw.Text(_email!),
            pw.Text(_phone.toString()!),
            pw.SizedBox(height: 20.0),
            pw.Text('Education',
                style: pw.TextStyle(
                    fontSize: 18.0, fontWeight: pw.FontWeight.bold)),
            pw.Divider(),
            pw.Text(_education!),
            pw.SizedBox(height: 20.0),
            pw.Text('Work Experience',
                style: pw.TextStyle(
                    fontSize: 18.0, fontWeight: pw.FontWeight.bold)),
            pw.Divider(),
            pw.Text(_workExperience!),
            pw.SizedBox(height: 20.0),
            pw.Text('Skills',
                style: pw.TextStyle(
                    fontSize: 18.0, fontWeight: pw.FontWeight.bold)),
            pw.Divider(),
            pw.Text(_skills!),
          ],
        ),
      ),
    );

// Get the document directory path on the device
    final directory = await getApplicationDocumentsDirectory();
    final path = '/storage/emulated/0/Download/${id}.pdf';

// Save the PDF file to the device
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

// Show a message to the user that the resume has been generated and saved
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resume Generated'),
        content: Text('Your resume has been generated and saved to $path'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

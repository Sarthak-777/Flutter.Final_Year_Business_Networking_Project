import 'package:final_project_workconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ApplicantDetails extends StatelessWidget {
  var data;
  ApplicantDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
        appBar: AppBar(
          title: Text('Applicant Details'),
          backgroundColor: iconBool ? Colors.black : Colors.grey[200],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Applicant name: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(data['username'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Applicant email: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(data['email'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Applicant contact no: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(data['phone'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Applicant summary: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(data['summary'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.green[700],
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text("View Applicant CV",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

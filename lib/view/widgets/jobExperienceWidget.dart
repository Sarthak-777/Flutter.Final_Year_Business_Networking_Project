import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:flutter/material.dart';

class JobExperienceWidget extends StatelessWidget {
  String? uid;
  JobExperienceWidget({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: InkWell(
                onTap: () {},
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data.data()['experience'] == null) {
                          return Text('No Experience Added Yet!!!');
                        }
                        List experience = snapshot.data.data()['experience'];

                        return Column(
                          children: [
                            for (int i = 0; i < experience.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    color: Colors.blueGrey[800],
                                    height: 90,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  experience[i]['position'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: iconBool
                                                          ? Colors.grey[200]
                                                          : Colors.black),
                                                ),
                                                Text(
                                                  experience[i]['jobName'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: iconBool
                                                          ? Colors.grey[200]
                                                          : Colors.black),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          "${experience[i]['startYear']} - ${experience[i]['endYear']} ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: iconBool
                                                  ? Colors.grey[200]
                                                  : Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                        // Container(
                        //   color: iconBool ? Colors.blueGrey[800] : Colors.white,
                        //   height: 90,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       // const SizedBox(
                        //       //   width: 10,
                        //       // ),
                        //       Row(
                        //         children: [
                        //           Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Text(
                        //                 title,
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w700,
                        //                     color: iconBool
                        //                         ? Colors.grey[200]
                        //                         : Colors.black),
                        //               ),
                        //               Text(
                        //                 companyName,
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w700,
                        //                     color: iconBool
                        //                         ? Colors.grey[200]
                        //                         : Colors.black),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //       Text(
                        //         date,
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w500,
                        //             color: iconBool
                        //                 ? Colors.grey[200]
                        //                 : Colors.black),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      }
                    }))));
  }
}

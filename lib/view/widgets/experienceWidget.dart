import 'package:flutter/material.dart';

class ExperienceWidget extends StatelessWidget {
  String companyImage;
  String title;
  String companyName;
  String date;

  ExperienceWidget({
    this.companyName = '',
    this.title = '',
    this.companyImage = '',
    this.date = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
            onTap: () {},
            child: date == ''
                ? Container(
                    color: Colors.white,
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                        )
                      ],
                    ),
                  )
                : Container(
                    color: Colors.white,
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 35,
                                width: 35,
                                child: Image.asset(
                                  companyImage,
                                  fit: BoxFit.fitHeight,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  companyName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}

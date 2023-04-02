import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/controller/auth_controller.dart';
import 'package:final_project_workconnect/controller/home_controller.dart';
import 'package:final_project_workconnect/functions/toColor.dart';
import 'package:final_project_workconnect/view/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeedCard extends StatefulWidget {
  final snap;
  const FeedCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  bool isLiked = false;
  String commentsCount = '0';
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());

  handleLikeButton(uid, postId, likes) async {
    bool liked = await homeController.handleLikes(uid, postId, likes);
    setState(() {
      isLiked = liked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommentsLength();
  }

  Future<void> CommentsLength() async {
    String count = await homeController.commentsCount(widget.snap);
    print(count);
    setState(() {
      commentsCount = count;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.snap);
    var user = authController.userData;
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: iconBool ? Colors.black : Colors.grey,
                spreadRadius: 0,
                blurRadius: 5),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: widget.snap['color'] == ''
                ? iconBool
                    ? Colors.grey[800]
                    : Colors.white
                : toColor(widget.snap['color']),
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.snap['profilePic']),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                        ProfileScreen(uid: widget.snap['uid']));
                                  },
                                  child: Text(
                                    '${widget.snap['username']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: iconBool
                                          ? Colors.grey[200]
                                          : Colors.grey[800],
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd().format(
                                    widget.snap['datePosted'].toDate(),
                                  ),
                                  style: TextStyle(
                                      color: iconBool
                                          ? Colors.grey[500]
                                          : Colors.grey[700],
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_circle_outline_outlined,
                        color: iconBool ? Colors.grey[200] : Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['postUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => handleLikeButton(user['uid'],
                            widget.snap['postId'], widget.snap['likes']),
                        child: widget.snap['likes'].contains(user['uid'])
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(
                                Icons.favorite_outline,
                                color: iconBool
                                    ? Colors.grey[200]
                                    : Colors.grey[800],
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   ImageViewerPageRoute(
                            //       builder: (context) =>
                            //           CommentsScreen(snap: widget.snap)),
                            // ),
                          },
                          child: Icon(
                            Icons.comment_bank_outlined,
                            color:
                                iconBool ? Colors.grey[200] : Colors.grey[800],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.snap['likes'].length.toString()} likes',
                        style: TextStyle(
                          color: iconBool ? Colors.grey[200] : Colors.grey[800],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '$commentsCount comments',
                                style: TextStyle(
                                  color: iconBool
                                      ? Colors.grey[200]
                                      : Colors.grey[800],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Text(
                          '${widget.snap['username']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                iconBool ? Colors.grey[200] : Colors.grey[800],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.circle, size: 5),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.snap['description'],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: iconBool
                                    ? Colors.grey[200]
                                    : Colors.grey[800],
                                fontSize: 14)),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

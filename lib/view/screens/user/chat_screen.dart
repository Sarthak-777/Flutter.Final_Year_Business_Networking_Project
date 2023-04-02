import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/model/FirebaseHelper.dart';
import 'package:final_project_workconnect/model/chat_room_model.dart';
import 'package:final_project_workconnect/model/user.dart';
import 'package:final_project_workconnect/view/screens/user/chatroom_page.dart';
import 'package:final_project_workconnect/view/screens/user/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final MyUser? userModel;
  final User? firebaseUser;
  const ChatScreen(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chat App"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("chatrooms")
              .where("participants.${widget.userModel!.uid}", isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

                return ListView.builder(
                  itemCount: chatRoomSnapshot.docs.length,
                  itemBuilder: (context, index) {
                    ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                        chatRoomSnapshot.docs[index].data()
                            as Map<String, dynamic>);

                    Map<String, dynamic> participants =
                        chatRoomModel.participants!;

                    List<String> participantKeys = participants.keys.toList();
                    participantKeys.remove(widget.userModel!.uid);

                    return FutureBuilder(
                      future:
                          FirebaseHelper.getUserModelById(participantKeys[0]),
                      builder: (context, userData) {
                        if (userData.connectionState == ConnectionState.done) {
                          if (userData.data != null) {
                            MyUser targetUser = userData.data as MyUser;

                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ChatRoomPage(
                                      chatroom: chatRoomModel,
                                      firebaseUser: widget.firebaseUser,
                                      userModel: widget.userModel,
                                      targetUser: targetUser,
                                    );
                                  }),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    targetUser.profilePhoto.toString()),
                              ),
                              title: Text(targetUser.username.toString()),
                              subtitle: (chatRoomModel.lastMessage.toString() !=
                                      "")
                                  ? Text(chatRoomModel.lastMessage.toString())
                                  : Text(
                                      "Say hi to your new friend!",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text("No Chats"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPage(
                userModel: widget.userModel, firebaseUser: widget.firebaseUser);
          }));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}

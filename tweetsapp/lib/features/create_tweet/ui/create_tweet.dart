import 'package:flutter/material.dart';

class CreateTweet extends StatefulWidget {
  const CreateTweet({super.key});

  @override
  State<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  TextEditingController tweetContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Text("Create Tweet"),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: tweetContentController,
              maxLines: 30,
              minLines: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "What's on your mind"),
            )
          ],
        ),
      ),
    );
  }
}

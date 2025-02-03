import 'package:flutter/material.dart';
import 'package:tweetsapp/design/app_widgets.dart';
import 'package:tweetsapp/features/create_tweet/ui/create_tweet.dart';

class TweetsScreen extends StatefulWidget {
  const TweetsScreen({super.key});

  @override
  State<TweetsScreen> createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTweet(),
              ));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        child: Column(
          children: [
            Center(
              child: AppLogo(),
            ),
          ],
        ),
      ),
    );
  }
}

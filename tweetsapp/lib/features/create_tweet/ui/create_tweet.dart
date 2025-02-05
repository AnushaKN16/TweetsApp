import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweetsapp/features/create_tweet/bloc/create_tweet_bloc.dart';
import 'package:tweetsapp/features/create_tweet/bloc/create_tweet_state.dart';

class CreateTweet extends StatefulWidget {
  const CreateTweet({super.key});

  @override
  State<CreateTweet> createState() => _CreateTweetState();
}

class _CreateTweetState extends State<CreateTweet> {
  TextEditingController tweetContentController = TextEditingController();
  CreateTweetBloc createTweetBloc = CreateTweetBloc();
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: createTweetBloc,
        listener: (context, state) {
          if (state is CreateTweetLoadingState) {
            loader = true;
          } else if (state is CreateTweetSuccessState) {
            loader = false;
            Navigator.pop(context);
          } else if (state is CreateTweetErrorState) {
            loader = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Something went wrong")));
          }
        },
        buildWhen: (previous, current) => current is! CreateTweetActionState,
        listenWhen: (previous, current) => current is CreateTweetActionState,
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Create Tweet"),
                    Spacer(),
                    TextButton(onPressed: () {}, child: Text("POST"))
                  ],
                ),
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
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tweetsapp/design/app_widgets.dart';
import 'package:tweetsapp/features/create_tweet/ui/create_tweet.dart';
import 'package:tweetsapp/features/tweet/bloc/tweet_bloc.dart';
import 'package:tweetsapp/features/tweet/bloc/tweet_event.dart';
import 'package:tweetsapp/features/tweet/bloc/tweet_state.dart';

class TweetsScreen extends StatefulWidget {
  const TweetsScreen({super.key});

  @override
  State<TweetsScreen> createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  TweetsBloc tweetsBloc = TweetsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tweetsBloc.add(TweetInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTweet(
                    tweetBloc: tweetsBloc,
                  ),
                ));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BlocConsumer<TweetsBloc, TweetState>(
          bloc: tweetsBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case TweetsSuccessState:
                final successState = state as TweetsSuccessState;
                return Container(
                  child: Column(
                    children: [
                      Center(
                        child: AppLogo(),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Text(successState.tweets[index].tweet.content),
                                Row(
                                  children: [
                                    Text(successState
                                        .tweets[index].admin.firstName),
                                    Text(DateFormat('dd MMMM yyyy hh:mm a')
                                        .format(successState
                                            .tweets[index].tweet.createdAt)),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: successState.tweets.length,
                      )
                    ],
                  ),
                );
              case TweetsLoadingState:
                return CircularProgressIndicator();

              default:
                return Text("No tweets to show");
            }
          },
        ));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lovelovelove/Data%20Layer/Models/user_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestScreen extends StatefulWidget {
  User user;
   TestScreen({super.key, required this.user});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
    late final WebSocketChannel channel;

    @override
  void initState() {
   channel = IOWebSocketChannel.connect( 
      Uri.parse('wss://6ebc-2601-2c6-500-16f0-f98e-16e3-2b1-5ab6.ngrok-free.app/ws/rewards/${widget.user.altid}/'),
      );
    super.initState();
  }

@override
  void dispose() {
        channel.sink.close();
// TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           StreamBuilder(stream: channel.stream, 
                       builder: (context, snapshot){
                        if(snapshot.hasError){
                          return Text('Error:${snapshot.error}',style: TextStyle(color: Colors.white));
                        }
                        if(snapshot.hasData){
                          print('this thing has some data in it');
                          try {
                              final data = jsonDecode(snapshot.data.toString());
                               final actionData = data['data']['action_data'];
                              if(actionData!=null){
                              for (var action in actionData){
                                final altrueAction = action['altrue_action'];
                                final requirement = altrueAction['requirement'];
                                final pointsAwarded = altrueAction['points_awarded'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        shape:  RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                          ),
                                           margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.height - 250,
                                            right: 20,
                                            left: 20),
                                        
                                        action: SnackBarAction(label: 'Go Check it out', onPressed: ()=>context.go('/userActionScreen')),
                                        content: Text(
                                          'Action: ${requirement.toString()}\nPoints Awarded: ${pointsAwarded.toString()}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 6),
                                      ));
                                      return Text(actionData.toString());
                              }
                              return Text(actionData.toString());
                            }
                              
                            return Text(data.toString());
                             
                             
                              
                              
                            } catch (e) {
                              print('Error decoding data: $e');
                              return const Text('Error decoding data');
                            }
                        }
                        return const Text('Waiting For Data',style: TextStyle(color: Colors.white),);
                       }),
                       ElevatedButton(
              onPressed: () {
                // Send a test message
                channel.sink.add(jsonEncode({'action': 'The Test Action Is Good'}));
              },
              child: Text('Send Test Message'),
            ),
        ],
      )
      ,),
    );
  }
}
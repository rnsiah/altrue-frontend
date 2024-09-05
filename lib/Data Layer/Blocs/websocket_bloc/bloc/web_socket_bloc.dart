import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'web_socket_event.dart';
part 'web_socket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  WebSocketChannel? _channel;
  late final StreamSubscription _channelSubscription;


  WebSocketBloc() : super(WebSocketInitial()) {
    on<WebsocketConnect>(_onWebsocketConnect);
    on<WebsocketDisconnect>(_onWebsocketDisconnect);
    on<WebsocketMessageReceived>(_onWebSocketMessageReceived);
  }

  void _onWebsocketConnect(WebsocketConnect event, Emitter<WebSocketState> emit) {
  _channel = WebSocketChannel.connect(Uri.parse(event.url));
  _channelSubscription = _channel!.stream.listen(
    (message) {
      print({'theMessage coming in:': message});
      
      // Decode the JSON string into a Map
      try {
        final parsedMessage = json.decode(message) as Map<String, dynamic>;
        add(WebsocketMessageReceived(message: parsedMessage));
      } catch (e) {
        emit(WebsocketError(error: "Failed to decode message: $e"));
      }
    },
    onError: (error) {
      emit(WebsocketError(error: error.toString()));
    },
    onDone: () {
      emit(WebsocketDisconnected());
    },
  );
  emit(WebsocketConnected());
}

  void _onWebsocketDisconnect(WebsocketDisconnect event, Emitter<WebSocketState> emit) {
    _channelSubscription.cancel();
    _channel?.sink.close();
    emit(WebsocketDisconnected());
  }
  void _onWebSocketMessageReceived(WebsocketMessageReceived event, Emitter<WebSocketState> emit) {
    final messageData = event.message;
    print(event.message);

    // Extracting the type and message data from the WebSocket message
    final String? type = messageData['type'];
    final String? message = messageData['message'];
    final Map<String, dynamic>? data = messageData['data'];

    // Handling different types of WebSocket messages
    switch (type) {
      case 'reward_update':
        if (data != null) {
          final String? actionType = data['type'];
          if (actionType == 'send_reward_update') {
            final List<dynamic>? actionData = data['action_data'];
            if (actionData != null && actionData.isNotEmpty) {
              final Map<String, dynamic> altrueAction = actionData[0]['altrue_action'];
              final String requirement = altrueAction['requirement'] ?? 'No requirement specified';
              final int pointsAwarded = altrueAction['points_awarded'] ?? 0;

              emit(WebsocketShowSnackbar(
                message: '$requirement, you\'ve been awarded $pointsAwarded points.',
                color: Colors.green,
              ));
            } else {
              emit(WebsocketShowSnackbar(
                message: 'No action data available for reward update.',
                color: Colors.orange,
              ));
            }
          }
        }
        break;

      case 'welcome_message':
        emit(WebsocketShowSnackbar(
          message: '$message - ${data?['info']}',
          color: Colors.blue,
        ));
        break;

      case 'received_data':
        emit(WebsocketShowSnackbar(
          message: '$message - ${data?['action']}',
          color: Colors.grey,
        ));
        break;

      default:
        emit(WebsocketError(error: 'Unknown message type: $type'));
    }
  }

  

}

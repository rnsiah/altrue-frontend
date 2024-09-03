import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
 late WebSocketChannel _channel;
  StreamSubscription? _channelSubscription;


  WebsocketBloc() : super(WebsocketInitial()) {
   on<WebsocketConnect>(_onWebsocketConnect);
    on<WebsocketDisconnect>(_onWebsocketDisconnect);
    on<WebsocketMessageReceived>(_onWebSocketMessageReceived);
  }


   void _onWebsocketConnect(WebsocketConnect event, Emitter<WebsocketState> emit) {
    // Establish the WebSocket connection
    _channel = WebSocketChannel.connect(Uri.parse(event.url));
    _channelSubscription = _channel.stream.listen(
      (message) {
        dynamic themessage = {'the message':message
        };
        print(themessage);
        add(WebsocketMessageReceived(message: themessage));
      },
      onError: (error) {
        emit(WebSocketError(error: error.toString()));
      },
      onDone: () {
        emit(WebSocketDisconnected());
      },
    );
    emit(WebSocketConnected());
  }

  void _onWebsocketDisconnect(WebsocketDisconnect event, Emitter<WebsocketState> emit) {
    _channelSubscription?.cancel();
    _channel.sink.close();
    emit(WebSocketDisconnected());
  }

  void _onWebSocketMessageReceived(WebsocketMessageReceived event, Emitter<WebsocketState> emit) {
    // Handle incoming WebSocket messages
    final messageData = event.message;
    final String messageType = messageData['type'] ?? 'unknown';
    final String message = messageData['message'] ?? '';
    final Map<String, dynamic>? data = messageData['data'];
    
    switch (messageType) {
    case 'reward_update':
      // Handle reward update type
      final String? actionType = data?['type']; // Extract the action type within the data
      if (actionType == 'send_reward_update') {
        // Specific handling for send_reward_update action
        emit(WebsocketShowSnackbar(
          message: {
            'the message': message,
            'points_awarded': data?['action_data']?[0]['altrue_action']['points_awarded'] ?? 0,
          },
        ));
      } else {
        // Handle other action types within reward_update if needed
        print('Unknown action type: $actionType');
      }
      break;

       case 'welcome_message':
      // Handle welcome message type
      emit(WebsocketShowSnackbar(
        message: {
          'the message': message,
          'extra_info': data?['I am the one'], // Extract any additional data if needed
        },
      ));
      break;

    }


    emit(WebsocketShowSnackbar(message: messageData));
  }

  @override
  Future<void> close() {
    _channelSubscription?.cancel();
    _channel.sink.close();
    return super.close();
  }
}

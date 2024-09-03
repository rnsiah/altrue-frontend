part of 'websocket_bloc.dart';

class WebsocketState extends Equatable {
  const WebsocketState();
  
  @override
  List<Object> get props => [];
}

class WebsocketInitial extends WebsocketState {}

class WebSocketConnected extends WebsocketState {}

class WebSocketDisconnected extends WebsocketState {}

class WebSocketMessage extends WebsocketState {
  final Map<String, dynamic> message;
  const WebSocketMessage({required this.message});
}

class WebSocketError extends WebsocketState {
  final String error;
 const WebSocketError({required this.error});
}

class WebsocketShowSnackbar extends WebsocketState {
  final Map<String, dynamic> message;

  const WebsocketShowSnackbar({required this.message});

  @override
  List<Object> get props => [message];
  
}
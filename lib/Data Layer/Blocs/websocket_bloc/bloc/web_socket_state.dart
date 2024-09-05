part of 'web_socket_bloc.dart';

class WebSocketState extends Equatable {
  const WebSocketState();
  
  @override
  List<Object> get props => [];
}

class WebSocketInitial extends WebSocketState {}

class WebsocketConnected extends WebSocketState {}

class WebsocketDisconnected extends WebSocketState {}

class WebsocketError extends WebSocketState {
  final String error;

  WebsocketError({required this.error});

  @override
  List<Object> get props => [error];
}

class WebsocketShowSnackbar extends WebSocketState {
   final String message;
  final Color color;

  WebsocketShowSnackbar({required this.message, required this.color});

  @override
  List<Object> get props => [message, color];
}
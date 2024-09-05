part of 'web_socket_bloc.dart';

class WebSocketEvent extends Equatable {
  const WebSocketEvent();

  @override
  List<Object> get props => [];
}
class WebsocketConnect extends WebSocketEvent {
  final String url;

  WebsocketConnect({required this.url});

  @override
  List<Object> get props => [url];
}

class WebsocketDisconnect extends WebSocketEvent {}

class WebsocketMessageReceived extends WebSocketEvent {
  final Map<String, dynamic> message;

  WebsocketMessageReceived({required this.message});

  @override
  List<Object> get props => [message];
}
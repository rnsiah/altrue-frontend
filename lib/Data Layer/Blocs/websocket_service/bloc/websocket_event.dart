part of 'websocket_bloc.dart';

class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object> get props => [];
}

class WebsocketConnect extends WebsocketEvent{
  final String url;
  const WebsocketConnect({required this.url});
}

class WebsocketMessageReceived extends WebsocketEvent{
  final Map<String, dynamic> message;
  const WebsocketMessageReceived({required this.message});

}

class WebsocketDisconnect extends WebsocketEvent{
  
}
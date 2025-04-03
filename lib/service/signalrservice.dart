import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalRService {
  static final SignalRService _instance = SignalRService._internal();
  factory SignalRService() => _instance;

  late HubConnection _hubConnection;

  SignalRService._internal();

  Future<void> initializeConnection(String connectionUrl) async {
    _hubConnection = HubConnectionBuilder().withUrl(connectionUrl).build();

    try {
      await _hubConnection.start();
      print("SignalR Connected!");
    } catch (error) {
      print("SignalR connection error: $error");
    }
  }

  void addListener(String methodName, Function(List<dynamic>?) callback) {
    _hubConnection.on(methodName, callback);
  }

  Future<void> invokeMethod(String method, Map<String, dynamic> message) async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.invoke(method, args: [message]);
    } else {
      print("SignalR is not connected");
    }
  }
}

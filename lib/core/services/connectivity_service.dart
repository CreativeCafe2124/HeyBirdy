import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectionStatus {
  connected,
  disconnected,
}

class ConnectivityService {
  Stream<ConnectionStatus> get connectivityStream {
    return Connectivity().onConnectivityChanged.map((connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return ConnectionStatus.disconnected;
      } else {
        return ConnectionStatus.connected;
      }
    });
  }

  Future<ConnectionStatus> checkInitialConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return ConnectionStatus.disconnected;
    } else {
      return ConnectionStatus.connected;
    }
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.connectivityStream;
});
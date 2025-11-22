import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectionStatus {
  connected,
  disconnected,
}

class ConnectivityService {
  Stream<ConnectionStatus> get connectivityStream {
    return Connectivity().onConnectivityChanged.map((connectivityResult) {
      if (kIsWeb) {
        return ConnectionStatus.connected;
      }
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return ConnectionStatus.disconnected;
      } else {
        return ConnectionStatus.connected;
      }
    });
  }

  Future<ConnectionStatus> checkInitialConnection() async {
    if (kIsWeb) {
      return ConnectionStatus.connected;
    }
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.none)
        ? ConnectionStatus.disconnected
        : ConnectionStatus.connected;
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) {
  final connectivityService = ref.watch(connectivityServiceProvider);
  return connectivityService.connectivityStream;
});
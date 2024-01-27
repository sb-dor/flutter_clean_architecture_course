import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  const NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    var data = await _connectivity.checkConnectivity();

    return data == ConnectivityResult.none ||
            data == ConnectivityResult.bluetooth ||
            data == ConnectivityResult.other
        ? false
        : true;
  }
}

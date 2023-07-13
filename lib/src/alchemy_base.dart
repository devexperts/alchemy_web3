import 'package:alchemy_web3/src/client/rpc_http_client.dart';
import 'package:alchemy_web3/src/client/rpc_ws_client.dart';

import 'api/api.dart' as api;

class Alchemy {
  // SINGLETON
  static final Alchemy _singleton = Alchemy._internal();

  // FACTORY
  factory Alchemy() => _singleton;

  // VARIABLES
  late RpcWsClient _wsClient;
  late RpcHttpClient _httpClient;

  // APIs
  late api.EthAPI eth;
  late api.PolygonAPI polygon;
  late api.ArbitrumAPI arbitrum;
  late api.OptimismAPI optimism;
  late api.EnhancedAPI enhanced;
  late api.ERC20TokenAPI erc20;

  // CONSTRUCTOR
  Alchemy._internal() {
    // CLIENTS
    _httpClient = RpcHttpClient();
    _wsClient = RpcWsClient();

    // ENHANCED API
    enhanced = api.EnhancedAPI();
    enhanced.setHttpClient(_httpClient);
    enhanced.setWsClient(_wsClient);

    // ETH API
    eth = api.EthAPI();
    eth.setClient(_wsClient);
    // POLYGON API
    polygon = api.PolygonAPI();
    polygon.setClient(_wsClient);
    // ARBITRUM API
    arbitrum = api.ArbitrumAPI();
    arbitrum.setClient(_wsClient);
    // OPTIMISM API
    optimism = api.OptimismAPI();
    optimism.setClient(_wsClient);
    // ERC20 API
    erc20 = api.ERC20TokenAPI();
    erc20.setClient(_wsClient);
  }

  void init({
    required String httpRpcUrl,
    required String wsRpcUrl,
    double? jsonRPCVersion,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool verbose = true,
  }) {
    // HTTP
    _httpClient.init(
      url: httpRpcUrl,
      jsonRPCVersion: jsonRPCVersion,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      verbose: verbose,
    );

    // WEB SOCKET
    _wsClient.init(
      url: wsRpcUrl,
      verbose: verbose,
    );
  }

  Future<void> start() async {
    await _wsClient.start();
  }

  Future<void> stop() async {
    await _wsClient.stop();
  }

  Future<void> restart() async {
    await _wsClient.restart();
  }
}

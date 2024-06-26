import 'package:alchemy_web3/alchemy_web3.dart';
import 'package:either_dart/either.dart';

/// class to make custom api calls
/// useful in case when the alchemy library is not providing the required api
class CustomApi {
  late RpcWsClient wsClient;
  late RpcHttpClient httpClient;

  void setWsClient(RpcWsClient wsClient) {
    this.wsClient = wsClient;
  }

  void setHttpClient(RpcHttpClient httpClient) {
    this.httpClient = httpClient;
  }

  Future<Either<RPCErrorData, dynamic>> wsRequest({
    required String method,
    required List<dynamic> params,
  }) async {
    final result = await wsClient.request(method: method, params: params);

    return result.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }

  Future<Either<RpcResponse, dynamic>> httpRequest({
    required String method,
    required HTTPMethod httpMethod,
    Map<String, dynamic> parameters = const {},
    List<dynamic> bodyParameters = const [],
  }) async {
    final result = await httpClient.request(
      endpoint: method,
      method: httpMethod,
      queryParameters: parameters,
      bodyParameters: bodyParameters,
    );

    return result.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }
}

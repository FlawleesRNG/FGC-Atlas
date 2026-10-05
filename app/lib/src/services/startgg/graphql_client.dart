import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class StartGGGraphQLClient {
  StartGGGraphQLClient({
    required this.apiToken,
    http.Client? httpClient,
    Uri? endpoint,
    this.timeout = const Duration(seconds: 20),
  }) : _httpClient = httpClient ?? http.Client(),
       endpoint = endpoint ?? officialEndpoint;

  static final officialEndpoint = Uri.parse('https://api.start.gg/gql/alpha');

  final String apiToken;
  final Uri endpoint;
  final Duration timeout;
  final http.Client _httpClient;

  Future<Map<String, dynamic>> query(
    String query, {
    String? operationName,
    Map<String, dynamic>? variables,
  }) async {
    if (apiToken.trim().isEmpty) {
      throw const StartGGInvalidTokenException('API token n\u00E3o informado.');
    }

    final response = await _post(query, operationName, variables);

    if (response.statusCode == HttpStatus.unauthorized ||
        response.statusCode == HttpStatus.forbidden) {
      throw StartGGInvalidTokenException(
        'Token inv\u00E1lido ou sem permiss\u00E3o. Status ${response.statusCode}.',
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StartGGHttpException(
        response.statusCode,
        'Erro HTTP ${response.statusCode} ao chamar a API Start.gg.',
      );
    }

    final body = _decodeBody(response.body);
    final errors = body['errors'];
    if (errors is List && errors.isNotEmpty) {
      throw StartGGGraphQLException(errors);
    }

    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const StartGGGraphQLException([
        {'message': 'Resposta GraphQL sem campo data.'},
      ]);
    }

    return data;
  }

  Future<http.Response> _post(
    String query,
    String? operationName,
    Map<String, dynamic>? variables,
  ) async {
    try {
      return await _httpClient
          .post(
            endpoint,
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $apiToken',
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            },
            body: jsonEncode({
              'query': query,
              'operationName': ?operationName,
              'variables': ?variables,
            }),
          )
          .timeout(timeout);
    } on TimeoutException catch (error) {
      throw StartGGTimeoutException('Timeout ao chamar a API Start.gg.', error);
    } on SocketException catch (error) {
      throw StartGGConnectionException(
        'Erro de conex\u00E3o ao chamar a API Start.gg.',
        error,
      );
    } on http.ClientException catch (error) {
      throw StartGGConnectionException(
        'Erro no cliente HTTP ao chamar a API Start.gg.',
        error,
      );
    }
  }

  Map<String, dynamic> _decodeBody(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } on FormatException catch (error) {
      throw StartGGConnectionException(
        'Resposta inv\u00E1lida da API Start.gg.',
        error,
      );
    }

    throw const StartGGConnectionException(
      'Resposta inesperada da API Start.gg.',
    );
  }

  void close() => _httpClient.close();
}

sealed class StartGGException implements Exception {
  const StartGGException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() {
    if (cause == null) {
      return '$runtimeType: $message';
    }

    return '$runtimeType: $message ($cause)';
  }
}

class StartGGInvalidTokenException extends StartGGException {
  const StartGGInvalidTokenException(super.message, [super.cause]);
}

class StartGGTimeoutException extends StartGGException {
  const StartGGTimeoutException(super.message, [super.cause]);
}

class StartGGConnectionException extends StartGGException {
  const StartGGConnectionException(super.message, [super.cause]);
}

class StartGGHttpException extends StartGGException {
  const StartGGHttpException(this.statusCode, super.message, [super.cause]);

  final int statusCode;
}

class StartGGGraphQLException extends StartGGException {
  const StartGGGraphQLException(this.errors)
    : super('Erro GraphQL retornado pela API Start.gg.');

  final List<Object?> errors;

  @override
  String toString() => '$runtimeType: $message $errors';
}

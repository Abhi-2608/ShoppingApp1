import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lane_dane/data/remote/network/base.api.service.dart';
import 'package:lane_dane/errors/request_error.dart';
import 'package:lane_dane/errors/server_error.dart';
import 'package:lane_dane/errors/unauthorized_error.dart';
import 'package:lane_dane/main.dart';
import 'package:lane_dane/repository/auth_repo/auth_local.dart';

class NetworkApiService {
  late final String host;
  late final Map<String, dynamic> defaultQuery;
  late final Map<String, dynamic> defaultBody;
  late final Map<String, String> defaultHeader;
  late final bool defaultToHTTPS;

  NetworkApiService({
    String? host,
    Map<String, dynamic>? defaultQuery,
    Map<String, dynamic>? defaultBody,
    Map<String, String>? defaultHeader,
    bool? defaultToHTTPS,
  }) {
    this.host = host ?? BaseApiService.kBaseUrl;
    this.defaultQuery = defaultQuery ?? {};
    this.defaultBody = defaultBody ?? {};
    this.defaultHeader = defaultHeader ??
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthLocal.getToken()} ',
        };
    this.defaultToHTTPS = defaultToHTTPS ?? BaseApiService.defaultToHttps;
  }

  ///
  void responseStatusChecker(http.Response response) {
    int statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return;
    }
    if (statusCode >= 500) {
      throw ServerError(
        message: 'An internal server error occurred',
        response: response,
      );
    }
    if (statusCode == 401) {
      throw UnauthorizedError(
        message: 'The user is not authorized to make this request',
        response: response,
      );
    }
    if (statusCode == 403) {
      throw UnauthorizedError(
        message: 'User is forbidden from accessing this resource',
        response: response,
      );
    }
    if (statusCode >= 404 && statusCode <= 500) {
      throw RequestError(
        message: 'The requested resource is unavailable at the moment',
        response: response,
      );
    }
  }

  ///
  Future<dynamic> get(
    String resource, {
    Map<String, dynamic>? query,
    Map<String, String>? header,
    bool includeDefaultQuery = true,
    bool includeDefaultHeader = true,
    bool? https,
  }) async {
    // Create final query from default query and queries passed in the argument
    Map<String, dynamic> finalQuery = Map.from(query ?? {})
      ..addAll(includeDefaultQuery ? defaultQuery : {});
    // Create final header from default header and headers passed in the argument
    Map<String, String> finalHeader = Map.from(header ?? {})
      ..addAll(includeDefaultHeader ? defaultHeader : {});
    https = https ?? defaultToHTTPS;
    late Uri targetUri;

    //
    try {
      targetUri = https
          ? Uri.https(host, resource, finalQuery)
          : Uri.http(host, resource, finalQuery);
      talker.info(
          '@NetworkApiService : get() : Making a [GET] request to $targetUri');

      http.Response response = await http.get(
        targetUri,
        headers: finalHeader,
      );

      responseStatusChecker(response);

      dynamic body = json.decode(response.body);
      return body;
    } catch (err) {
      talker.error(
          '@NetworkApiService : get() : Error encountered while making [GET] request to host: $host, and resource: $resource and targetUri $targetUri');
      talker.error(
          '@NetworkApiService : get() : Query sent to resource: $finalQuery');
      talker.error(
          '@NetworkApiService : get() : Headers sent to resource: $finalHeader');
      rethrow;
    }
  }

  ///
  Future<dynamic> post(
    String resource, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Map<String, String>? header,
    bool includeDefaultBody = true,
    bool includeDefaultQuery = true,
    bool includeDefaultHeader = true,
    bool? https,
  }) async {
    // Create final body from default body and body passed in the argument
    Map<String, dynamic> finalBody = Map.from(body ?? {})
      ..addAll(includeDefaultBody ? defaultBody : {});
    // Create final query from default query and queries passed in the argument
    Map<String, dynamic> finalQuery = Map.from(query ?? {})
      ..addAll(includeDefaultQuery ? defaultQuery : {});
    // Create final header from default header and headers passed in the argument
    Map<String, String> finalHeader = Map.from(header ?? {})
      ..addAll(includeDefaultHeader ? defaultHeader : {});
    https = https ?? defaultToHTTPS;
    Uri? targetUri;

    //
    try {
      talker.info(
          "@NetworkApiService : post() : in Post request with https set to $https, so it will QueryStgin: $finalQuery");

      String queryString = finalQuery.entries
          .map((entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
          .join('&');

      talker.info(
          "@NetworkApiService : post() : in Post request with https set to $https, so it will QueryStgin: $queryString");
      targetUri = https
          ? Uri.https(host, resource, finalQuery)
          : Uri.parse('$host$resource?$queryString');

      talker.info(
          '@NetworkApiService : post() : Making a [POST] request to $targetUri');
      talker.info('@NetworkApiService : post() : Request Body: $finalBody');

      http.Response response = await http.post(
        targetUri,
        headers: finalHeader,
        body: json.encode(finalBody),
      );

      responseStatusChecker(response);

      dynamic body = json.decode(response.body);
      talker.debug("@NetworkApiService : post() : Response Body: $body");
      return body['success'];
      //
    } catch (err) {
      talker.error(
          '@NetworkApiService : post() : Error encountered while making [POST] request to host: $host, and resource: $resource error: ${err.toString()}');
      talker.error(
          '@NetworkApiService : post() : Body sent to resource: $finalBody');

      talker.error('@NetworkApiService : post() :targetUri: $targetUri');
      talker.error(
          '@NetworkApiService : post() : Query sent to resource: $finalQuery');
      talker.error(
          '@NetworkApiService : post() : Headers sent to resource: $finalHeader');
      rethrow;
    }
  }
}

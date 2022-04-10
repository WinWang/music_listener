// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://music.163.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MultiPlayListWrap> getNeteasePlayList(
      {options,
      category = "全部",
      order = "hot",
      offset = 0,
      limit = 30,
      total = true}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'category': category,
      'order': order,
      'offset': offset,
      'limit': limit,
      'total': total
    };
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _result = await _dio.fetch<Map<String, dynamic>>(newOptions.copyWith(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        baseUrl: baseUrl ?? _dio.options.baseUrl,
        queryParameters: queryParameters,
        path: '/weapi/playlist/list')
      ..data = _data);
    final value = MultiPlayListWrap.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SinglePlayListWrap> getPlayList(id,
      {options, offset = 0, limit = 1000, total = true, token = ""}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'id': id,
      'offset': offset,
      'limit': limit,
      'total': total,
      'csrf_token': token
    };
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _result = await _dio.fetch<Map<String, dynamic>>(newOptions.copyWith(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        baseUrl: baseUrl ?? _dio.options.baseUrl,
        queryParameters: queryParameters,
        path: '/weapi/v3/playlist/detail')
      ..data = _data);
    final value = SinglePlayListWrap.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SongDetailWrap> getSongList(c, ids, {options}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'c': c, 'ids': ids};
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _result = await _dio.fetch<Map<String, dynamic>>(newOptions.copyWith(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        baseUrl: baseUrl ?? _dio.options.baseUrl,
        queryParameters: queryParameters,
        path: '/weapi/v3/song/detail')
      ..data = _data);
    final value = SongDetailWrap.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SongUrlListWrap> getSongUrl(ids, {br = 999000, options}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'ids': ids, 'br': br};
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _result = await _dio.fetch<Map<String, dynamic>>(newOptions.copyWith(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        baseUrl: baseUrl ?? _dio.options.baseUrl,
        queryParameters: queryParameters,
        path: 'https://interface3.music.163.com/eapi/song/enhance/player/url')
      ..data = _data);
    final value = SongUrlListWrap.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SongUrlListWrap> getSongUrlV1(ids,
      {level = "standard", encodeType = "aac", options}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'ids': ids, 'level': level, 'encodeType': encodeType};
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _result = await _dio.fetch<Map<String, dynamic>>(newOptions.copyWith(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        baseUrl: baseUrl ?? _dio.options.baseUrl,
        queryParameters: queryParameters,
        path: '/weapi/song/enhance/player/url/v1')
      ..data = _data);
    final value = SongUrlListWrap.fromJson(_result.data!);
    return value;
  }

  RequestOptions newRequestOptions(Options? options) {
    if (options is RequestOptions) {
      return options as RequestOptions;
    }
    if (options == null) {
      return RequestOptions(path: '');
    }
    return RequestOptions(
      method: options.method,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      extra: options.extra,
      headers: options.headers,
      responseType: options.responseType,
      contentType: options.contentType.toString(),
      validateStatus: options.validateStatus,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      requestEncoder: options.requestEncoder,
      responseDecoder: options.responseDecoder,
      path: '',
    );
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

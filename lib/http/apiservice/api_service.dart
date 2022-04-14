import 'package:dio/dio.dart';
import 'package:music/business/page/netease_page/model/bean.dart';
import 'package:music/business/page/search_page/model/bean.dart';
import 'package:music/constant/http_url.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../dio_client.dart';

part 'api_service.g.dart';

///所有接口API参考Listen1项目API
@RestApi(baseUrl: HttpUrl.BASE_NETEASE_URL)
abstract class ApiService {
  factory ApiService({Dio? dio, String? baseUrl}) {
    dio ??= DioClient().dio;
    return _ApiService(dio, baseUrl: baseUrl);
  }

  ///获取推荐列表
  @FormUrlEncoded()
  @POST("/weapi/playlist/list")
  Future<MultiPlayListWrap> getNeteasePlayList({
    @DioOptions() Options? options,
    @Field("category") String category = "全部",
    @Field("order") String order = "hot",
    @Field("offset") int offset = 0,
    @Field("limit") int limit = 30,
    @Field("total") bool total = true,
  });

  ///获取分类歌曲附属id列表
  @FormUrlEncoded()
  @POST("/weapi/v3/playlist/detail")
  Future<SinglePlayListWrap> getPlayList(
    @Field("id") String id, {
    @DioOptions() Options? options,
    @Field("offset") int offset = 0,
    @Field("limit") int limit = 1000,
    @Field("total") bool total = true,
    @Field("csrf_token") String token = "",
  });

  ///获取歌曲详情列表
  @FormUrlEncoded()
  @POST("/weapi/v3/song/detail")
  Future<SongDetailWrap> getSongList(
    @Field("c") String c,
    @Field("ids") String ids, {
    @DioOptions() Options? options,
  });

  ///获取歌曲详情列表-------建议使用V1版本，该接口获取成功率较低
  @FormUrlEncoded()
  @POST("https://interface3.music.163.com/eapi/song/enhance/player/url")
  Future<SongUrlListWrap> getSongUrl(
    @Field("ids") String ids, {
    @Field("br") int br = 999000,
    @DioOptions() Options? options,
  });

  ///本API参照Listen——mobile项目boostract----成功率较高
  @FormUrlEncoded()
  @POST("/weapi/song/enhance/player/url/v1")
  Future<SongUrlListWrap> getSongUrlV1(
    @Field("ids") String ids, {
    @Field("level") String level = "standard",
    @Field("encodeType") String encodeType = "aac",
    @DioOptions() Options? options,
  });

  // var params = {'s': keyword, 'type': 1, 'limit': limit, 'offset': offset};
  ///搜索API
  @FormUrlEncoded()
  @POST("/weapi/search/get")
  Future<SearchSongWrapX> searchSong(
    @Field("s") String keyword, {
    @Field("type") int type = 1,
    @Field("limit") int limit = 30,
    @Field("offset") int offset = 0,
    @DioOptions() Options? options,
  });
}

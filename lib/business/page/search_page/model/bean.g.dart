// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSongWrap _$SearchSongWrapFromJson(Map<String, dynamic> json) =>
    SearchSongWrap()
      ..songs = (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchSongWrapToJson(SearchSongWrap instance) =>
    <String, dynamic>{
      'songs': instance.songs,
    };

SearchSongWrapX _$SearchSongWrapXFromJson(Map<String, dynamic> json) =>
    SearchSongWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchSongWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchSongWrapXToJson(SearchSongWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchAlbumsWrapX _$SearchAlbumsWrapXFromJson(Map<String, dynamic> json) =>
    SearchAlbumsWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result = AlbumListWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchAlbumsWrapXToJson(SearchAlbumsWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchArtistsWrap _$SearchArtistsWrapFromJson(Map<String, dynamic> json) =>
    SearchArtistsWrap()
      ..artists = (json['artists'] as List<dynamic>)
          .map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchArtistsWrapToJson(SearchArtistsWrap instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };

SearchArtistsWrapX _$SearchArtistsWrapXFromJson(Map<String, dynamic> json) =>
    SearchArtistsWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchArtistsWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchArtistsWrapXToJson(SearchArtistsWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchPlaylistWrap _$SearchPlaylistWrapFromJson(Map<String, dynamic> json) =>
    SearchPlaylistWrap()
      ..playlists = (json['playlists'] as List<dynamic>)
          .map((e) => Play.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchPlaylistWrapToJson(SearchPlaylistWrap instance) =>
    <String, dynamic>{
      'playlists': instance.playlists,
    };

SearchPlaylistWrapX _$SearchPlaylistWrapXFromJson(Map<String, dynamic> json) =>
    SearchPlaylistWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchPlaylistWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchPlaylistWrapXToJson(
        SearchPlaylistWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchMvWrapX _$SearchMvWrapXFromJson(Map<String, dynamic> json) =>
    SearchMvWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result = MvListWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchMvWrapXToJson(SearchMvWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchLyricsWrap _$SearchLyricsWrapFromJson(Map<String, dynamic> json) =>
    SearchLyricsWrap()
      ..songs = (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchLyricsWrapToJson(SearchLyricsWrap instance) =>
    <String, dynamic>{
      'songs': instance.songs,
    };

SearchLyricsWrapX _$SearchLyricsWrapXFromJson(Map<String, dynamic> json) =>
    SearchLyricsWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchLyricsWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchLyricsWrapXToJson(SearchLyricsWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchVideoWrap _$SearchVideoWrapFromJson(Map<String, dynamic> json) =>
    SearchVideoWrap()
      ..videos = (json['videos'] as List<dynamic>)
          .map((e) => Mv2.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchVideoWrapToJson(SearchVideoWrap instance) =>
    <String, dynamic>{
      'videos': instance.videos,
    };

SearchVideoWrapX _$SearchVideoWrapXFromJson(Map<String, dynamic> json) =>
    SearchVideoWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchVideoWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchVideoWrapXToJson(SearchVideoWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchComplexSong _$SearchComplexSongFromJson(Map<String, dynamic> json) =>
    SearchComplexSong()
      ..songs = (json['songs'] as List<dynamic>)
          .map((e) => Song2.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexSongToJson(SearchComplexSong instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexPlaylist _$SearchComplexPlaylistFromJson(
        Map<String, dynamic> json) =>
    SearchComplexPlaylist()
      ..playLists = (json['playLists'] as List<dynamic>)
          .map((e) => Play.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexPlaylistToJson(
        SearchComplexPlaylist instance) =>
    <String, dynamic>{
      'playLists': instance.playLists,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexArtist _$SearchComplexArtistFromJson(Map<String, dynamic> json) =>
    SearchComplexArtist()
      ..artists = (json['artists'] as List<dynamic>)
          .map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexArtistToJson(
        SearchComplexArtist instance) =>
    <String, dynamic>{
      'artists': instance.artists,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexAlbum _$SearchComplexAlbumFromJson(Map<String, dynamic> json) =>
    SearchComplexAlbum()
      ..albums = (json['albums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexAlbumToJson(SearchComplexAlbum instance) =>
    <String, dynamic>{
      'albums': instance.albums,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexVideo _$SearchComplexVideoFromJson(Map<String, dynamic> json) =>
    SearchComplexVideo()
      ..videos = (json['videos'] as List<dynamic>)
          .map((e) => Video2.fromJson(e as Map<String, dynamic>))
          .toList()
      ..moreText = json['moreText'] as String?
      ..highText = json['highText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexVideoToJson(SearchComplexVideo instance) =>
    <String, dynamic>{
      'videos': instance.videos,
      'moreText': instance.moreText,
      'highText': instance.highText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexSimQueryItem _$SearchComplexSimQueryItemFromJson(
        Map<String, dynamic> json) =>
    SearchComplexSimQueryItem()
      ..keyword = json['keyword'] as String?
      ..alg = json['alg'] as String?;

Map<String, dynamic> _$SearchComplexSimQueryItemToJson(
        SearchComplexSimQueryItem instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'alg': instance.alg,
    };

SearchComplexSimQuery _$SearchComplexSimQueryFromJson(
        Map<String, dynamic> json) =>
    SearchComplexSimQuery()
      ..sim_querys = (json['sim_querys'] as List<dynamic>)
          .map((e) =>
              SearchComplexSimQueryItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..more = json['more'] as bool?;

Map<String, dynamic> _$SearchComplexSimQueryToJson(
        SearchComplexSimQuery instance) =>
    <String, dynamic>{
      'sim_querys': instance.sim_querys,
      'more': instance.more,
    };

SearchComplexTalk _$SearchComplexTalkFromJson(Map<String, dynamic> json) =>
    SearchComplexTalk()
      ..moreText = json['moreText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexTalkToJson(SearchComplexTalk instance) =>
    <String, dynamic>{
      'moreText': instance.moreText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexUser _$SearchComplexUserFromJson(Map<String, dynamic> json) =>
    SearchComplexUser()
      ..moreText = json['moreText'] as String?
      ..more = json['more'] as bool?
      ..resourceIds =
          (json['resourceIds'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SearchComplexUserToJson(SearchComplexUser instance) =>
    <String, dynamic>{
      'moreText': instance.moreText,
      'more': instance.more,
      'resourceIds': instance.resourceIds,
    };

SearchComplexWrap _$SearchComplexWrapFromJson(Map<String, dynamic> json) =>
    SearchComplexWrap()
      ..song = json['song'] == null
          ? null
          : SearchComplexSong.fromJson(json['song'] as Map<String, dynamic>)
      ..playList = json['playList'] == null
          ? null
          : SearchComplexPlaylist.fromJson(
              json['playList'] as Map<String, dynamic>)
      ..artist = json['artist'] == null
          ? null
          : SearchComplexArtist.fromJson(json['artist'] as Map<String, dynamic>)
      ..album = json['album'] == null
          ? null
          : SearchComplexAlbum.fromJson(json['album'] as Map<String, dynamic>)
      ..video = json['video'] == null
          ? null
          : SearchComplexVideo.fromJson(json['video'] as Map<String, dynamic>)
      ..sim_query = json['sim_query'] == null
          ? null
          : SearchComplexSimQuery.fromJson(
              json['sim_query'] as Map<String, dynamic>)
      ..talk = json['talk'] == null
          ? null
          : SearchComplexTalk.fromJson(json['talk'] as Map<String, dynamic>)
      ..user = json['user'] == null
          ? null
          : SearchComplexUser.fromJson(json['user'] as Map<String, dynamic>)
      ..order =
          (json['order'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$SearchComplexWrapToJson(SearchComplexWrap instance) =>
    <String, dynamic>{
      'song': instance.song,
      'playList': instance.playList,
      'artist': instance.artist,
      'album': instance.album,
      'video': instance.video,
      'sim_query': instance.sim_query,
      'talk': instance.talk,
      'user': instance.user,
      'order': instance.order,
    };

SearchComplexWrapX _$SearchComplexWrapXFromJson(Map<String, dynamic> json) =>
    SearchComplexWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchComplexWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchComplexWrapXToJson(SearchComplexWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchKey _$SearchKeyFromJson(Map<String, dynamic> json) => SearchKey()
  ..showKeyword = json['showKeyword'] as String?
  ..action = json['action'] as int?
  ..realkeyword = json['realkeyword'] as String?
  ..searchType = json['searchType'] as int?
  ..alg = json['alg'] as String?
  ..gap = json['gap'] as int?;

Map<String, dynamic> _$SearchKeyToJson(SearchKey instance) => <String, dynamic>{
      'showKeyword': instance.showKeyword,
      'action': instance.action,
      'realkeyword': instance.realkeyword,
      'searchType': instance.searchType,
      'alg': instance.alg,
      'gap': instance.gap,
    };

SearchKeyWrap _$SearchKeyWrapFromJson(Map<String, dynamic> json) =>
    SearchKeyWrap()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..data = SearchKey.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchKeyWrapToJson(SearchKeyWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

SearchHotKey _$SearchHotKeyFromJson(Map<String, dynamic> json) => SearchHotKey()
  ..first = json['first'] as String?
  ..second = json['second'] as int?
  ..iconType = json['iconType'] as int;

Map<String, dynamic> _$SearchHotKeyToJson(SearchHotKey instance) =>
    <String, dynamic>{
      'first': instance.first,
      'second': instance.second,
      'iconType': instance.iconType,
    };

SearchHotKeyWrap _$SearchHotKeyWrapFromJson(Map<String, dynamic> json) =>
    SearchHotKeyWrap()
      ..hots = (json['hots'] as List<dynamic>)
          .map((e) => SearchHotKey.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchHotKeyWrapToJson(SearchHotKeyWrap instance) =>
    <String, dynamic>{
      'hots': instance.hots,
    };

SearchKeyWrapX _$SearchKeyWrapXFromJson(Map<String, dynamic> json) =>
    SearchKeyWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchHotKeyWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchKeyWrapXToJson(SearchKeyWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchKeyDetailedItem _$SearchKeyDetailedItemFromJson(
        Map<String, dynamic> json) =>
    SearchKeyDetailedItem()
      ..searchWord = json['searchWord'] as String?
      ..content = json['content'] as String?
      ..iconUrl = json['iconUrl'] as String?
      ..url = json['url'] as String?
      ..alg = json['alg'] as String?
      ..score = json['score'] as int?
      ..source = json['source'] as int?
      ..iconType = json['iconType'] as int;

Map<String, dynamic> _$SearchKeyDetailedItemToJson(
        SearchKeyDetailedItem instance) =>
    <String, dynamic>{
      'searchWord': instance.searchWord,
      'content': instance.content,
      'iconUrl': instance.iconUrl,
      'url': instance.url,
      'alg': instance.alg,
      'score': instance.score,
      'source': instance.source,
      'iconType': instance.iconType,
    };

SearchKeyDetailedWrap _$SearchKeyDetailedWrapFromJson(
        Map<String, dynamic> json) =>
    SearchKeyDetailedWrap()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..data = (json['data'] as List<dynamic>)
          .map((e) => SearchKeyDetailedItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchKeyDetailedWrapToJson(
        SearchKeyDetailedWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'data': instance.data,
    };

SearchSuggestItem _$SearchSuggestItemFromJson(Map<String, dynamic> json) =>
    SearchSuggestItem()
      ..keyword = json['keyword'] as String?
      ..type = json['type'] as int?
      ..alg = json['alg'] as String?
      ..lastKeyword = json['lastKeyword'] as String?;

Map<String, dynamic> _$SearchSuggestItemToJson(SearchSuggestItem instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'type': instance.type,
      'alg': instance.alg,
      'lastKeyword': instance.lastKeyword,
    };

SearchSuggestWrap _$SearchSuggestWrapFromJson(Map<String, dynamic> json) =>
    SearchSuggestWrap()
      ..allMatch = (json['allMatch'] as List<dynamic>)
          .map((e) => SearchSuggestItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchSuggestWrapToJson(SearchSuggestWrap instance) =>
    <String, dynamic>{
      'allMatch': instance.allMatch,
    };

SearchSuggestWrapX _$SearchSuggestWrapXFromJson(Map<String, dynamic> json) =>
    SearchSuggestWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchSuggestWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchSuggestWrapXToJson(SearchSuggestWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

SearchMultiMatchWrap _$SearchMultiMatchWrapFromJson(
        Map<String, dynamic> json) =>
    SearchMultiMatchWrap()
      ..song = (json['song'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList()
      ..playList = (json['playList'] as List<dynamic>?)
          ?.map((e) => Play.fromJson(e as Map<String, dynamic>))
          .toList()
      ..artist = (json['artist'] as List<dynamic>?)
          ?.map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList()
      ..album = (json['album'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList()
      ..orders =
          (json['orders'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$SearchMultiMatchWrapToJson(
        SearchMultiMatchWrap instance) =>
    <String, dynamic>{
      'song': instance.song,
      'playList': instance.playList,
      'artist': instance.artist,
      'album': instance.album,
      'orders': instance.orders,
    };

SearchMultiMatchWrapX _$SearchMultiMatchWrapXFromJson(
        Map<String, dynamic> json) =>
    SearchMultiMatchWrapX()
      ..code = dynamicToInt(json['code'])
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..result =
          SearchMultiMatchWrap.fromJson(json['result'] as Map<String, dynamic>);

Map<String, dynamic> _$SearchMultiMatchWrapXToJson(
        SearchMultiMatchWrapX instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'result': instance.result,
    };

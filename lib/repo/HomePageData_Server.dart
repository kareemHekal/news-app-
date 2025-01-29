import 'dart:convert';

import 'package:news_app/models/SourcesResponce.dart';
import 'package:news_app/models/newDataResponce.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/repo/Home_Page_Repo.dart';

import '../cache Helper/News Cache Helper.dart';
import '../cache Helper/Sourses Cache Helper.dart';
import '../utils/constants.dart';

class HomepagedataServer implements HomePageRepo {
  @override
  Future<newsDataResponce> getNews(String sourceId) async {
    Uri url = Uri.https(Constants.base_url, "/v2/everything", {
      "apiKey": Constants.api_key,
      'sources': sourceId,
    });
    http.Response Response = await http.get(url);
    var json = jsonDecode(Response.body);
    newsDataResponce newsResponce = newsDataResponce.fromJson(json);
    await NewsCacheHelper.saveNewsData(newsResponce,sourceId);
    return newsResponce;
  }

  @override
  Future<SourcesResponce> getSources(String category) async {
    Uri url = Uri.https(Constants.base_url, "/v2/top-headlines/sources", {
      "apiKey": Constants.api_key,
      'category': category,
    });

    http.Response Response = await http.get(url);
    var json = jsonDecode(Response.body);
    SourcesResponce sourcesResponce=SourcesResponce.fromJson(json);
    await SourcesCacheHelper.saveSources(sourcesResponce,category);
    return sourcesResponce;
  }
}

import 'package:news_app/models/SourcesResponce.dart';

import 'package:news_app/models/newDataResponce.dart';

import '../cache Helper/News Cache Helper.dart';
import '../cache Helper/Sourses Cache Helper.dart';
import 'Home_Page_Repo.dart';

class  HomepagedataLocal implements HomePageRepo{
  @override
  Future<newsDataResponce> getNews(String sourceId) async {
    newsDataResponce? news = await NewsCacheHelper.getNewsData(sourceId);
    return news!;
  }

  @override
  Future<SourcesResponce> getSources(String category) async {
    SourcesResponce? sourceResponse = await SourcesCacheHelper.getSourcesData(category);
    return sourceResponse!;
  }
}
import 'package:news_app/models/SourcesResponce.dart';

import '../models/newDataResponce.dart';

abstract class HomePageRepo {
  Future<SourcesResponce>getSources(String sourceId);
  Future<newsDataResponce>getNews(String sourceId);
}
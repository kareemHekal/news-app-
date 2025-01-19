import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/bloc/homeStates.dart';

import '../models/SourcesResponce.dart';
import '../models/newDataResponce.dart';
import '../utils/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  SourcesResponce? sourcesResponce;
  newsDataResponce? news_data_responce;
  int selectedIndex = 0;

  HomeCubit() : super(HomeInitState());

  changeIndex(int index){
    selectedIndex = index;
    emit(ChangeIndexInNewsTabs());
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  Future<void> get_sources(String category) async {
    try {
      emit(HomeGetSourcesLoadingState());
      Uri url = Uri.https(Constants.base_url, "/v2/top-headlines/sources", {
        "apiKey": Constants.api_key,
        'category': category,
      });

      http.Response Response = await http.get(url);
      var json = jsonDecode(Response.body);
      sourcesResponce = SourcesResponce.fromJson(json);
      emit(HomeGetSourcesSuccessState());
      get_newsData(sourcesResponce?.sources?[selectedIndex].id??"");
    } catch (e) {
      emit(HomeGetSourcesErrorState());
    }
  }

  Future<void> get_newsData(
    String sourceId,
  ) async {
    try {
      emit(HomeGetNewsLoadingState());
      Uri url = Uri.https(Constants.base_url, "/v2/everything", {
        "apiKey": Constants.api_key,
        'sources': sourceId,
      });
      http.Response Response = await http.get(url);
      var json = jsonDecode(Response.body);
      if (Response.statusCode != 200) {
        emit(HomeGetNewsErrorState());
        return;
      }
      news_data_responce = newsDataResponce.fromJson(json);
      emit(HomeGetNewsSuccessState());
    } catch (e) {
      emit(HomeGetNewsLoadingState());
    }
  }
}

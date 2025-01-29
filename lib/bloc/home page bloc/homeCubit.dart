import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/bloc/home%20page%20bloc/homeStates.dart';
import 'package:news_app/repo/Home_Page_Repo.dart';

import '../../models/SourcesResponce.dart';
import '../../models/newDataResponce.dart';
import '../../utils/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  SourcesResponce? sourcesResponce;
  newsDataResponce? news_data_responce;
  int selectedIndex = 0;

  HomePageRepo repo;

  HomeCubit(this.repo) : super(HomeInitState());

  changeIndex(int index) {
    selectedIndex = index;
    emit(ChangeIndexInNewsTabs());
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> get_sources(String category) async {
    try {
      emit(HomeGetSourcesLoadingState());
      sourcesResponce = await repo.getSources(category);
      emit(HomeGetSourcesSuccessState());
      get_newsData(sourcesResponce?.sources?[selectedIndex].id ?? "");
    } catch (e) {
      emit(HomeGetSourcesErrorState());
    }
  }

  Future<void> get_newsData(
    String sourceId,
  ) async {
    try {
      emit(HomeGetNewsLoadingState());
      news_data_responce = await repo.getNews(sourceId);

      emit(HomeGetNewsSuccessState());
    } catch (e) {
      print("Error :>>>>>>>>>>>>>>$e");

      emit(HomeGetNewsErrorState());
      rethrow;
    }
  }
}

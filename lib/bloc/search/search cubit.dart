import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/bloc/search/search%20states.dart';
import '../../models/newDataResponce.dart';
import '../../utils/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  newsDataResponce? news_data_responce;

  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> get_newsData(String query) async {
    try {
      emit(SearchLoading());
      Uri url = Uri.https(Constants.base_url, "/v2/everything", {
        "apiKey": Constants.api_key,
        "q": query,
      });
      http.Response Response = await http.get(url);
      var json = jsonDecode(Response.body);
      if (Response.statusCode != 200) {
        emit(SearchError());
        print(Response.statusCode);
        return;
      }
      news_data_responce = newsDataResponce.fromJson(json);
      emit(SearchLoadedSuccessfully());
    } catch (e) {
      emit(SearchError());
    }
  }
}

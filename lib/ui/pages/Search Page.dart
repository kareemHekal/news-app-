import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/bloc/search/search%20cubit.dart';
import 'package:news_app/bloc/search/search%20states.dart';

import '../items(cards)/news item.dart';

class SearchPage extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)
            
          ),
          borderSide: BorderSide(color: Colors.white,width: 2),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = ""; // Clear the query
          showSuggestions(context); // Show suggestions again
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) => SearchCubit()..get_newsData(query),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {
            if (state is SearchLoading) { context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            final cubit = SearchCubit.get(context);
            if (query.isEmpty){
              return const Center(child: Text("Write some thing to search"));
            }
            if (state is SearchLoading) { context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
            if (state is SearchError) {
              return const Center(child: Text("Something went wrong"));
            }
            return ListView.builder(
              itemCount: cubit.news_data_responce?.articles?.length??0,
              itemBuilder: (context, index) {
                return Newsitem(
                  article: cubit.news_data_responce!.articles![index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) => SearchCubit()..get_newsData("queries"),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {
            if (state is SearchLoading) { context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            final cubit = SearchCubit.get(context);
            if (state is SearchError) {
              return const Center(child: Text("Something went wrong"));
            }
            if ( cubit.news_data_responce?.articles == null) {
              return const Center(child: Text("No data available"));
            }
            return ListView.builder(
              itemCount: cubit.news_data_responce!.articles!.length,
              itemBuilder: (context, index) {
                return Newsitem(
                  article: cubit.news_data_responce!.articles![index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

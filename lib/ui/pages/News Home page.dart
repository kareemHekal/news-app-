import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/bloc/home%20page%20bloc/homeCubit.dart';
import 'package:news_app/bloc/home%20page%20bloc/homeStates.dart';
import 'package:news_app/main.dart';
import 'package:news_app/repo/HomePageData_Local.dart';

import '../../repo/HomePageData_Server.dart';
import '../items(cards)/news item.dart';
import '../items(cards)/tab_item.dart';
import 'categories page.dart';

class NewsUI extends StatelessWidget {
  final String category;

  const NewsUI({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) =>
            HomeCubit(isConnected ? HomepagedataServer() : HomepagedataLocal())
              ..get_sources(category),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            // Show loader overlay while fetching sources or news
            if (state is HomeGetSourcesLoadingState ||
                state is HomeGetNewsLoadingState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
            // Show error dialog when error occurs
            if (state is HomeGetNewsErrorState ||
                state is HomeGetSourcesErrorState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesPage(),
                              ),
                              (route) => false);
                        },
                        child: const Text("Try again"))
                  ],
                  content: const Text(
                      "Something went wrong Or their is no cached  data fro this"),
                ),
              );
            }

            // Fetch news data after the index change
            if (state is ChangeIndexInNewsTabs) {
              final selectedSource = HomeCubit.get(context)
                  .sourcesResponce
                  ?.sources?[HomeCubit.get(context).selectedIndex];
              if (selectedSource != null) {
                HomeCubit.get(context).get_newsData(selectedSource.id ?? "");
              }
            }
          },
          builder: (context, state) {
            // Handle error states
            if (state is HomeGetNewsErrorState ||
                state is HomeGetSourcesErrorState) {
              return const Center(child: Text("Something went wrong"));
            }

            // Handle loading state
            if (state is HomeGetNewsLoadingState ||
                state is HomeGetSourcesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            // Check if data is available
            final cubit = HomeCubit.get(context);
            if (cubit.sourcesResponce?.sources == null ||
                cubit.news_data_responce?.articles == null) {
              return const Center(child: Text("No data available"));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DefaultTabController(
                    length: cubit.sourcesResponce!.sources!.length,
                    child: TabBar(
                      onTap: (value) {
                        cubit.changeIndex(value);
                      },
                      dividerHeight: 0,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      tabs: cubit.sourcesResponce!.sources!.map((e) {
                        return TabItem(
                          source: e.name ?? "",
                          isSelected: cubit.sourcesResponce!.sources!
                                  .elementAt(cubit.selectedIndex) ==
                              e,
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.news_data_responce!.articles!.length,
                      itemBuilder: (context, index) {
                        return Newsitem(
                          article: cubit.news_data_responce!.articles![index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

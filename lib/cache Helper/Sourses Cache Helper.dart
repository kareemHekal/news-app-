import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/models/SourcesResponce.dart';
import 'package:path_provider/path_provider.dart';

class SourcesCacheHelper {
  static Future<void> saveSources(SourcesResponce source, String category) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'NewsData',
      {'sources'},
      path: appDocDirectory.path,
    );

    final sourcesBox = await collection.openBox<Map>('sources');

    // Save sources under the given category key
    await sourcesBox.put(category, source.toJson());
  }

  static Future<SourcesResponce?> getSourcesData(String category) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'NewsData',
      {'sources'},
      path: appDocDirectory.path,
    );

    final sourcesBox = await collection.openBox<Map>('sources');

    // Retrieve sources based on category
    final sources = await sourcesBox.get(category);

    if (sources != null) {
      return SourcesResponce.fromJson(sources);
    }
    return null; // Return null if no sources found for the category
  }
}

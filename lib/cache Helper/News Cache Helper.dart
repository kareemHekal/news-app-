import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/models/newDataResponce.dart';
import 'package:path_provider/path_provider.dart';

class NewsCacheHelper {
  /// Saves news data for a specific source.
  static Future<void> saveNewsData(newsDataResponce newsData, String sourceId) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'NewsData',
      {'news'},
      path: appDocDirectory.path,
    );

    final newsBox = await collection.openBox<Map>('news');

    // Save news data using `sourceId` as the key
    await newsBox.put(sourceId, newsData.toJson());
  }

  /// Retrieves news data for a specific source.
  static Future<newsDataResponce?> getNewsData(String sourceId) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final collection = await BoxCollection.open(
      'NewsData',
      {'news'},
      path: appDocDirectory.path,
    );

    final newsBox = await collection.openBox<Map>('news');

    // Retrieve news based on `sourceId`
    final news = await newsBox.get(sourceId);

    if (news != null) {
      return newsDataResponce.fromJson(news);
    } else {
      print("No cached news found for sourceId: $sourceId");
      return null; // Return null if no news is found
    }
  }
}

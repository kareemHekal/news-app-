import 'package:flutter/material.dart';
import 'package:news_app/models/newDataResponce.dart';

import '../pages/News details page.dart';

class Newsitem extends StatelessWidget {
  Articles article;

  Newsitem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsPage(article: article,),));
      },
      child: Container(
        height: 310,
        width: 361,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image or a placeholder
            article.urlToImage != null && article.urlToImage!.isNotEmpty
                ? Image.network(
              article.urlToImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Text(
                    'Image Load Failed',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            )
                : Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text(
                'No Image Available',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                article.author ?? 'Unknown Author',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                article.title ?? 'No Title Available',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

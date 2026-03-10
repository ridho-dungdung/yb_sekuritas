import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yb_sekuritas/models/article_model.dart';

Widget listArticleItem(BuildContext context, Article article, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            height: 96,
            width: 96,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: NetworkImage(article.urlToImage ?? 'https://placehold.co/',),
                  fit: BoxFit.fitHeight,
                )
            ),
            child: Image.network(article.urlToImage ?? 'https://placehold.co/',
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return Container(
                    color: Colors.transparent,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                // return const Icon(Icons.error, color: Colors.red, size: 50);
                return const Icon(Icons.photo, color: Colors.grey, size: 30);
              },
            ),
          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(article.title!, style: TextStyle(color: Colors.black),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(article.source!['name'],
                    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat('dd MMMM').format(DateTime.parse(article.publishedAt!)).toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 14,),
                  )
                ],
              )
            ],
          ),)
        ],
      ),
    ),
  );
}
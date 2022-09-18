import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_app/common_components.dart';
import 'package:responsive_app/model/article_model.dart';

// ignore: must_be_immutable
class Detail extends StatelessWidget {
  Detail({Key? key}) : super(key: key);
  final Article article = Get.arguments['article'];
  bool isLargeScreen = false;
  final widthBoundary = 600;

  @override
  Widget build(BuildContext context) {
    isLargeScreen = MediaQuery.of(context).size.width > widthBoundary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('BoardDetailPage')),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 600,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CommonComponents.heightSpace(15),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Expanded(child: Text(article.userName ?? '')),
                                   if(!isLargeScreen)
                                     ElevatedButton(
                                       onPressed: () {
                                         showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 150,
                                              color: Colors.grey,
                                              child: getDetailsColumn(5)
                                            );
                                          }
                                      );
                                    },
                                    child: const Text('Details'),
                                  ),
                                ]
                              ),
                              CommonComponents.heightSpace(15),
                              CommonComponents.customTextLabel(
                                 text: article.title,
                                 textStyle: const TextStyle(fontSize: 20)),
                              CommonComponents.heightSpace(15),
                              CommonComponents.customTextLabel(text: article.content ?? '')
                            ],
                          ),
                          CommonComponents.heightSpace(15),
                          Image.network(article.imageUrl ?? '',
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? st) {
                              return Image.asset('assets/images/placeholder.png',
                                width: double.infinity,
                                fit: BoxFit.fill);
                            })
                      ],
                    )
                  )
                )
              ),
            if (isLargeScreen)
              Expanded(
                child: getDetailsColumn(20))
          ]);
        })
      );
  }

  Widget getDetailsColumn(double space) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonComponents.heightSpace(space),
        CommonComponents.customTextLabel(text: 'Category: ${article.category ?? ''}'),
        CommonComponents.heightSpace(space),
        CommonComponents.customTextLabel(text: 'Category: ${article.company ?? ''}'),
        CommonComponents.heightSpace(space),
        CommonComponents.customTextLabel(text: 'Category: ${article.dateTime ?? ''}'),
        CommonComponents.heightSpace(space),
        CommonComponents.customTextLabel(text: 'Category: ${article.newsLink ?? ''}'),
        CommonComponents.heightSpace(space),
        CommonComponents.customTextLabel(text: 'Subscribe Count: ${article.subscribeCount == null ? '' : article.subscribeCount.toString()}'),
      ],
    );
  }
}

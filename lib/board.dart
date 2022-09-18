import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_app/common_components.dart';
import 'package:responsive_app/constant/widget_key.dart';
import 'package:responsive_app/controller/board_controller.dart';
import 'package:responsive_app/repository/board_repository.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);
  final controller = Get.put(BoardController(boardRepository: BoardRepositoryImpl()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('BoardPage')),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/createBoard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber
              ),
              child: const Text('Move to CreateBoardPage')
          ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonComponents.textFormFieldBordered(
              key: textFieldSearchKey,
              hint: '검색어 입력',
              onChanged: (text) {
                controller.enteredText = text;
              },
              hasIcon: true,
              onSubmitted: (txt) {
                controller.addSearchKeyword(txt);
                controller.searchArticle();
              }
            ),
            CommonComponents.heightSpace(10),
            Obx(() {
              return Row(
                children: getKeywordsWidgetList(),
              );
            }),
            CommonComponents.heightSpace(15),
            Expanded(
              child: Obx(() {
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemCount: controller.articleList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonComponents.customTextLabel(
                                  text: controller.articleList[index].title,
                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              CommonComponents.heightSpace(10),
                              CommonComponents.customTextLabel(
                                  text: controller.articleList[index].content),
                              CommonComponents.heightSpace(10),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  CommonComponents.customTextLabel(
                                      text: controller.articleList[index].userName),
                                ],
                              )
                            ]
                        )),
                        onTap: () {
                          Get.toNamed('/detail', arguments: {'article': controller.articleList[index]});
                        },
                      );
                  });
              })
            )
          ],
        ),
      ),
    );
  }
  List<Widget> getKeywordsWidgetList() {
    List<Widget> widgetList = [];

    for (String keywords in controller.searchKeywords) {
      widgetList.add(
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(keywords),
        )
      );
    }
    return widgetList;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_app/common_components.dart';
import 'package:responsive_app/constant/route.dart';
import 'package:responsive_app/constant/widget_key.dart';
import 'package:responsive_app/controller/board_controller.dart';
import 'package:responsive_app/model/article_model.dart';

class CreateBoard extends StatefulWidget {
  const CreateBoard({Key? key}) : super(key: key);

  @override
  State<CreateBoard> createState() => _CreateBoardState();
}

class _CreateBoardState extends State<CreateBoard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final categories = ['금융', 'IT', '보안'];
  var buttonSelected = 0;

  final controller = Get.find<BoardController>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('CreateBoardPage')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
              return AlertDialog(
                  content: Text('정말 뒤로가시겠습니까?'),
                  actions: [
                    ElevatedButton(
                      onPressed:() {
                        Get.offNamedUntil(boardRoute, (route) => false);
                      },
                      child: const Text('네')),
                    ElevatedButton(
                      onPressed:() {
                        Get.back();
                      },
                      child: const Text('아니요')),
                  ]
              );
            });
        }),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            // Search keyword
            CommonComponents.textFormFieldBordered(
              key: textFieldCreateTitleKey,
              hint: '제목을 입력',
              onChanged: (text) {
              },
              maxLength: 15,
              controller: _titleController
            ),
            CommonComponents.heightSpace(20),
            CommonComponents.textFormFieldBordered(
              key: textFieldCreateContentsKey,
              hint: '내용을 입력',
              onChanged: (text) {
              },
              maxLines: 5,
              controller: _contentController
            ),
            CommonComponents.heightSpace(50),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    onClickCategoryButton(0);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: buttonSelected == 0 ? Colors.blue : Colors.grey),
                  child: CommonComponents.customTextLabel(text: categories[0])),
                CommonComponents.widthSpace(15),
                ElevatedButton(
                  onPressed: () {
                    onClickCategoryButton(1);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: buttonSelected == 1 ? Colors.blue : Colors.grey),
                  child: CommonComponents.customTextLabel(text: categories[1])),
                CommonComponents.widthSpace(15),
                ElevatedButton(
                  onPressed: () {
                    onClickCategoryButton(2);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: buttonSelected == 2 ? Colors.blue : Colors.grey),
                  child: CommonComponents.customTextLabel(text: categories[2])),
              ]
            ),
            CommonComponents.heightSpace(80),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty) {
                  CommonComponents.snackBarWithMsg(context: context, msg: 'Title is empty');
                  return;
                }
                if (_contentController.text.isEmpty) {
                  CommonComponents.snackBarWithMsg(context: context, msg: 'Content is empty');
                  return;
                }

                Get.find<BoardController>().addArticle(
                  Article(
                    id: Get.find<BoardController>().getLastIndex(),
                    userName: 'Flutter',
                    title: _titleController.text,
                    content: _contentController.text,
                    newsLink: 'https://www.javariantest.co.kr',
                    dateTime: getStringDate(),
                    company: 'Javarian',
                    category: categories[buttonSelected],
                    imageUrl: '',
                    subscribeCount: 0
                  )
                ).then((_) {
                    Get.back();
                  }).onError((error, stackTrace)  {
                    CommonComponents.snackBarWithMsg(context: context, msg: error.toString());
                  });
              },
              child: Container(
                  alignment: Alignment.center,
                  width: 300, child: CommonComponents.customTextLabel(text: 'Create'))),
          ],
        ),
      ),
    );
  }

  void onClickCategoryButton(int btnNum) {
    setState(() {
      buttonSelected = btnNum;
    });
  }

  String getStringDate() {
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(DateTime.now());
    return formattedDate;
  }
}

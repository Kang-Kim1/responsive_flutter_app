import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_app/board.dart';
import 'package:responsive_app/constant/route.dart';
import 'package:responsive_app/create_board.dart';
import 'package:responsive_app/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LoginPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => Board()
        ),
        GetPage(
          name: boardRoute,
          page: () => Board(),
        ),
        GetPage(
            name: detailRoute,
            page: () => Detail(),
        ),
        GetPage(
            name: createBoardRoute,
            page: () => const CreateBoard()
        ),
      ],
    );
  }
}


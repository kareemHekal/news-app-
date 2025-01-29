import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/ui/pages/categories%20page.dart';

import 'bloc/observer.dart';
bool isConnected = false;
void main() {
  Bloc.observer = MyBlocObserver();
  final connectionChecker = InternetConnectionChecker.instance;

  final subscription = connectionChecker.onStatusChange.listen(
        (InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        print('Connected to the internet');
        isConnected = true;
      } else {
        print('Disconnected from the internet');
        isConnected = false;
      }
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoriesPage() ,
    );
  }
}

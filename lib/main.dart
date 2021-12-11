import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_health/layout/home_layout.dart';
import 'package:i_health/modules/login_screen.dart';
import 'package:i_health/on_boarding/onBoarding.dart';
import 'package:i_health/shared/network/local/cache_helper.dart';
import 'package:i_health/shared/styles/theme.dart';
import 'bloc_observer.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  var uId= CacheHelper.getData(key: 'uId');

  Widget widget ;
  if(onBoarding == null)
    {
      widget = OnBoardingScreen();
    }
  else if(uId != null)
  {
    widget = HomeLayOut();
  }else
    {
      widget = LoginScreen();
    }
  print(onBoarding);

  runApp(MyApp(startWidget :  widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({
    required this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,

      home: startWidget,
    );
  }
}

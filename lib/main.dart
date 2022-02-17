import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/local/cache_helper.dart';
import 'package:news_app/shared/remote/dio_helper.dart';
import 'package:news_app/shared/style/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
   isDark = CacheHelper.getData(key: 'isDark');
  print(isDark);

  BlocOverrides.runZoned(
    () {
      runApp( MyApp(
        isDark: isDark!,
      ));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({Key? key, required this.isDark,  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsAppCubit()
              ..getSportsData()
              ..getScienceData()
              ..getBusinessData()..changeAppMode(fromShared: isDark))
      ],
      child: BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state){},
        builder: (context, state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: isDark? lightTheme() : darkTheme(),
            home: const NewsLayout(),
          );
        },

      ),
    );
  }
}

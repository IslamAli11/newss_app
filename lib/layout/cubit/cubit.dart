import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/local/cache_helper.dart';
import 'package:news_app/shared/remote/dio_helper.dart';


class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(InitialAppState());

  static NewsAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screen = [

    const SportsScreen(),
    const ScienceScreen(),
    const BusinessScreen(),
  ];
  List<String>title = [
    'SPORTS',
    'SCIENCE',
    'BUSINESS',
  ];

  List<dynamic> sports = [];
  List<dynamic> business = [];
  List<dynamic> science = [];

  void getBusinessData() {
    if (business.isEmpty) {
      emit(GetBusinessDataLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'a408d74db6dd4d6187ab9b7008ec2860',
      }).then((value) {
        business = value.data["articles"];
        print(business[0]["title"]);
        emit(GetBusinessDataSuccessState());
      }).catchError((error) {
        print(GetBusinessDataErrorState());
      });
    }
  }

  void getSportsData() {
    emit(GetSportsDataLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'a408d74db6dd4d6187ab9b7008ec2860',
    }).then((value) {
      sports = value.data["articles"];
      print(sports[0]["title"]);
      emit(GetSportsDataSuccessState());
    }).catchError((error) {
      print(GetSportsDataErrorState());
    });
  }

  void getScienceData() {
    if (science.isEmpty) {
      emit(GetScienceDataLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'a408d74db6dd4d6187ab9b7008ec2860',
      }).then((value) {
        science = value.data["articles"];
        print(science[0]["title"]);
        emit(GetScienceDataSuccessState());
      }).catchError((error) {
        print(GetScienceDataErrorState());
      });
    }
  }

  List<dynamic>search = [];
  void getSearchData( String? value) {
      emit(GetSearchDataLoadingState());
      DioHelper.getData(url: 'v2/everything',
          query: {
        'q': value,
        'apiKey': 'a408d74db6dd4d6187ab9b7008ec2860',
      }).then((value) {
        search = value.data["articles"];
        print(search[0]["title"]);
        emit(GetSearchDataSuccessState());
      }).catchError((error) {
        emit(GetSearchDataErrorState());
      });

  }

  changeBottomNavBarr(int index) {
    if (index == 0) {
      getSportsData();
    }
    if (index == 1) {
      getScienceData();
    } else {
      getBusinessData();
    }

    currentIndex = index;
    emit(ChangeBottomNavBarrState());
  }

  List<BottomNavigationBarItem> bottomBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
  ];
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    emit(ChangeModeState());
    if (fromShared != null) {
      isDark = fromShared;

      emit(ChangeModeState());
    } else {

      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark)!.then((value) {
        emit(ChangeModeState());
      });
    }
  }

}
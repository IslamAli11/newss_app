import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/component/component.dart';



class NewsLayout  extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit , NewsAppStates>(
     listener: (BuildContext context ,NewsAppStates state){},
     builder: (BuildContext context ,NewsAppStates state){
       NewsAppCubit cubit = NewsAppCubit.get(context);
       return Scaffold(
         appBar: AppBar(
           title:Text(
             cubit.title[cubit.currentIndex]
           ),
           actions: [
             IconButton(
                 onPressed:(){
                  navigateTo(context, SearchScreen());
                 },
                 icon:const Icon(Icons.search)
             ),
             IconButton(
                 onPressed:(){

                  NewsAppCubit.get(context).changeAppMode();

                 },
                 icon:const Icon(Icons.wb_sunny)
             ),


           ],
         ),
         body: cubit.screen[cubit.currentIndex],
         bottomNavigationBar: BottomNavigationBar(
           currentIndex: cubit.currentIndex,

           onTap: (index){
             cubit.changeBottomNavBarr(index);
           },
           items: cubit.bottomBarItem,
         ),
       );
     },
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
import 'package:news_app/shared/component/component.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state){},
      builder: (context, state){
        return articleBuilder(
            list:NewsAppCubit.get(context).science,
            context:context
        );
      },

    );
  }
}
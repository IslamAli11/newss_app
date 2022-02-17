import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black
                  ),
                  onTap: (){},
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'Text musn\'t be empty';
                    }
                  },

                  keyboardType: TextInputType.text,
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'search',
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    NewsAppCubit.get(context).getSearchData(value);
                  },
                ),
              ),
              if(state is GetSearchDataSuccessState)
              Expanded(
                child: articleBuilder(
                    list:NewsAppCubit.get(context).search,
                    context: context
                ),
              ),
              if(state is GetSearchDataLoadingState)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}

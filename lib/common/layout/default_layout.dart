import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/common/view/root_tap.dart';
import 'package:recipe_app/recipe/provider/search_recipe_provider.dart';
import 'package:recipe_app/recipe/view/recipe_screen.dart';
import 'package:recipe_app/user/provider/clip_provider.dart';

import '../../recipe/view/search_recipe_screen.dart';

class DefaultLayout extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavagtionBar;
  final bool isDetail;
  final bool isSearch;
  final bool isClip;
  final bool clipCheck;
  final int recipe_id;
  final bool clipScreen;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavagtionBar,
    this.isDetail=false,
    this.isSearch=false,
    this.isClip=false,
    this.clipCheck=false,
    this.recipe_id=0,
    this.clipScreen=false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state =ref.watch(clipProvider.notifier);
    final clipState = ref.watch(clipeDetailProvider(recipe_id));
    print(clipState?.summary.toString());
    return Scaffold(
      appBar: isClip
          ?
             AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: isDetail ? false : true,
               leading: isDetail
                   ? IconButton(
                 onPressed: (){Navigator.pop(context);},
                 icon: Icon(Icons.arrow_back),
                 color: Colors.brown,
                 alignment: Alignment.centerLeft,
               )
                   : null,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: (){
                    clipState ==null ?
                    state.addClip(id: recipe_id) : state.deleteClip(id: recipe_id);
                  },
                  icon: Icon(
                      clipState==null ?
                      Icons.label_important_outline
                      : Icons.label_important,
                      color: Colors.red,
                      size: 35,
                  )
                  ,
                  // Icons.label_important_outline,
                  // color: Colors.red,
                  // size: 35,
                ),
              )
            ],
          )
          :renderAppBar(context,ref),
      //??는 왼쪽 값이 null 이면 ?? 뒤에 값 적용
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
      bottomNavigationBar: bottomNavagtionBar,

    );
  }
  AppBar? renderAppBar(context, ref){
    String _search='';
    final _formKey = GlobalKey<FormState>();
    ref.read(searchRecipeProvider(_search).notifier).init();
    if(clipScreen){
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:  Image.asset(
          'asset/img/logo/clipRecipe.png',
          width: 200,
        ),
      );
    }
    if(title !=null){
      return AppBar(
        // backgroundColor: Color.fromRGBO(250, 234, 215,12),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: isDetail ? false : true,
        title: isDetail
            ? Text(
                isSearch ? '검색어: '+title! : title!,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w700
                ),
              )
            :
              Image.asset(
                'asset/img/logo/appbar.png',
                  width: 150,
                height: 100,
              ),
        leading: isDetail
            ? IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: Icon(Icons.arrow_back),
                color: Colors.brown,
                alignment: Alignment.centerLeft,
              )
            : null,
        actions : isDetail ? null
        : [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: (){
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                          )
                        ),
                        height: MediaQuery.of(context).size.height*0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 120,
                              ),
                              Image.asset(
                                'asset/img/logo/logo.png',
                                fit: BoxFit.cover,
                                height: 150,
                                width: 200,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      onSaved:(value){
                                        _search = value as String;
                                      },
                                      validator: (value){
                                        if(value!.length<1){
                                          return "검색어를 입력해주세요.";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        counterText: '와구와구',
                                        hintText: '음식명을 입력해주세요.',
                                      ),
                                    ),

                                ),
                                ),
                              ElevatedButton(
                                  onPressed: (){
                                    _formKey.currentState!.save();
                                    if(_formKey.currentState!.validate()){
                                      Navigator.pop(context);
                                      context.goNamed(
                                          SearchRecipe.routeName,
                                          pathParameters: {
                                            'search': _search
                                          }
                                      );
                                    }
                                  },
                                  child: Text('검색'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown
                                  ),
                              )
                            ],
                          ),
                        ),
                      )
                  );
                },
                icon: Icon(Icons.search,
                color: Colors.brown,
                size: 35,)
            ),
          ),
        ],
      );
    }
    return null;
  }
}

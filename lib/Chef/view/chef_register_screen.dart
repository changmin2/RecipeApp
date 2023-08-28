import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/common/layout/default_layout_v2.dart';
import 'package:image_picker/image_picker.dart';

class ChefRegisterScreen extends StatefulWidget {
  static get routeName => 'chefRegister';

  @override
  State<ChefRegisterScreen> createState() => _ChefRegisterScreenState();
}

class _ChefRegisterScreenState extends State<ChefRegisterScreen> {
  //음식 이미지
  XFile? _image;
  //난이도
  String dropdownValue ='선택';
  String category = '선택';

  final ImagePicker picker = ImagePicker();
  final _levelKey = GlobalKey<FormState>();
  final _categoryKey = GlobalKey<FormState>();
  final _levels = ['선택','초보환영','보통','어려움'];
  final _categroies = ['선택','한식','중국','동남아시아','서양','이탈리아','퓨전','일본'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        child: Padding(
          padding: EdgeInsets.only(left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30, width: double.infinity),
                //음식 사진
                Center(
                  child: DottedBorder(
                    color: Colors.grey,
                    dashPattern: [5,3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    child: Container(
                      width: 400,
                      height: 200,
                      decoration: _image!=null ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(_image!.path))
                          )
                      ) : null,
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){
                                  getImage(ImageSource.camera);
                                },
                                icon: _image==null ? Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(
                                    CupertinoIcons.camera,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ) : Container(),
                              ),
                              _image==null ? Text(
                                '카메라',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary
                                ),
                              ) : Container()
                            ]
                          ),
                          SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              IconButton(
                                onPressed: (){
                                  getImage(ImageSource.gallery);
                                },
                                icon: _image==null ? Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(
                                    CupertinoIcons.arrow_up_doc,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ) : Container(),
                              ), _image==null ?
                              Text(
                                '갤러리',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary
                                ),
                              ) : Container()
                            ]
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                //음식명
                TextFormField(
                  decoration: InputDecoration(
                      labelText: '음식명'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: '간단한 설명'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: '조리시간(분)'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: '칼로리'
                  ),
                ),
                SizedBox(height: 20, width: double.infinity),
                SizedBox(height: 8.0),
                //음식 난이도
                SizedBox(
                  width: 200,
                  child: Form(
                    key: _levelKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '난이도',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: _levels
                              .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                            )).toList(),
                            validator: (value) {
                              if (value == '선택') {
                                return 'Please select an option';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: Form(
                    key: _categoryKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '카테고리',
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: category,
                            onChanged: (String? newValue) {
                              setState(() {
                                category = newValue!;
                              });
                            },
                            items: _categroies
                                .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            )).toList(),
                            validator: (value) {
                              if (value == '선택') {
                                return 'Please select an option';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile!=null){
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }
}

AppBar _renderAppbar(BuildContext context){
  return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '레시피 등록 첫번째',
        style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.w700,
            fontSize: 24
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: (){Navigator.pop(context);},
        icon: Icon(Icons.arrow_back),
        color: Colors.brown,
        alignment: Alignment.centerLeft,
      )
  );
}

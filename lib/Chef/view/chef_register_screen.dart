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
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30, width: double.infinity),
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
          ],
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
        '레시피 등록하기',
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

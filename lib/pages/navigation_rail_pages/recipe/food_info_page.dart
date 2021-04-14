import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:image_picker/image_picker.dart';

class FoodInfoPage extends StatefulWidget {
  final FoodItem food;
  const FoodInfoPage({Key? key, required this.food}) : super(key: key);

  @override
  _FoodInfoPageState createState() => _FoodInfoPageState();
}

class _FoodInfoPageState extends State<FoodInfoPage> {
  bool get isEdit => widget.food.id != null;
  File? _image;
  final picker = ImagePicker();
  String? imageUrl;

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No image selected'),
            ),
          );
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodNameTextController =
        TextEditingController(text: widget.food.foodName.toString());
    final bodyTextController = TextEditingController(
      text: widget.food.body?.toString(),
    );
    var _textTheme = Theme.of(context).textTheme;

    //
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: [IconButton(icon: Icon(Icons.image), onPressed: getImage)],
            actionsIconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 250,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: FoodPageTextField(
                    foodNameController: foodNameTextController,
                    hintText: 'Enter food name'),
              ),
              centerTitle: true,
              stretchModes: [StretchMode.zoomBackground, StretchMode.fadeTitle],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (_image != null
                            ? FileImage(_image!)
                            : (isEdit
                                ? NetworkImage(
                                    widget.food.imageUrl.toString(),
                                  ) as ImageProvider
                                : NetworkImage(
                                    'https://i.imgur.com/QKYJihU.png'))),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey,
              height: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Last Made'),
                          SizedBox(height: 10),
                          Card(
                            semanticContainer: false,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: sidebarColor,
                              ),
                              child: Text(
                                'Nov 20 2021',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 8),
                child: Text(
                  'Recipe ',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 4, right: 16),
                child: TextFormField(
                  controller: bodyTextController,
                  maxLines: null,
                  style: _textTheme.bodyText2,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add recipe info here'),
                ),
              )
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: sidebarColor,
        label: Text(
          isEdit ? 'Update' : 'Add',
          style: TextStyle(color: Colors.black),
        ),
        icon: Icon(
          Icons.check,
          color: Colors.black,
        ),
        // click this button to confirm changes made to food item
        onPressed: () async {
          try {
            if (_image != null) {
              FirebaseStorage.instance
                  .setMaxUploadRetryTime(Duration(seconds: 3));
              setState(() {
                buildShowDialog(context);
              });
              TaskSnapshot snapshot = await FirebaseStorage.instance
                  .ref()
                  .child('images/${DateTime.now()}')
                  .putFile(_image!);

              var downloadURL = await snapshot.ref.getDownloadURL();
              setState(() {
                imageUrl = downloadURL;

                Navigator.of(context).pop();
              });
            }
            (isEdit
                ? context
                    .read(foodItemListControllerProvider)
                    .updateItem(
                      updatedItem: widget.food.copyWith(
                        foodName: foodNameTextController.text.isEmpty
                            ? widget.food.foodName.toString()
                            : foodNameTextController.text.trim(),
                        imageUrl: _image != null
                            ? imageUrl!
                            : widget.food.imageUrl.toString(),
                        body: bodyTextController.text.isEmpty
                            ? ''
                            : bodyTextController.text.trim(),
                      ),
                    )
                    .then((value) => Navigator.of(context).pop())
                : foodNameTextController.text.trim().isEmpty
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter the food name'),
                        ),
                      )
                    : context
                        .read(foodItemListControllerProvider)
                        .addItem(
                            name: foodNameTextController.text.trim(),
                            body: bodyTextController.text.trim(),
                            imageUrl: _image != null
                                ? imageUrl!
                                : 'https://i.imgur.com/QKYJihU.png')
                        .then(
                          (value) => Navigator.of(context).pop(),
                        ));
          } on Exception catch (e) {
            print(e.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          }
        },
      ),
    );
  }
}

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}

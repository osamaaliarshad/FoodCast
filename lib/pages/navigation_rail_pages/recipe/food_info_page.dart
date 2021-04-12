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
  bool isLoading = false;
  File? _image;
  final picker = ImagePicker();
  String? downloadURL;

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
    final foodNameTextController = TextEditingController();

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
                  hintText: !isEdit
                      ? 'Enter food name'
                      : widget.food.foodName.toString(),
                ),
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
          SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'recipe data here',
                style: TextStyle(fontSize: 200),
              ),
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
          if (isLoading != true) {
            if (_image != null) {
              TaskSnapshot snapshot = await FirebaseStorage.instance
                  .ref()
                  .child('images/${DateTime.now()}')
                  .putFile(_image!);

              downloadURL = await snapshot.ref.getDownloadURL();
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
                              ? downloadURL!
                              : widget.food.imageUrl.toString()),
                    )
                    .then((value) => setState(() {
                          isLoading = true;
                        }))
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
                            imageUrl: _image != null
                                ? downloadURL!
                                : 'https://i.imgur.com/QKYJihU.png')
                        .then((value) => setState(() {
                              isLoading = true;
                            }))
                        .then(
                          (value) => Navigator.of(context).pop(),
                        ));
          }
        },
      ),
    );
  }
}

import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:foodcast/controller/food_list_controller.dart';
import 'package:foodcast/models/food_item_model.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  DateTime? selectedDate;
  final DateFormat dateFormat = DateFormat('MMM dd yyy');
  String dropDownValue = 'Normal';

  initState() {
    if (widget.food.lastMade != null) {
      selectedDate = widget.food.lastMade!;
    }
    if (widget.food.frequency != 'Normal') {
      dropDownValue = widget.food.frequency.toString();
    }

    super.initState();
  }

  Future getImageGallery() async {
    try {
      final pickedFile =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 30);

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

  Future getImageCamera() async {
    try {
      final pickedFile =
          await picker.getImage(source: ImageSource.camera, imageQuality: 30);

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
            actions: [
              IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              contentPadding: EdgeInsets.all(10),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera),
                                    TextButton(
                                      onPressed: () {
                                        getImageCamera().then(
                                          (value) =>
                                              Navigator.of(context).pop(),
                                        );
                                      },
                                      child: Text(
                                        'Camera',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    TextButton(
                                      onPressed: () {
                                        getImageGallery().then(
                                          (value) =>
                                              Navigator.of(context).pop(),
                                        );
                                      },
                                      child: Text(
                                        'Gallery',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                  })
            ],
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
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: sidebarColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  (selectedDate == null
                                      ? 'N/A'
                                      : dateFormat.format(selectedDate!)),
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onTap: () async {
                              selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2100),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: sidebarColor,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              setState(() {});
                              print(selectedDate);
                            },
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
                padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recipe ',
                      style: TextStyle(fontSize: 30),
                    ),
                    Column(
                      children: [
                        Text('Frequency:'),
                        DropdownButton(
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          },
                          value: dropDownValue,
                          items: ['Often', 'Normal', 'Rare']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    )
                  ],
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
                          lastMade: selectedDate,
                          frequency: dropDownValue),
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
                                : 'https://i.imgur.com/QKYJihU.png',
                            frequency: dropDownValue)
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

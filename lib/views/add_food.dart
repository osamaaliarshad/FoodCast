import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:foodcast/models/food_item.dart';
import 'package:foodcast/providers/database_providers.dart';

class AddFood extends StatefulWidget {
  bool isFromEdit;
  String documentId;
  Map<String, dynamic> food;

  AddFood({this.isFromEdit, this.food, this.documentId});
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();
  String _name = '', _error = '';
  bool _isLoading = false;
  static GlobalKey<ScaffoldState> _keyScaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isFromEdit ? Text('Edit Food') : Text('Add food'),
      ),
      key: _keyScaffold,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Food name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name can not be empty!';
                      }
                      return null;
                    },
                    initialValue: widget.isFromEdit ? widget.food['name'] : '',
                    onChanged: (val) {
                      _name = val;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: RaisedButton(
                      child: Text('Add Food'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final response = context.read(databaseProvider);
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            if (!widget.isFromEdit) {
                              FoodItem _food = FoodItem(foodName: _name);
                              await response.addNewFood(_food);
                              setState(() {
                                _isLoading = false;
                                _error = '';
                              });
                            } else {
                              _name = _name != '' ? _name : widget.food['name'];
                              FoodItem _food = FoodItem(foodName: _name);

                              await response.editFood(_food, widget.documentId);
                              setState(() {
                                _isLoading = false;
                                _error = '';
                              });
                            }
                            final successSnackbar = SnackBar(
                              content: Text(widget.isFromEdit
                                  ? 'Edited Successfully !'
                                  : 'Added Successfully !'),
                              duration: Duration(
                                  seconds: 2), // display a snackbar message
                            );
                            _keyScaffold.currentState
                                .showSnackBar(successSnackbar)
                                .closed
                                .then((data) => {});
                          } catch (e) {
                            setState(() {
                              _isLoading = false;
                              _error = e.message;
                            });
                            final failureSnackbar =
                                SnackBar(content: Text('Error : $_error'));
                            _keyScaffold.currentState
                                .showSnackBar(failureSnackbar);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                  _isLoading ? CircularProgressIndicator() : Container(),
                  _error == ''
                      ? Text('')
                      : Text(
                          _error,
                          style: TextStyle(color: Colors.red), // for the error
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

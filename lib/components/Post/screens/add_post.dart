import 'package:analise_test/components/Post/db/PostService.dart';
import 'package:analise_test/components/Post/models/post.dart';
import 'package:analise_test/theme/Buttons/roundedButton.dart';
import 'package:analise_test/theme/style.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

final List<String> _allActivities = <String>[
  'Choose category',
  'Appliances and Tools',
  'Camera and Accessories',
  'Books and Stationery',
  'Computer and Gadgets',
  'Fashion and Accessories',
  'Games and Sports',
  'Home and Furniture',
  'Medical and Fitness',
  'Musice and Instrument',
  'Lifesyle and Leisure',
  'Bady Care and Toys',
  'Automobiles and Accessories',
  'Antiques and Collection',
];

String _activity = 'Choose category';

var category = _activity;

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Post post = Post(0, " ", " ", " ", " ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Tools"),
        elevation: 0.0,
        leading: new InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Form(
        key: formkey,
        child:
            new ListView(padding: const EdgeInsets.all(5.0), children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Post tilte", border: OutlineInputBorder()),
              onSaved: (val) => post.title = val,
              validator: (val) {
                if (val.isEmpty) {
                  return "title field cant be empty";
                } else if (val.length > 16) {
                  return "title cannot have more than 16 characters";
                }
              },
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              maxLines: 4,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  labelText: "Post description", border: OutlineInputBorder()),
              onSaved: (val) => post.description = val,
              validator: (val) {
                if (val.isEmpty) {
                  return "description field cant be empty";
                }
              },
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Add postcode", border: OutlineInputBorder()),
              onSaved: (val) => post.postcode = val,
              validator: (val) {
                if (val.isEmpty) {
                  return "postcode field cant be empty";
                } else if (val.length >= 8) {
                  return "postcode cannot have more then 8 characters";
                }
              },
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 5.0, right: 10.0),
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text("Where does it fit ?"),
                new Container(
                  padding: new EdgeInsets.all(5.0),
                  margin: const EdgeInsets.only(top: 1.0, bottom: 10.0),
                ),
                new DropdownButton<String>(
                  value: _activity,
                  isDense: true,
                  onChanged: (category) {
                    setState(() {
                      _activity = category;
                      print(category);
                    });
                  },
                  items: _allActivities.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(10.0)),
          new Container(
            padding: const EdgeInsets.all(4.0),
            margin: new EdgeInsets.all(12.0),
            child: new RoundedButton(
              buttonName: "Post",
              onTap: () {
                insertPost();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              height: 50.0,
              bottomMargin: 10.0,
              borderWidth: 0.0,
              buttonColor: primaryColor,
            ),
          ),
        ]),
      ),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      post.category = category;
      PostService postService = PostService(post.toMap());
      postService.addPost();
    }
  }
}

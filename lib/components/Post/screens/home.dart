import 'package:analise_test/components/Post/models/post.dart';
import 'package:analise_test/components/Post/screens/add_post.dart';
import 'package:analise_test/components/Post/screens/viewPost.dart';
import 'package:analise_test/pages/Login/index.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as time_ago;

import 'Search_Bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<Post> postsList = <Post>[];

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Community App"),
        leading: new InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search by postcode',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchBar()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white30,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: postsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: postsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child('posts'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostView(postsList[index])));
                                },
                                title: Text(
                                  postsList[index].title,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  time_ago.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          postsList[index].date)),
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.grey),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: Text(
                                  postsList[index].category,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "add a post",
      ),
    );
  }

  _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }
}

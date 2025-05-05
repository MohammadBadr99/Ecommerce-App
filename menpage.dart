import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class menpage extends StatefulWidget {
  const menpage({Key? key}) : super(key: key);

  @override
  State<menpage> createState() => _menpageState();
}

// ignore: camel_case_types
class _menpageState extends State<menpage> {
  // ignore: prefer_typing_uninitialized_variables
  List data = [];
  late ScrollController scrollController;
  /////////////////////USING InitState//////////////////////
  /*bool loading = true;
  
  getData() async {
    var response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var responseBody = jsonDecode(response.body);
    data.addAll(responseBody);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }*/
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {});
    super.initState();
  }

  Future<List> getData() async {
    var response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var responseBody = jsonDecode(response.body);
    data.addAll(responseBody);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(seconds: 2), curve: Curves.ease);
          },
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.move_up,
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }
            return ListView.builder(
                controller: scrollController,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${data[index]['title']}"),
                    subtitle: Text("${data[index]['body']}"),
                    trailing: IconButton(
                        icon: const Icon(Icons.update), onPressed: (() {})),
                  );
                });
          },
          future: getData(),
        ),
      ),
    );
  }
}

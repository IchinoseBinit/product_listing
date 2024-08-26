import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCallPage extends StatefulWidget {
  const ApiCallPage({super.key});

  @override
  State<ApiCallPage> createState() => _ApiCallPageState();
}

class _ApiCallPageState extends State<ApiCallPage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Call Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Data Present"),
                );
              }
              final list = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final data = list[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Text(
                                  data['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 5,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Id: ${data['id']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "User Id: ${data['userId']}",
                              ),
                            ],
                          ),
                          Text(
                            "${data['completed']}",
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: list.length,
              );
            }),
      ),
    );
  }

  Future<List> getData() async {
    const url = "https://jsonplaceholder.typicode.com/todos";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("this is response from api");
      print(response.body);
      // TODO:
      // return response.body;
      return jsonDecode(response.body);
    }
    return [];
  }
}

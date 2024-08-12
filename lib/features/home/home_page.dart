import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week_three/features/home/add_product_page.dart';
import 'package:week_three/features/home/update_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddProductPage()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("products").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              print("===== ${snapshot.data!.docs}");
              print("===== ${snapshot.data!.docs.first.data()}");
              return ListView.builder(
                itemBuilder: (context, index) {
                  final map = snapshot.data!.docs[index].data() as Map;
                  final id = snapshot.data!.docs[index].id;
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdateProductPage(id: id))),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  map['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs. ${map['price']}",
                                ),
                              ],
                            ),
                            Text(
                              map['description'],
                            ),
                            Text(
                              "Quantity: ${map['quantity']}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                primary: false,
              );
            }),
      ),
    );
  }
}

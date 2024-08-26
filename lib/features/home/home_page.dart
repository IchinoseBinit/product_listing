import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week_three/features/home/add_product_page.dart';
import 'package:week_three/features/home/api_call_page.dart';
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            var length = 0;
            if (snapshot.data != null) {
              length = snapshot.data!.docs.length;
            }
            final docs = snapshot.data!.docs;
            print("====data loaded");
            return ListView.builder(
              itemBuilder: (context, index) {
                final docId = docs[index].id;
                final data = docs[index].data();
                print(docId);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UpdateProductPage(
                          id: docId,
                          body: data,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Rs. ${data['price']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Quantity: ${data['quantity'].toString()}",
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("products")
                                  .doc(docId)
                                  .delete();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ApiCallPage(),
            ),
          );
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

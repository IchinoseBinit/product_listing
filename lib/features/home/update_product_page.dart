import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key, required this.id, required this.body});

  final String id;
  final Map<String, dynamic> body;

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.body['name'];
    priceController.text = widget.body['price'].toString();
    quantityController.text = widget.body['quantity'].toString();
    descriptionController.text = widget.body['description'];
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.body);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Please enter your name",
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(
                    fontSize: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  hintText: "Please enter price of the product",
                  prefixIcon: Icon(Icons.currency_rupee),
                  hintStyle: TextStyle(
                    fontSize: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  hintText: "Please enter quantity for the product",
                  prefixIcon: Icon(Icons.production_quantity_limits),
                  hintStyle: TextStyle(
                    fontSize: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Please enter description for the product",
                  prefixIcon: Icon(Icons.description),
                  hintStyle: TextStyle(
                    fontSize: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final name = nameController.text;
                    final priceVal = priceController.text;
                    final quantityVal = quantityController.text;
                    final description = descriptionController.text;
                    final price = double.tryParse(priceVal);
                    if (price == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Price is invalid")));
                      return;
                    }
                    final quantity = int.tryParse(quantityVal);
                    if (quantity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Quantity is invalid")));
                      return;
                    }
                    final product = {
                      "name": name,
                      "price": price,
                      "quantity": quantity,
                      "description": description,
                    };
                    print(product);

                    final db = FirebaseFirestore.instance;
                    await db
                        .collection("products")
                        .doc(widget.id)
                        .update(product);

                    Navigator.pop(context);
                  } catch (ex) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(ex.toString())));
                  }
                },
                child: Text("Update Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http_seba/Utils/HttpService.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  HttpService httpService = HttpService();
  Future<dynamic>? product;
  String numero_id = '';
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    product = null; // Initialize product as null
  }

  void setProduct() {
    String id = _controller.text;
    setState(() {
      product = httpService.fetchProduct(int.parse(id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<dynamic>(
              future: product,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No product found'));
                } else {
                  var productData = snapshot.data;
                  String productName =
                      productData['title'] ?? 'Unnamed Product';
                  String productId =
                      productData['id']?.toString() ?? 'Unknown ID';
                  String productDescription =
                      productData['description'] ?? 'No description';
                  String productImage = productData['image'] ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUrgu4a7W_OM8LmAuN7Prk8dzWXm7PVB_FmA&s';
                  return Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(productName),
                            subtitle:
                                Text('ID: $productId\n$productDescription'),
                          ),
                          Image.network(
                            productImage,
                            width: 300,
                            height: 300,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a number',
                    )),
                ElevatedButton(
                  onPressed: setProduct,
                  child: Text("Fetch Product"),
                ),
              ])),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductoPage(),
  ));
}

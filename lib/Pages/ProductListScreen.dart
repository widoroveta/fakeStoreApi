import 'package:flutter/material.dart';
import 'package:http_seba/Utils/HttpService.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  HttpService httpService = HttpService();

  /* Singleton agregar  */
  Future<List<dynamic>>? products;

  @override
  void initState() {
    super.initState();
    products = null; // Initialize products as null
  }

  void setProducts() {
    setState(() {
      products = httpService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found'));
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var productData = snapshot.data![index];
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
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing:
                          10.0, // Horizontal space between columns
                      mainAxisSpacing: 10.0, // Vertical space between rows
                      childAspectRatio: 1.0, // Aspect ratio of each item
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: setProducts,
              child: Text("Set Product"),
            ),
          ),
        ],
      ),
    );
  }
}

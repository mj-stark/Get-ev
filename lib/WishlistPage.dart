import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart'; 

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Consumer<Wishlist>(
        builder: (context, wishlist, child) {
          return ListView.builder(
            itemCount: wishlist.items.length,
            itemBuilder: (context, index) {
              Product product = wishlist.items[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.Rate),
                leading: Image.network(
                  product.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

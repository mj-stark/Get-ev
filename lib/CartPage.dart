import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart'; 

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Clear the cart
              Provider.of<CartModel>(context, listen: false).clearCart();
            },
          ),
        ],
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    Product product = cart.items[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.Rate.toString()), // Assuming rate is a double
                      leading: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              // Decrease quantity
                              Provider.of<CartModel>(context, listen: false)
                                  .updateQuantity(product, -1);
                            },
                          ),
                          Text(
                            '${product.quantity}', // Display quantity
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // Increase quantity
                              Provider.of<CartModel>(context, listen: false)
                                  .updateQuantity(product, 1);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total: \₹${cart.getTotalBill().toStringAsFixed(2)}'), // Display total bill
                    ElevatedButton(
                      child: Text('Place Order'),
                      onPressed: () {
                        // Place order logic here
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


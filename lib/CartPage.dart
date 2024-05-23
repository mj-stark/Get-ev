import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'Models/Products.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      subtitle: Text(
                          product.Rate.toString()), // Assuming rate is a double
                      leading: Image.network(
                        product.imageUrl,
                        width: 50.w,
                        height: 50.h,
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
                            style: TextStyle(fontSize: 18.sp),
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        'Total: \₹${cart.getTotalBill().toStringAsFixed(2)}'), // Display total bill
                    ElevatedButton(
                      child: Text('Place Order'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          );
        },
      ),
    );
  }
}

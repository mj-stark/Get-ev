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
          // Calculate subtotal for each product
          List<Widget> productList = cart.items.map((product) {
            double subtotal = double.parse(product.Rate) * product.quantity;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(product.name),
                      leading: Image.network(
                        product.imageUrl,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                iconSize: 15,
                                onPressed: () {
                                  // Decrease quantity
                                  Provider.of<CartModel>(context, listen: false)
                                      .updateQuantity(product, -1);
                                },
                              ),
                              Text(
                                '${product.quantity}', // Display quantity
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 15,
                                onPressed: () {
                                  // Increase quantity
                                  Provider.of<CartModel>(context, listen: false)
                                      .updateQuantity(product, 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '₹${subtotal.toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                    ),
                  ),
                ],
              ),
            );
          }).toList();

          // Calculate subtotal for all products
          double subtotal = cart.getTotalBill();

          // Calculate GST (18%)
          double gst = 0.18 * subtotal;

          // Packaging and delivery cost
          double packagingCost = 20;

          // Calculate total bill including GST, packaging, and delivery
          double totalBill = subtotal + gst + packagingCost;

          // Display total only if there are products in the cart
          Widget totalWidget = SizedBox.shrink();
          if (cart.items.isNotEmpty) {
            totalWidget = Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'GST: ₹${gst.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'Package cost: ₹${packagingCost.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'Total: ₹${totalBill.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  ElevatedButton(
                    child: Text('Place Order'),
                    onPressed: () {
                      // Place order logic
                      // You can add your logic here to place the order
                    },
                  ),
                ],
              ),
            );
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: productList,
                  ),
                ),
              ),
              totalWidget,
            ],
          );
        },
      ),
    );
  }
}

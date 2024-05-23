import 'package:flutter/material.dart';
import 'package:get_ev/HomePage.dart';
import 'Models/Products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<String> categories = [
    'All',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
    'Category 6'
  ];
  int selectedCategoryIndex = 0;
  bool filterByAmount = false;
  String? selectedPriceRange;

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter by Price Range'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('₹100 - ₹500'),
              onTap: () {
                setState(() {
                  selectedPriceRange = '100-500';
                  filterByAmount = true;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('₹500 - ₹1000'),
              onTap: () {
                setState(() {
                  selectedPriceRange = '500-1000';
                  filterByAmount = true;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Above ₹1000'),
              onTap: () {
                setState(() {
                  selectedPriceRange = '1000-';
                  filterByAmount = true;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Clear Filter'),
              onTap: () {
                setState(() {
                  selectedPriceRange = null;
                  filterByAmount = false;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SizedBox(
              height: 30.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: selectedCategoryIndex == index ? 20 : 16,
                          fontWeight: selectedCategoryIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return  FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                
              },
              child: GridView.builder(
                key: UniqueKey(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filterByAmount
                    ? products
                        .where((product) => _isPriceInRange(product.Rate))
                        .length
                    : products.length,
                itemBuilder: (context, index) {
                  var filteredProducts = filterByAmount
                      ? products
                          .where((product) => _isPriceInRange(product.Rate))
                          .toList()
                      : products;

                  return _buildProductCard(context, filteredProducts[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isPriceInRange(String price) {
    if (selectedPriceRange == '100-500') {
      return int.parse(price) >= 100 && int.parse(price) <= 500;
    } else if (selectedPriceRange == '500-1000') {
      return int.parse(price) >= 500 && int.parse(price) <= 1000;
    } else if (selectedPriceRange == '1000-') {
      return int.parse(price) > 1000;
    } else {
      return true;
    }
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        int quantity = cart.items
            .where((element) => element.name == product.name)
            .map((e) => e.quantity)
            .fold(0, (prev, quantity) => prev + quantity);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(style: BorderStyle.solid, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text('₹${product.Rate}'),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .addToCart(product);
                                },
                                child: Icon(Icons.add_circle_outline_sharp),
                              ),
                              SizedBox(width: 5),
                              Text('$quantity'),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeFromCart(product);
                                },
                                child: Icon(Icons.remove_circle_outline_sharp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                width: 20,
                top: 5,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<Wishlist>(context, listen: false)
                        .addToWishlist(product);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

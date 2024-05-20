import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';


class Product {
  final String name;
  final String imageUrl;
  final String? description; 

  Product({required this.name, required this.imageUrl, this.description});
}







class HomePage extends StatelessWidget {

  final List<Product> products = [
    Product(name: 'Product 1', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 2', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 3', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 4', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 5', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 6', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 7', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 8', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 9', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(name: 'Product 10', imageUrl: 'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.1)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
          children: [
            SizedBox(height: 40.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                    radius: 30.r,
                  ),
                  IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      // Implement cart icon functionality
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, User',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Your Name',
                    style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              
              options: CarouselOptions(
                aspectRatio: 19 / 9,
                viewportFraction: 0.997,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayInFiniteScroll: true
              ),
              items: [
                
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.grey,
                  ),
                  
                  child: Center(child: Text('Carousel Image 1')),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.grey,
                  ),
                  child: Center(child: Text('Carousel Image 2')),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.grey,
                  ),
                  child: Center(child: Text('Carousel Image 3')),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _buildSectionTitle('Categories'),
            GridView.count(

              shrinkWrap: true,
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryItem(context, 'Nuts'),
                _buildCategoryItem(context, 'Dry Fruits'),
                _buildCategoryItem(context, 'Beverages'),
                _buildCategoryItem(context, 'Chocolates'),
                _buildCategoryItem(context, 'Millets'),
                _buildCategoryItem(context, 'Oil'),
              ],
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle('Top Selling'),
            SizedBox(
              height: 200.h, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductItem(products[index]);
                },
              ),
            ),
            SizedBox(height: 20.h,),

 
            _buildSectionTitle('Recently added'),
            SizedBox(
              height: 200.h, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductItem(products[index]);
                },
              ),
            ),
            SizedBox(height: 20.h,)

          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String categoryName) {
    IconData iconData;
    switch (categoryName) {
      case 'Nuts':
        iconData = Icons.local_florist;
        break;
      case 'Dry Fruits':
        iconData = Icons.dry_cleaning;
        break;
      case 'Beverages':
        iconData = Icons.local_drink;
        break;
      case 'Chocolates':
        iconData = Icons.local_cafe;
        break;
      case 'Millets':
        iconData = Icons.grass;
        break;
      case 'Oil':
        iconData = Icons.local_gas_station;
        break;
      default:
        iconData = Icons.category;
    }

    return GestureDetector(
      onTap: () {
        // Navigate to category page
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            SizedBox(height: 10.h),
            Text(categoryName),
          ],
        ),
      ),
    );
  }
}


Widget _buildProductItem(Product product) {
  return StatefulBuilder(
    builder: (context, setState) {
      int quantity = 0;

      void incrementQuantity() {
        setState(() {
          quantity++;
        });
      }

      void decrementQuantity() {
        if (quantity > 1) {
          setState(() {
            quantity--;
          });
        }
      }

      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: Column(
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    if (product.description != null)
                      Text(
                        product.description!,
                        style: TextStyle(fontSize: 16),
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            decrementQuantity();
                          },
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            incrementQuantity();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          child: Container(
            width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            '500 rs',
                            style: TextStyle(fontSize: 10.sp, color: Colors.black),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  decrementQuantity();
                                },
                              ),
                              Text(
                                quantity.toString(),
                                style: TextStyle(fontSize: 10.sp),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  incrementQuantity();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

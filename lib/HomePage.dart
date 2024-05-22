import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_ev/CartPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class Product {
  final String name;
  final String imageUrl;
  final String description;
  final String Rate;
  int quantity;

  Product(
      {required this.name,
      required this.imageUrl,
      required this.description,
      required this.Rate,
      this.quantity = 1,});
}

final cartItems = <Product>[];
final cartCount = CartCount(0);

class Wishlist extends ChangeNotifier {
  List<Product> items = [];

  void addToWishlist(Product product) {
    items.add(product);
    notifyListeners();
  }
}

// Assuming this is your CartModel class
class CartModel extends ChangeNotifier {
  List<Product> items = [];

  // Add product to cart or update quantity if already exists
  void addToCart(Product product) {
   
bool productExists = false;
for (var item in items) {
  if (item.name == product.name) {
    item.quantity++;
    productExists = true;
    break;
  }
}

if (!productExists) {
  items.add(product);
}

notifyListeners();

  }

    
  

  // Remove product from cart
  void removeFromCart(Product product) {
    items.remove(product);
    notifyListeners();
  }

  // Clear the cart
  void clearCart() {
    items.clear();
    notifyListeners();
  }



 
  // Calculate total bill
  double getTotalBill() {
    double total = 0.0;
    for (var item in items) {
      total += int.parse(item.Rate) * item.quantity;
    }
    return total;
  }

  // Update quantity of a product in the cart
  void updateQuantity(Product product, int quantityChange) {
    // Find the product in the cart
    Product cartProduct = items.firstWhere((p) => p.name == product.name);
    if (cartProduct != null) {
      // Update the quantity
      cartProduct.quantity += quantityChange;
      // If the quantity is 0, remove the product from the cart
      if (cartProduct.quantity <= 0) {
        items.remove(cartProduct);
      }
      notifyListeners();
    }
  }
}

final wishlistItems = <Product>[];

void addToCart(Product product, int quantity) {
    cartItems.add(product);
}

void addToWishlist(Product product) {
  wishlistItems.add(product);
}

class CartCount extends ValueNotifier<int> {
  CartCount(int value) : super(value);
}

class HomePage extends StatelessWidget {
  final List<Product> products = [
    Product(
        name: 'Product 1',
        Rate: "500",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 2',
        Rate: "1200",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 3',
        Rate: "1000",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 4',
        Rate: "2000",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 5',
        Rate: "1500",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 6',
        Rate: "200",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 7',
        Rate: "300",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 8',
        Rate: "600",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 9',
        Rate: "500",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
    Product(
        name: 'Product 10',
        Rate: "700",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum libero nec tristique fermentum. Sed eget neque non ante fermentum ultricies. Cras nec justo a arcu pellentesque ultrices. Vivamus ultricies orci eu massa laoreet, nec convallis dolor faucibus. Donec nec convallis urna. Cras venenatis nunc nec diam fermentum, id mollis risus dapibus. Mauris nec purus nec libero feugiat elementum.',
        imageUrl:
            'https://eatanytime.in/cdn/shop/articles/close-up-healthy-nuts-wooden-background-generative-ai.jpg?v=1702453505&width=750'),
  ];

  @override
  Widget build(BuildContext context) {
    final CartCount cartCount = CartCount(0);
    int quantity = 0;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.1)
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
          children: [
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/564x/85/81/42/8581425e8ea241666d6583d1f327fdf8.jpg'),
                    radius: 30.r,
                  ),
                  Stack(
                    children: [
                      Container(
                        // Your widget tree here
                        child: ValueListenableBuilder<int>(
                          valueListenable: cartCount,
                          builder: (context, value, child) {
                            return Stack(
                              children: [
                                IconButton(
                                  iconSize: 25,
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CartPage();
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '$value', // Use the current cart count value
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
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
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Manoj',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: Colors.black),
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
                  pauseAutoPlayInFiniteScroll: true),
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
                  return _buildProductItem(
                      products[index], quantity, addToCart);
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            _buildSectionTitle('Recently added'),
            SizedBox(
              height: 200.h, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductItem(
                      products[index], quantity, addToCart);
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            )
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
      onTap: () {},
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

Widget _buildProductItem(Product product, int quantity, Function addToCart) {
  return StatefulBuilder(
    builder: (context, setState) {
      void incrementQuantity() {
        setState(() {
          quantity++;
        });
      }

      void decrementQuantity() {
        if (quantity > 0) {
          setState(() {
            quantity--;
          });
        }
      }

      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                height: 600.h,
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
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        product.description,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.montserrat().fontFamily),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            addToCart(product, quantity);
                            Provider.of<CartModel>(context, listen: false)
                                .addToCart(
                              Product(
                                  name: product.name,
                                  Rate: product.Rate,
                                  description: product.description,
                                  imageUrl: product.imageUrl),
                            );
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Text('Add to Cart'),
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
          child: Stack(
            children: [
              Container(
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
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
                      height: 130.h,
                      width: 160.w,
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
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontFamily: GoogleFonts.aBeeZee().fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Row(
                              children: [
                                Text( "₹ " + product.Rate),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      incrementQuantity();
                                      Provider.of<CartModel>(context, listen: false)
                                  .updateQuantity(product, 1);
                                    },
                                    child: Icon(Icons.add_circle_outline_sharp),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Text('$quantity'),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      decrementQuantity();
                                      Provider.of<CartModel>(context, listen: false)
                                  .updateQuantity(product, -1);
                                    },
                                    child:
                                        Icon(Icons.remove_circle_outline_sharp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                width: 20.w,
                top: 5.h,
                right: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<Wishlist>(context, listen: false).addToWishlist(
                      Product(
                          name: product.name,
                          Rate: product.Rate,
                          description: product.description,
                          imageUrl: product.imageUrl),
                    );
                    setState(() {}); // Trigger a rebuild of the WishlistPage
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

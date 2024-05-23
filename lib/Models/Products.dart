class Product {
  final String name;
  final String imageUrl;
  final String description;
  final String Rate;
  int quantity;

  Product({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.Rate,
    this.quantity = 1,
  });
}

List<Product> products = [
  
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

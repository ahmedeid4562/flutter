class Product {
  final String image;
  final String title;
  final String description;
  final double price;
  final String category;

  int quantity;

  Product({  required this.image,  required this.title,required this.description, required this.price, required this.category, this.quantity = 1, });
}


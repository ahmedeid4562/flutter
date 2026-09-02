import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/Group.png"),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icons/location.png"),
              const SizedBox(width: 5),
              Text(
                'Dhaka, Banasree',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4C4F4D),
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFF2F3F2),
            ),
            child: Row(
              spacing: 10,
              children: [
                Image.asset("assets/icons/search.png"),
                Text(
                  "Search Store",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                ),
              ],
            ),
          ),

          Image.asset("assets/images/banner.png"),

          Row(
            mainAxisAlignment: .spaceAround,
            children: [ItemCard(
              image: "assets/images/92f1ea7dcce3b5d06cd1b1418f9b9413 3.png",
              price:"\$4.99",
              title: "Organic Bananas",
              description:"7pcs, Priceg" ,),
             ItemCard(
              image:"assets/images/Vector.png" ,
             title:"Red Apple" ,
             description: "1kg, Priceg",
              price:"\$4.99" ,
              ),

            ],
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
   ItemCard({super.key,required this.image,required this.title,required this.description,required this.price});
   String image;
   String title;
   String description;
   String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 250,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xffE2E2E2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: 110,
            height: 62,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 33),

          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff181725),
            ),
          ),

          SizedBox(height: 5),

          Text(
           description,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff7c7c7c),
            ),
          ),

          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff181725),
                ),
              ),

              SizedBox(
                width: 45,
                height: 45,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Color(0xff53B175),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
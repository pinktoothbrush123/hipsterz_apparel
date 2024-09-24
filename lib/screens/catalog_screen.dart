import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 128, 127, 125), // Light pastel background color
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 153, 155, 152), // Complementary AppBar color
        elevation: 0,
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search for something',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildProductCard('Jackets', '\$299', 'assets/jacket.png'),
                  _buildProductCard('Shoes', '\$199', 'assets/shoes.png'),
                  _buildProductCard(
                      'Accessories', '\$99', 'assets/accessories.png'),
                  _buildProductCard('Coats', '\$199', 'assets/coats.png'),
                  _buildProductCard('Dresses', '\$399', 'assets/dresses.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String title, String price, String assetPath) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(
            assetPath,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(price,
              style:
                  const TextStyle(color: Color.fromARGB(255, 122, 101, 107))),
        ],
      ),
    );
  }
}

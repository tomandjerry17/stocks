import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SalesReportPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign out function
  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current user
    User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                user?.photoURL ??
                    'https://storage.googleapis.com/a1aa/image/I5CF7vUQhji5uHBe_W00_NaP6VvehExNQRlmZz7oXzA.jpg', // Default image
              ),
            ),
            SizedBox(width: 10),
            Text(user?.displayName ?? "User"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _signOut(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'SALES REPORT',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('DATE: 02-07-2025'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Sales'), Text('₱100.00')],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Profit'), Text('₱100.00')],
                  ),
                ],
              ),
            ),
            // CATEGORIES
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'CATEGORIES',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryItem(
                          imageUrl:
                              'https://storage.googleapis.com/a1aa/image/RAK7rHBVaPYYmolPAWOlvEL8lLSHoSsovCspGH5E6o4.jpg',
                          label: 'Noodles',
                        ),
                        CategoryItem(
                          imageUrl:
                              'https://storage.googleapis.com/a1aa/image/TJGiZLhyTXmlPFV-mcQ1O1NJhKGVBYlCKvhgPfNhOxg.jpg',
                          label: 'Snacks',
                        ),
                        CategoryItem(
                          imageUrl:
                              'https://storage.googleapis.com/a1aa/image/LpHKxEsF0rrhVNuYTnfHovFYjTLMMoSfdWppiKEsq2M.jpg',
                          label: 'Biscuits',
                        ),
                        CategoryItem(
                          imageUrl:
                              'https://storage.googleapis.com/a1aa/image/KokLM16h8YkQFLwkXLXTx0L2tfH5zpyDBMhA0xtnvBk.jpg',
                          label: 'Junk Foods',
                        ),
                        CategoryItem(
                          imageUrl:
                              'https://storage.googleapis.com/a1aa/image/twZW0lgS5dzSZU6ZhBNGZ9Cg8ucQkGlI_2y5aWgV7u0.jpg',
                          label: 'Soft Drinks',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // PRODUCTS
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'Products',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ProductItem(
                        imageUrl:
                            'https://storage.googleapis.com/a1aa/image/hyeNtE8GyQWR7W0UH2WtBcHffM_aeKHo0RwRqU-1c9M.jpg',
                        quantity: 1,
                      ),
                      ProductItem(
                        imageUrl:
                            'https://storage.googleapis.com/a1aa/image/BSXhxyXbsGR8gup6rSbUBKyTGLFtlIJYUvxF1w-r7OU.jpg',
                      ),
                      ProductItem(
                        imageUrl:
                            'https://storage.googleapis.com/a1aa/image/YF37zjzxkArW99oVCrjhcPE7-zcK5thvb4YpVPC-bx8.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You are already on the Dashboard page.'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

// CATEGORY ITEM WIDGET
class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String label;

  CategoryItem({required this.imageUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Category tapped: $label');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Image.network(imageUrl, height: 50, width: 50),
            SizedBox(height: 5),
            Text(label),
          ],
        ),
      ),
    );
  }
}

// PRODUCT ITEM WIDGET
class ProductItem extends StatelessWidget {
  final String imageUrl;
  final int? quantity;

  ProductItem({required this.imageUrl, this.quantity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Product tapped: $imageUrl');
      },
      child: Stack(
        children: [
          Center(
            child: Image.network(imageUrl, height: 100, width: 100),
          ),
          if (quantity != null)
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.green[500],
                child: Text(
                  '$quantity',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

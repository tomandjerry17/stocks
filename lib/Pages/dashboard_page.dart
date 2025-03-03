import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'transactions_page.dart';
import 'history_page.dart';
import 'profile_page.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0; // Default selected tab (Dashboard)

  // Function to handle sign out
  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Navigation function for bottom tabs
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to corresponding page
    switch (index) {
      case 0:
        break; // Stay on Dashboard
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TransactionsPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to Profile
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Categories Section
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'), // New Profile Tab
        ],
      ),
    );
  }
}

// Category Widget
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

import 'package:flutter/material.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Account', style: TextStyle(
          color: Color(0xff181725), fontSize: 20, fontWeight: FontWeight.bold,
        )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xff53B175).withOpacity(0.2),
                      child: const Icon(Icons.person, size: 35, color: Color(0xff53B175)),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: const [
                            Text('Ahmed Eid', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff181725),
                            )),
                            SizedBox(width: 8),
                            Icon(Icons.edit_outlined, size: 18, color: Color(0xff53B175)),
                          ]),
                          const SizedBox(height: 4),
                          const Text('ahmed.eid@gmail.com', style: TextStyle(
                            fontSize: 14, color: Color(0xff7C7C7C),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, thickness: 1, color: Color(0xffE2E2E2)),
              _buildAccountTile(Icons.shopping_bag_outlined, 'Orders'),
              _buildAccountTile(Icons.badge_outlined, 'My Details'),
              _buildAccountTile(Icons.location_on_outlined, 'Delivery Address'),
              _buildAccountTile(Icons.credit_card_outlined, 'Payment Methods'),
              _buildAccountTile(Icons.confirmation_number_outlined, 'Promo Card'),
              _buildAccountTile(Icons.notifications_none_outlined, 'Notifecations'),
              _buildAccountTile(Icons.help_outline, 'Help'),
              _buildAccountTile(Icons.info_outline, 'About'),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged out successfully'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF2F3F2),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.logout, color: Color(0xff53B175), size: 22),
                        SizedBox(width: 15),
                        Text('Log Out', style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff53B175),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTile(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: const Color(0xff181725), size: 24),
          title: Text(title, style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff181725),
          )),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff181725)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xffE2E2E2)),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/cart_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Consumer2<UserModel, CartModel>(
          builder: (context, user, cart, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
                const SizedBox(height: 20),
                Text(user.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Points: ${user.points}', style: const TextStyle(fontSize: 18)),
                Text('Cart Items: ${cart.itemCount}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 30),
                if (user.isLoggedIn)
                  ElevatedButton(
                    onPressed: () {
                      user.logout();
                      cart.clear();
                    },
                    child: const Text('Logout'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      user.login('John Doe');
                    },
                    child: const Text('Login'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:e_commerce_app/colors/color.dart';
import 'package:e_commerce_app/firebase/firebase_instance.dart';

import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/order_screen.dart';
import 'package:e_commerce_app/screens/setting_screen.dart';
import 'package:e_commerce_app/widget/heading_text.dart';
import 'package:e_commerce_app/widget/subheading_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: FutureBuilder(
        future:
            Provider.of<UserProvider>(context, listen: false).fetchUserDataPf(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: SubHeadingText(text: snapshot.error.toString()),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<UserProvider>(
                    builder:
                        (BuildContext context, userProvider, Widget? child) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: HeadingText(text: 'My profile')),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                    NetworkImage('${userProvider.user.avatar}'),
                              ),
                              const SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userProvider.user.name}',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    '${userProvider.user.email}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (contex) => OrderScreen(),
                                ),
                              );
                            },
                            title: const Text('My Orders'),
                            subtitle: Text('Already have 12 orders'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingScreen(),
                                ),
                              );
                            },
                            title: const Text('My Profile'),
                            subtitle:
                                const Text('Update your personal information'),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                          const ListTile(
                            title: Text('Change Password'),
                            subtitle: Text('Change your account password'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          const ListTile(
                            title: Text('Notifications'),
                            subtitle:
                                Text('Configure your notification preferences'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          const ListTile(
                            title: Text('Privacy'),
                            subtitle:
                                Text('View and manage your privacy settings'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          const ListTile(
                            title: Text('Help & Support'),
                            subtitle: Text('Contact customer support'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            onTap: () {
                              FirebaseInstance.auth.signOut();
                            },
                            title: const Text('Log Out'),
                            leading: const Icon(Icons.logout_outlined),
                          ),
                        ],
                      );
                    },
                  )),
            );
          }
        },
      ),
    );
  }
}

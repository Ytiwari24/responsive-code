import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerList extends StatelessWidget {
  DrawerList({super.key});
  List tileData = [
    {'title': 'Profile', 'icon': Icons.person_outline},
    {'title': 'Add Family', 'icon': Icons.person_outline},
    {'title': 'Donation', 'icon': Icons.person_outline},
    {'title': 'About Ahir Seva', 'icon': Icons.person_outline},
    {'title': 'Language', 'icon': Icons.person_outline},
    {'title': 'Terms & Conditions', 'icon': Icons.person_outline},
    {'title': 'Privacy Policy', 'icon': Icons.person_outline},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
            accountName: Text('Pravind Bhardwaj'),
            accountEmail: Text('pravind@gmail.com')),
        for (int i = 0; i < tileData.length; i++) ...[
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(
              '${tileData[i]['title']}',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: const Color(0xff001427)),
            ),
          )
        ]
      ],
    );
  }
}

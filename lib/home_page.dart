import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'drawer_list.dart';
import 'upcoming_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var wrapList = [
    {'title': 'Upcoming Events', 'icon': Icons.home},
    {'title': 'Birthday / Anniversary', 'icon': Icons.home},
    {'title': 'Working Committee', 'icon': Icons.home},
    {'title': 'Gallery', 'icon': Icons.home},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title ?? ''),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: DrawerList(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 144.h,
              color: Colors.amber,
            ),
            SizedBox(
              height: 10.h,
            ),
            Wrap(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  InkWell(
                    onTap: () {
                      if (i == 0) {
                        Get.to(() => const UpcomingEvents());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      margin: EdgeInsets.all(10.r),
                      height: 157.w,
                      width: 159.w,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.all(Radius.circular(7.w)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 35.h,
                            width: 35.h,
                            child: Icon(
                              wrapList[i]['icon'] as IconData?,
                              size: 35.w,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${wrapList[i]['title']}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                              radius: 22.5.w,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 24.w,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Advertisements',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            Container(
              height: 137.h,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upcoming Events',
          style: TextStyle(
              color: const Color(0xff001427),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 5; i++) ...[
              Container(
                margin: EdgeInsets.all(10.w),
                padding: EdgeInsets.symmetric(vertical: 10.w),
                decoration: BoxDecoration(color: Colors.red.withOpacity(.1)),
                child: ListTile(
                  title: Text(
                    'Event Name',
                    style: TextStyle(
                        color: const Color(0xff001D49),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        'Initialize and set the fit size and font size to scale according to the system\'s "font size" accessibility option',
                        style: TextStyle(
                            color: const Color(0xff292929),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18.w,
                          ),
                          Text(
                            '02-01-2000',
                            style: TextStyle(
                                color: const Color(0xffCB333C),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18.w,
                          ),
                          Text(
                            'Bhandup',
                            style: TextStyle(
                                color: const Color(0xffCB333C),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

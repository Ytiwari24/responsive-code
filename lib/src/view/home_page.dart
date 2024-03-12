import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.read<HomeBloc>().state is DataLoadedState
            ? 'Data Loaded'
            : 'Loading...'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is DataLoadedState) {
            return _buildContent(state.wrapList);
          } else if (state is ErrorState) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildContent(List<Map<String, dynamic>> wrapList) {
    return SingleChildScrollView(
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
              for (int i = 0; i < wrapList.length; i++) ...[
                InkWell(
                  onTap: () {
                    // Handle onTap based on index
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
    );
  }
}

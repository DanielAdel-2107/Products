import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/injection.dart';
import 'package:task/view_models/product_cubit/product_cubit.dart';
import 'views/product_page.dart';

void main() {
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => product<ProductCubit>()..fetchProducts(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Product App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const ProductPage(),
          ),
        );
      },
    );
  }
}

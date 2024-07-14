import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/view_models/product_cubit/product_cubit.dart';
import 'package:task/view_models/product_cubit/product_state.dart';
import 'package:task/views/product_detail_pdage.dart';
import 'package:task/views/widgets/product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(16.0)),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<ProductCubit, ProductState>(
                    builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(16.0)),
                                    border: Border.all(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenUtil().setWidth(16.0)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            onChanged: (value) {
                                              context
                                                  .read<ProductCubit>()
                                                  .filterProducts(
                                                      nameQuery: value);
                                            },
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.search,
                                                  color: Colors.blue),
                                              hintText:
                                                  'What do you search for?',
                                              contentPadding:
                                                  EdgeInsets.all(16),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.shopping_cart),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 2 / 3,
                            ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductCard(
                                product: product,
                                onFavoriteToggle: () {
                                  context
                                      .read<ProductCubit>()
                                      .toggleFavorite(product.id);
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailPage(product: product),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No products found'));
                }, listener: (context, state) {
                  if (state is ProductError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

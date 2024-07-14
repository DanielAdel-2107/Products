import 'package:flutter/material.dart';
import 'package:task/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(
              color: Colors.blue,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.thumbnail != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        product.thumbnail!,
                        height: 90.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    product.description ?? 'No description available.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  const SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EGP ${(product.originalPrice * (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      Text(
                        '\$${product.originalPrice} EGP',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Stack(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rating: (${product.rating?.toString() ?? 'No rating'}) ',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const Icon(
                            size: 14.0,
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: CircleAvatar(
                              backgroundColor: Colors.blue[900],
                              radius: 12,
                              child: const Icon(
                                Icons.add,
                                size: 12,
                                color: Colors.white,
                              )))
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isFavorite ? Colors.red : null,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

class TransactionDetails extends Equatable {
  final int productId;
  final String productType;
  final String productName;
  final String category;
  final String subCategory;
  final String worker;
  final num quantity;
  final num price;
  final num total;

  const TransactionDetails(
      {required this.productName,
      required this.category,
      required this.subCategory,
      required this.productId,
      required this.productType,
      required this.quantity,
      required this.price,
      required this.worker,
      required this.total});

  @override
  List<Object> get props => [
        productId,
        productType,
        productName,
        category,
        subCategory,
        worker,
        quantity,
        price,
        total,
      ];
}

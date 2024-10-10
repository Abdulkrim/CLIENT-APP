import 'package:equatable/equatable.dart';

class CashierReport extends Equatable{
  final String cashierName;
  final String cashierId;
  final int count;
  final num sumPrice;

  const CashierReport({required this.cashierName,required this.cashierId,required this.count,required this.sumPrice});

  @override
  List<Object> get props => [cashierName , cashierId , count , sumPrice];
}
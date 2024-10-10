import 'package:equatable/equatable.dart';
import 'package:merchant_dashboard/feature/region/data/models/entity/city.dart';
import 'package:merchant_dashboard/utils/mixins/mixins.dart';

import '../../../../../injection.dart';
import '../../../../../utils/mixins/date_time_utilities.dart';
import '../../../../main_screen/presentation/blocs/main_screen_bloc.dart';

class CustomerListInfo {
  final int currentPageNumber;
  final int totalPageCount;

  final List<Customer> customers;

  CustomerListInfo({required this.currentPageNumber, required this.totalPageCount, required this.customers});
}

class Customer extends Equatable with ProfileBGColorGenerator , DateTimeUtilities{
  final String id;
  final String name;
  final String phoneNumber;

  String get phoneNumberWithoutPrefix =>
      phoneNumber.startsWith('+971') ? phoneNumber.substring(4, phoneNumber.length) : phoneNumber;
  final int customerTypeId;
  final String customerTypeName;
  final bool gender;
  final CustomerAddress? customerAddress;
  final String email;
  final num balance;
  final num ordersCount;
  final num transactionsCount;

  final String lastOrderDate;
  String get lastOrderDateFormatted => convertDateFormat(lastOrderDate);
  final String lastTransactionDate;
  String get lastTransactionDateFormatted => convertDateFormat(lastTransactionDate);

  final num addressesCount;
  final num loyaltyPointCount;

    String get  balanceWithCurrency => '$balance ${getIt<MainScreenBloc>().branchGeneralInfo?.currency}';

  const Customer(
      {required this.id,
      required this.name,
      required this.balance,
      required this.gender,
      required this.customerTypeName,
      required this.lastOrderDate,
      required this.lastTransactionDate,
      required this.customerTypeId,
      required this.phoneNumber,
      required this.customerAddress,
      required this.ordersCount,
      required this.transactionsCount,
      required this.addressesCount,
      required this.loyaltyPointCount,
      required this.email});

  @override
  List<Object?> get props => [id, name, phoneNumber, customerAddress, email, customerTypeName, balance];
}

class CustomerAddress extends Equatable {
  final City city;
  final String location;
  final String street;
  final String district;
  final String flat;
  final String buildingName;
  final String completeAddress;
  final String fullAddress;
  final int addressId;

  const CustomerAddress(
      {required this.city,
      required this.location,
      required this.street,
      required this.district,
      required this.flat,
      required this.buildingName,
      required this.completeAddress,
      required this.fullAddress,
      required this.addressId});

  @override
  List<Object> get props => [city, location, street, district, flat, buildingName, completeAddress, fullAddress, addressId];
}

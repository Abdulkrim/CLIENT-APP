import 'package:json_annotation/json_annotation.dart';

import '../../../../../region/data/models/response/city/cities_response.dart';
import '../../entity/customer_list_info.dart';

part 'customers_response.g.dart';

@JsonSerializable()
class CustomersResponse {
  @JsonKey(name: 'value')
  List<CustomerInfoResponse>? customers;
  int? currentPageNumber;
  int? totalPageCount;

  CustomersResponse({this.customers, this.currentPageNumber, this.totalPageCount});

  factory CustomersResponse.fromJson(Map<String, dynamic> json) => _$CustomersResponseFromJson(json);

  CustomerListInfo toEntity() => CustomerListInfo(
      currentPageNumber: currentPageNumber ?? 1,
      totalPageCount: totalPageCount ?? 1,
      customers: customers?.map((e) => e.toEntity()).toList() ?? []);
}

class CustomerInfoResponse {
  String? id;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? birtDate;
  bool? gender;
  String? carPlate;
  String? lastTransactionDate;
  String? lastOrderDate;
  num? customerBalance;
  CustomerType? customerType;
  CustomerAddressResponse? latestAddress;
  int? ordersCount;
  int? transactionsCount;
  int? addressCount;
  int? loyaltyScore;

  CustomerInfoResponse(
      {this.id,
      this.fullname,
      this.email,
      this.phoneNumber,
      this.birtDate,
      this.gender,
      this.customerBalance,
      this.carPlate,
      this.customerType,
      this.latestAddress});

  CustomerInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    birtDate = json['birtDate'];
    gender = json['gender'];
    customerBalance = json['customerBalance'];
    carPlate = json['carPlate'];
    customerType = CustomerType.fromJson(json['customerType']);
    ordersCount = json['ordersCount'];
    transactionsCount = json['transactionsCount'];
    addressCount = json['addressCount'];
    lastOrderDate = json['lastOrderDate'];
    lastTransactionDate = json['lastTransactionDate'];
    loyaltyScore = json['loyaltyScore'];
    latestAddress = json['defaultAddress'] != null || json['customerAddresses'] != null ?   CustomerAddressResponse.fromJson(json['defaultAddress'] ??
        (json['customerAddresses']?.isNotEmpty ? json['customerAddresses'][0] : null)) : null;
  }

  Map<String, dynamic> toJson() => {};

  Customer toEntity() => Customer(
      id: id ?? '',
      name: fullname ?? '',
      phoneNumber: phoneNumber ?? '',
      customerTypeId: customerType?.id ?? 0,
      balance: customerBalance ?? 0,
      lastOrderDate: lastOrderDate ?? '',
      lastTransactionDate: lastTransactionDate ?? '',
      customerTypeName: customerType?.type ?? '',
      gender: gender ?? false,
      customerAddress: latestAddress?.toEntity(),
      addressesCount: addressCount ?? 0,
      ordersCount: ordersCount ?? 0,
      transactionsCount: transactionsCount ?? 0,
      loyaltyPointCount: loyaltyScore ?? 0,
      email: email ?? '');
}

class CustomerType {
  int? id;
  String? type;

  CustomerType.fromJson(Map<String, dynamic>? json)
      : id = json?['id'],
        type = json?['type'];
}

class CustomerAddressResponse {
  CityItemResponse? city;
  String? location;
  String? street;
  String? district;
  String? flat;
  String? buildingName;
  String? completeAddress;
  String? createdOn;
  String? fullAddress;
  int? addressId;

  CustomerAddressResponse(
      {this.city,
      this.location,
      this.street,
      this.district,
      this.flat,
      this.buildingName,
      this.completeAddress,
      this.createdOn,
      this.fullAddress,
      this.addressId});

  CustomerAddress toEntity() => CustomerAddress(
      city: city!.toEntity(),
      location: location ?? '',
      street: street ?? '',
      district: district ?? '',
      flat: flat ?? '',
      buildingName: buildingName ?? '',
      completeAddress: completeAddress ?? '',
      fullAddress: fullAddress ?? '',
      addressId: addressId ?? 0);

  CustomerAddressResponse.fromJson(Map<String, dynamic>? json) {
    city = CityItemResponse.fromJson(json?['city']);
    location = json?['location'] ?? '';
    street = json?['street'] ?? '';
    district = json?['district'] ?? '';
    flat = json?['flat'] ?? '';
    buildingName = json?['buildingName'] ?? '';
    completeAddress = json?['completeAddress'] ?? '-';
    createdOn = json?['createdOn'] ?? '';
    fullAddress = json?['fullAddress'] ?? '';
    addressId = json?['addressId'] ?? 0;
  }

  Map<String, dynamic> toJson() => {};
}

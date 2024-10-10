class CustomerParameter {
  final String? customerId;
  final int? addressId;
  final String customerName;
  final int gender;
  final int? customerType;
  final String phoneNumber;
  final String email;
  final int cityId;
  final String location;
  final String street;
  final String district;
  final String flat;
  final String buildingName;
  final String completeAddress;

  const CustomerParameter.create(
      {required this.customerName,
      required this.gender,
        this.customerType,
      required this.phoneNumber,
      required this.email,
      required this.location,
      required this.street,
      required this.district,
      required this.flat,
      required this.buildingName,
      required this.completeAddress,
      required this.cityId})
      : customerId = null,
        addressId = null;

  const CustomerParameter.edit(
      {required this.customerId,
      required this.addressId,
      required this.customerName,
      required this.gender,
        this.customerType,
      required this.phoneNumber,
      required this.email,
      required this.location,
      required this.street,
      required this.district,
      required this.flat,
      required this.buildingName,
      required this.completeAddress,
      required this.cityId});

  Map<String, dynamic> toCreateJson() => {
        'fullname': customerName,
        'gender': gender,
        'customerType': customerType,
        'phone': phoneNumber,
        'Email': email,
        'address': {
          'cityId': cityId,
          'location': location,
          'street': street,
          'district': district,
          'flat': flat,
          'buildingName': buildingName,
          'completeAddress': completeAddress,
        },
      };

  Map<String, dynamic> toEditJson() => {
        'customerId': customerId,
        'fullname': customerName,
        'gender': gender,
        'customerType': customerType,
        'phone': phoneNumber,
        'Email': email,
        'address': {
          'addressId': addressId,
          'cityId': cityId,
          'location': location,
          'street': street,
          'district': district,
          'flat': flat,
          'buildingName': buildingName,
          'completeAddress': completeAddress,
        },
      };
}

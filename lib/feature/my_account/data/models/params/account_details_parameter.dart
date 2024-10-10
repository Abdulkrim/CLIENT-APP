class AccountDetailsParameter{
  final String merchantId;

  AccountDetailsParameter({ required this.merchantId});

  Map<String, dynamic> toJson() => {
    'id': merchantId,
  };
}
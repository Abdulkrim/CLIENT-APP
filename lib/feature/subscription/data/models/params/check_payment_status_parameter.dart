class CheckPaymentStatusParameter{
  final String payId;

  CheckPaymentStatusParameter({required this.payId});

  Map<String , dynamic> toJson()=> {
    'paymentId': payId
  };
}
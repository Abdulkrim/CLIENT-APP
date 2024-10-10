class CustomerCreditHistoriesParameter {
  final String customerId;
  final String fromDate;
  final String toDate;

  CustomerCreditHistoriesParameter({required  this.customerId,required this.fromDate,required this.toDate});

  Map<String , dynamic> toJson() => {
    'customerId':  customerId ,
    'from': fromDate ,
    'to': toDate ,
  };
}

import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class CreateCustomerPaymentParameter extends MerchantBranchParameter {
  final String customerId;
  final List<({int paymentModeId, num amount, String? refrenceNumber})> selectedPaymentTypes;

  CreateCustomerPaymentParameter({required this.customerId, required this.selectedPaymentTypes});

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "paymentInfo": selectedPaymentTypes
            .map((e) => {"paymentModeId": e.paymentModeId, "amount": e.amount, "referenceNumber": e.refrenceNumber})
            .toList(),
      };
}

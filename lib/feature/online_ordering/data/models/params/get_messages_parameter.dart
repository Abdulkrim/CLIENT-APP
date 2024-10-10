import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class GetMessagesParameter extends MerchantBranchParameter{
  final int _messageTypeId;

  GetMessagesParameter.closeMessages(): _messageTypeId = 1;

  Map<String ,dynamic> toJson()=> {
    ...?super.branchToJson(),
    'messageTypeId': _messageTypeId,
  };
}
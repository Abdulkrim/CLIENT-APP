import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

class UpdateMessagesSettingsParameter extends MerchantBranchParameter{
  final String enMessage;
  final String frMessage;
  final String trMessage;
  final String arMessage;
  final int _messageTypeId;

  UpdateMessagesSettingsParameter.closingMessage(
      {required this.enMessage, required this.frMessage, required this.trMessage, required this.arMessage})
      : _messageTypeId = 1;

  Map<String ,dynamic> toJson() => {
    ...?super.branchToJson(),
    'messageTypeId': _messageTypeId,
    'nameInLanguages': [
      if (enMessage.isNotEmpty){'languageId': 1 , 'message': enMessage},
      if (arMessage.isNotEmpty)   {'languageId': 2 , 'message': arMessage},
      if (frMessage.isNotEmpty)   {'languageId': 3 , 'message': frMessage},
      if (trMessage.isNotEmpty)   {'languageId': 4 , 'message': trMessage},
    ]
  };
}

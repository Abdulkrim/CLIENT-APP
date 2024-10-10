import 'package:image_picker/image_picker.dart';
import 'package:merchant_dashboard/feature/dashboard/data/models/params/merchant_branch_parameter.dart';

import '../../../../../utils/mixins/date_time_utilities.dart';

class EditExpenseParameter extends MerchantBranchParameter with DateTimeUtilities {
  final int expenseId;
  final int expenseTypeId;
  final int pementModeId;
  final String amount;
  final String note;
  final String date;
  final XFile? file;

  EditExpenseParameter({
    required this.expenseId,
    required this.expenseTypeId,
    required this.amount,
    required this.file,
    required this.note,
    required this.date,
    required this.pementModeId,
  });

  Map<String, dynamic> toJson() => {
        ...?super.branchToJson(),
        'Id': expenseId,
        'ExpenseTypeId': expenseTypeId,
        'Amount': amount,
        'Date': getFilterFormatDate(date),
        'PaymentModeId': pementModeId,
        'Note': note,
      };
}

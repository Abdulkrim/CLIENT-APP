import '../../../../../core/constants/defaults.dart';
import '../../../../../injection.dart';
import '../../../../auth/data/data_sources/login_local_datasource.dart';

class MerchantBranchParameter {
  final String _branchId;

  final String _businessId;

  String get businessId => _businessId.isNotEmpty
      ? _businessId
      : getIt<ILoginLocalDataSource>().isLoggedInUserBusiness()
          ? getIt<ILoginLocalDataSource>().getUserId()
          : getIt<ILoginLocalDataSource>().getBusinessId();

  String get branchId =>
      _branchId.isNotEmpty ? _branchId : getIt<ILoginLocalDataSource>().getSelectedMerchantId();

  MerchantBranchParameter({String businessId = '', String branchId = ''})
      : _businessId = businessId,
        _branchId = branchId;

  Map<String, dynamic>? businessToJson() => (businessId.isNotEmpty)
      ? {
          'BusinessId': businessId,
        }
      : null;

  Map<String, dynamic>? branchToJson() => (branchId.isNotEmpty)
      ? {
          'branchId': branchId,
        }
      : null;

  Map<String, dynamic>? toLogicalJson() => (branchId.isNotEmpty)
      ? {
          "logical": LogicalOperator.and.value,
          "operator": QueryOperator.equals.value,
          "value": branchId,
          "propertyName": "branchId"
        }
      : null;

  /// This function just used temporarily for the Product/GetHierarchyProducts api to get response and set a [branchId] always
  Map<String, dynamic>? forProductsToJson() =>
      (branchId.isEmpty && getIt<ILoginLocalDataSource>().isLoggedInUserBusiness())
          ? null
          : {
              'branchId': (branchId.isNotEmpty) ? branchId : getIt<ILoginLocalDataSource>().getUserId(),
            };
}

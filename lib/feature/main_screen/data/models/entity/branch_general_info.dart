import 'package:equatable/equatable.dart';

class BranchGeneralInfo extends Equatable {
  final String currency;
  final String businessType;
  final int businessTypeId;
  final String branchId;
  final String domainAddress;

  bool get isRestaurants => businessType.toLowerCase() == 'restaurants';

  const BranchGeneralInfo(
      {required this.currency,
      required this.businessType,
      required this.domainAddress,
      required this.businessTypeId,
      required this.branchId});

  @override
  List<Object> get props => [
        currency,
        businessType,
        businessTypeId,
        domainAddress,
        branchId,
      ];
}

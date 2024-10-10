
import '../../../../../core/client/parameter/base_filter_parameter.dart';

class GetProductsByTypeParameter extends BaseFilterListParameter {
  final int typeId;

  GetProductsByTypeParameter({required this.typeId, required super.page, required super.count});

  Map<String, dynamic> itemsByTypeToJson() => {
        ...?super.branchToJson(),
        'typeId': typeId,
      };
}

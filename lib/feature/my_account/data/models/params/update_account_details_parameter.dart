class UpdateAccountDetailsParameter {
  final String fieldKey;
  final String fieldValue;
  final String userId;

  UpdateAccountDetailsParameter({
    required this.fieldKey,
    required this.fieldValue,
    required this.userId,
  });



  Map<String, dynamic> qToJson() => {
        'id': userId,
      };

  Map<String, dynamic> toJson() => {
        fieldKey: fieldValue,
      };
}

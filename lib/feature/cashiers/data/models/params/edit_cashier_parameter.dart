class EditCashierParameter {
  final String id;
  final String name;

  final int roleId;
  final bool status;

  EditCashierParameter({required this.id, required this.name, required this.roleId, required this.status});

  Map<String, dynamic> toJson() => {
        "cashierName": name,
        "PosRoleId": roleId,
        "Isactive": status,
      };
}

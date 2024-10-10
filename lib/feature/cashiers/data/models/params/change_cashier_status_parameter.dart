class   ChangeCashierStatusParameter {

  final String id;
  final bool status;

  ChangeCashierStatusParameter({required this.id, required this.status});

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

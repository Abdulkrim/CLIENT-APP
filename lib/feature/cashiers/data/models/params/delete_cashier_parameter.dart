class DeleteCashierParameter {
  final int id;

  DeleteCashierParameter({
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

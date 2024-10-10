class DateRangeParameter {
  final String startDate;
  final String endDate;

  DateRangeParameter({required this.startDate, required this.endDate});

  Map<String, dynamic> toJson() => {
        'from': startDate,
        'to': endDate,
      };
}

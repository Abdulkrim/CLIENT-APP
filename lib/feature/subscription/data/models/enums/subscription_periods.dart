enum SubscriptionPeriods {
  monthly(0, 2),
  yearly(1, 0);

  const SubscriptionPeriods(this.valueIndex, this.value);

  final int valueIndex;
  final int value;
}

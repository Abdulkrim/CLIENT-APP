enum Claim {
  falseClaim(0, "False"),
  autoClaim(1, "Auto");

  const Claim(this.value, this.title);

  final int value;
  final String title;
}

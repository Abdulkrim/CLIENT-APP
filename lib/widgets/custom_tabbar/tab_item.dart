final class TabItem {
  final String title;
  final Function(int index)? onTap;

  TabItem(this.title, [this.onTap]);
}

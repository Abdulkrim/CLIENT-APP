class BusinessType {
  final int id;
  final String name;
  final String imageUrl;

  const BusinessType({required this.id, required this.name, required this.imageUrl});

  const BusinessType.firstItem()
      : id = 0,
        name = 'Select Business Type',
        imageUrl = '';
}

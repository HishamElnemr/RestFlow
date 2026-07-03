class MenuProduct {
  const MenuProduct({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.status,
    this.imageAsset,
  });

  final String title;
  final String subtitle;
  final String price;
  final String status;
  final String? imageAsset;
}

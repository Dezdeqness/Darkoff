class ItemMiniInfo {
  const ItemMiniInfo({
    required this.id,
    this.name,
    this.shortName,
    this.iconLink,
    this.price,
  });

  final String id;
  final String? name;
  final String? shortName;
  final String? iconLink;
  final int? price;
}

class SellerOrder {
  const SellerOrder({
    required this.id,
    required this.itemCount,
    required this.total,
    required this.status,
  });

  final String id;
  final int itemCount;
  final int total;
  final String status;
}

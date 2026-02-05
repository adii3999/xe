class Money {
  const Money(this.amount);

  final int amount;

  @override
  String toString() => '₹$amount';
}

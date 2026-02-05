class Address {
  const Address({
    required this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.pincode,
  });

  final String line1;
  final String? line2;
  final String city;
  final String state;
  final String pincode;
}

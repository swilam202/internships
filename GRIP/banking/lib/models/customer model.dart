class CustomerModel {
  final int id;
  final String name;
  final String email;
  final double balance;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      balance: map['balance'],
    );
  }
}

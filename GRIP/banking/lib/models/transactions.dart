class TransactionModel {
  final int id;
  final String sender;
  final String receiver;
  final double amount;

  const TransactionModel({
    required this.id,
    required this.amount,
    required this.receiver,
    required this.sender,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      receiver: map['receiver'],
      sender: map['sender'],
    );
  }
}

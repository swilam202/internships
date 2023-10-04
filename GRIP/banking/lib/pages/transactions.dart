import 'package:flutter/material.dart';

import '../core/sqldatabase.dart';
import '../models/transactions.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  Future<List> getTransactions() async {
    SqlDB sqlDB = SqlDB();
    return await sqlDB.query('transactions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Transaction History'),
      ),
      body: FutureBuilder(
        future: getTransactions(),
        builder: (context, snapshot) {
          if (!(snapshot.hasData)) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<TransactionModel> transactions = List.from(
              snapshot.data!.map(
                (e) => TransactionModel.fromMap(e),
              ),
            );
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 202, 208, 171),
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('images/user.png'),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              transactions[index].sender,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.forward,
                              size: 30,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              transactions[index].amount.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('images/user.png'),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              transactions[index].receiver,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

import '../core/sqldatabase.dart';
import '../models/customer model.dart';
import 'customers list.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({
    super.key,
    required this.customer,
    required this.allCustomers,
  });

  final CustomerModel customer;
  final List<CustomerModel> allCustomers;

  @override
  Widget build(BuildContext context) {
    List<CustomerModel> customers = [];
    for (int i = 0; i < allCustomers.length; i++) {
      if (allCustomers[i].id != customer.id) {
        customers.add(allCustomers[i]);
      }
    }
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              AnimatedRadialGauge(
                duration: const Duration(seconds: 3),
                value: customer.balance,
                curve: Curves.linear,
                radius: MediaQuery.of(context).size.width * 0.4,
                axis: const GaugeAxis(
                  min: 0,
                  max: 1000000,
                  degrees: 180,
                  style: GaugeAxisStyle(
                    thickness: 20,
                    background: Color(0xFFDFE2EC),
                    segmentSpacing: 4,
                  ),
                ),
                child: Text(
                  customer.balance.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/user.png'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 30),
              Text(
                customer.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => showTransBottomSheet(context, customers),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(8),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.amber),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.yellow[500]),
                  animationDuration: const Duration(seconds: 5),
                ),
                child: const Text(
                  'Transfer money',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showTransBottomSheet(BuildContext context, List<CustomerModel> customers) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: customers.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController controller =
                              TextEditingController();
                          return CupertinoAlertDialog(
                            title: CupertinoTextField(
                              controller: controller,
                              keyboardType: TextInputType.phone,
                            ),
                            actions: [
                              CupertinoButton(
                                onPressed: () async {
                                  if (double.parse(controller.text) <=
                                      customer.balance.toDouble()) {
                                    SqlDB sqlDB = SqlDB();
                                    double senderBalance = customer.balance -
                                        double.parse(controller.text);
                                    double receiverBalance =
                                        customers[index].balance +
                                            double.parse(controller.text);
                                    double transAmount =
                                        double.parse(controller.text);
                                    await sqlDB.update(
                                      customer.id,
                                      {
                                        'balance': senderBalance,
                                      },
                                    );
                                    await sqlDB.update(
                                      customers[index].id,
                                      {
                                        'balance': receiverBalance,
                                      },
                                    );
                                    await sqlDB.insert({
                                      'sender': customer.name,
                                      'receiver': customers[index].name,
                                      'amount': transAmount,
                                    }, 'transactions');
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomersList(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Transfer'),
                              ),
                            ],
                          );
                        });
                  },
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/user.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(
                    customers[index].name,
                    style: const TextStyle(fontSize: 23),
                  ),
                  trailing: const Icon(Icons.forward),
                ),
              );
            },
          );
        });
  }
}

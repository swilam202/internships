import 'package:banking/core/sqldatabase.dart';
import 'package:banking/models/customer%20model.dart';
import 'package:banking/pages/customer%20details.dart';
import 'package:flutter/material.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    /* List names = [
      'Mahmoud swilam',
      'Ahmed ali',
      'Mostafa amr',
      'baraa ahmed',
      'abdo adel'
    ];
    List emails = [
      'Mahmoudswilam@gmail.com',
      'Ahmedali@gmail.com',
      'Mostafaamr@gmail.com',
      'baraaahmed@gmail.com',
      'abdoadel@gmail.com'
    ];
    List balances = [6534.4, 5452.5, 48544, 88320, 32250.1];*/

    SqlDB sqlDB = SqlDB();

    Future<List> getUsers() async {
      return await sqlDB.query();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Customers'),
          /* actions: [
          ElevatedButton(
            onPressed: () async {


              for(int i = 0;i < 5;i++){
               await sqlDB.insert({
                'name':names[i],
                'email':emails[i],
                'balance':balances[i],
              });
              }
              print(await sqlDB.query());
            },
            child: Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () async {



               await sqlDB.deleteDataBasess();

            },
            child: Icon(Icons.delete)
          ),
        ],*/
        ),
        body: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (!(snapshot.hasData)) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<CustomerModel> customers = List.from(
                snapshot.data!.map(
                  (e) => CustomerModel.fromMap(e),
                ),
              );
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CustomerDetailsPage(
                          customer: customers[index],
                          allCustomers: customers,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 202, 208, 171),
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('images/user.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  customers[index].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  customers[index].email,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${customers[index].balance.toStringAsFixed(1)} \$',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}

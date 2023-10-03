import 'package:banking/pages/customer%20details.dart';
import 'package:flutter/material.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Customers'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CustomerDetailsPage(),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 202, 208, 171),
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/user.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mahmoud Swilam',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'mahmoudswilam02@gmail.com',
                          style: TextStyle(
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
                    '255.8 \$',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

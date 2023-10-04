import 'package:banking/core/sqldatabase.dart';
import 'package:banking/models/customer%20model.dart';
import 'package:banking/pages/home%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

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
    allCustomers.removeWhere((element) => element.id == customer.id);
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
                  max: 100000,
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
                onPressed: () {

                  showModalBottomSheet(context: context, builder: (context){
                    return ListView.builder(
                      itemCount: allCustomers.length,
                      itemBuilder: (context,index) {
                        return ListTile(
                          onTap: (){
                            showCupertinoDialog(context: context, builder: (context){
                              TextEditingController controller = TextEditingController();
                              return CupertinoAlertDialog(
                                title: Text('Transfer'),
                                actions: [
                                  CupertinoTextField(
                                    controller: controller,
                                   keyboardType: TextInputType.phone,
                                  ),

                                  CupertinoButton(onPressed: ()async{

                                     if(double.parse(controller.text) <= customer.balance.toDouble()){
                                      SqlDB sqlDB = SqlDB();
                                      double senderBalance = customer.balance - double.parse(controller.text);
                                      double receiverBalance = allCustomers[index].balance + double.parse(controller.text);
                                      print(senderBalance);
                                      print(receiverBalance);
                                     await sqlDB.update(customer.id, {'balance': senderBalance,},);
                                     await sqlDB.update(allCustomers[index].id, {'balance': receiverBalance,},);
                                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyHomePage(),),);
                                    }



                                  }, child: Text('submit'),),
                                ],
                              );

                            });
                          },
                          leading: const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('images/user.png'),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(allCustomers[index].name,style: TextStyle(fontSize: 23),),
                          trailing: Icon(Icons.forward),
                        );
                      },
                    );
                  });

                },
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
}

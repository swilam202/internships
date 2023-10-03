import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({super.key,required this.data,});
  final Map<String,dynamic> data;
  @override
  Widget build(BuildContext context) {
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
                value: data['balance'],
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
                child:  Text(
                  data['balance'].toString(),
                  style: TextStyle(
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
                data['name'].toString(),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.clip,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
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
                backgroundColor: MaterialStateProperty.all(Colors.yellow[500]),
                animationDuration: const Duration(seconds: 5),
              ),
                child: Text(
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

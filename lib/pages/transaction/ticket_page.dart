import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class Ticket extends StatelessWidget {
  const Ticket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransactionTicketPage(),
    );
  }
}

class TransactionTicketPage extends StatelessWidget {
  const TransactionTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/onboard/background/bgOnboard3.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: TicketWidget(
              width: 350,
              height: 600,
              isCornerRounded: true,
              padding: EdgeInsets.all(20),
              child: TicketData(),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Museum Seni Islam Indonesia',
            style: TextStyle(
                color: Color.fromRGBO(68, 68, 68, 1),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: ticketDetailsWidget(
                    'Quantity', '4', 'Date', '11 Juni 2022'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 53.0),
                child: ticketDetailsWidget(
                    'Price', 'Rp.302.500', 'Transaction Code', '0113344343'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
          child: Container(
            width: 250.0,
            height: 250.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/barcode.png'),
                    fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(252, 180, 42, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  minimumSize: const Size(300, 50),
                ),
                onPressed: () {},
                child: const Text(
                  "Save Ticket",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}

import 'package:digium/models/argument_model.dart';
import 'package:digium/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:intl/intl.dart';

class TransactionPaymentPage extends StatefulWidget {
  const TransactionPaymentPage({Key? key}) : super(key: key);

  @override
  State<TransactionPaymentPage> createState() => _TransactionPaymentPageState();
}

class _TransactionPaymentPageState extends State<TransactionPaymentPage> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as TransactionDetailArgument;
    final transaction = arguments.transaction;
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    NumberFormat formatter = NumberFormat("00000000");
    TransactionProvider _transactionProvider =
        Provider.of<TransactionProvider>(context);

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
          Center(
            child: TicketWidget(
              width: 350,
              height: 600,
              isCornerRounded: true,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      transaction.museum!.name,
                      style: const TextStyle(
                        color: Color.fromRGBO(68, 68, 68, 1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget(
                            'Quantity',
                            transaction.qty.toString(),
                            'Date',
                            DateFormat('d MMMM yyyy hh:mm', "id_ID")
                                .format(transaction.createdAt),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget(
                            'Due Date',
                            DateFormat('d MMMM yyyy hh:mm', "id_ID").format(
                              transaction.createdAt.add(
                                const Duration(days: 1),
                              ),
                            ),
                            'Transaction Code',
                            "TRXDG-${formatter.format(transaction.id)}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Text(
                      'Payment',
                      style: TextStyle(
                        color: Color.fromRGBO(68, 68, 68, 1),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 34,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/transaction/mandiri_bank.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        bankDetailsWidget(
                            "123 000 1234567", "a/n Kurniadi Ahmad Wijaya")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 35.0, left: 10.0, right: 10.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/transaction/line.png',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 30.0, right: 30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            minimumSize: const Size(300, 80),
                          ),
                          onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
                            // Pick an image
                            final XFile? selectedImage = await _picker
                                .pickImage(source: ImageSource.gallery);
                            setState(() {
                              _image = selectedImage;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.receipt,
                                size: 30.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Upload Receipt",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 20.0, right: 20.0),
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(42, 188, 247, 1),
                            width: 3),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Price You Should Pay",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              formatCurrency.format(transaction.totalPrice),
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(68, 68, 68, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 30.0, right: 30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: _image != null
                                ? const Color.fromRGBO(252, 180, 42, 1)
                                : const Color.fromRGBO(252, 180, 42, 1),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            minimumSize: const Size(300, 50),
                          ),
                          onPressed: () async {
                            try {
                              await _transactionProvider.uploadReceipt(
                                transactionId: transaction.id,
                                file: _image!,
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
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
      Column(
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
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      )
    ],
  );
}

Widget bankDetailsWidget(
  String firstTitle,
  String firstDesc,
) {
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
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

import 'package:digium/constants/theme.dart';
import 'package:digium/models/argument_model.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/providers/transaction_provider.dart';
import 'package:digium/widgets/custom_field.dart';
import 'package:digium/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateTransactionTab extends StatefulWidget {
  const CreateTransactionTab({Key? key}) : super(key: key);

  @override
  State<CreateTransactionTab> createState() => _CreateTransactionTabState();
}

class _CreateTransactionTabState extends State<CreateTransactionTab> {
  bool isLoading = false;
  final List<TextEditingController> _ticketsNameController = [
    TextEditingController(text: ""),
  ];

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  void dispose() {
    for (var controller in _ticketsNameController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as TransactionMuseum;
    final museum = arguments.museum;
    TransactionProvider _transactionProvider =
        Provider.of<TransactionProvider>(context);

    Widget _ticketNameInput(
        int index, TextEditingController currentController) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomField(
                    hintText: "Name $index",
                    isLoading: isLoading,
                    errorText: null,
                    controller: currentController,
                    prefixIcon: Icons.person,
                    onChanged: (String? val) {},
                  ),
                ),
                Visibility(
                  visible: _ticketsNameController.length > 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _ticketsNameController.removeAt(index - 1);
                      });
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8.0, left: 8),
                      child: Icon(
                        Icons.close,
                        color: subtitleColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Visibility(
                visible: index == _ticketsNameController.length,
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _ticketsNameController
                            .add(TextEditingController(text: ""));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("Tambah Pengunjung",
                            style: button1.copyWith(fontSize: 17))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(museum.name),
      // ),
      bottomSheet: Container(
        height: 83,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total Price"),
                Text(
                  "${formatCurrency.format(museum.price * _ticketsNameController.length)}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 62, 176, 243)),
                ),
              ],
            ),
            SizedBox(
              width: 118,
            ),
            ElevatedButton(
                child: Text(
                  "Checkout".toUpperCase(),
                  style: TextStyle(fontSize: 14),
                ),
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(128, 39)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 252, 180, 42)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ))),
                onPressed: () async {
                  List<String> names = [];
                  for (var item in _ticketsNameController) {
                    names.add(item.text);
                  }

                  bool isSuccess = await _transactionProvider.createTransaction(
                      museumId: museum.id, names: names);
                  if (isSuccess) {
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 40, bottom: 28, left: 33, right: 33),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/header/transaction_header.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.keyboard_backspace_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 19),
                    Text(
                      "Ticket Order",
                      style: title3.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Order your museum ticket",
                      style: subTitle2.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 33),
                  Text(
                    "Detail Pemesanan",
                    style: header1.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Tanggal Kunjungan",
                    style: header1,
                  ),
                  const SizedBox(height: 8),
                  DatePickerWidget(),
                  const SizedBox(height: 20),
                  Text(
                    "Pengunjung",
                    style: header1,
                  ),
                  ..._ticketsNameController
                      .asMap()
                      .entries
                      .map((e) => _ticketNameInput(e.key + 1, e.value))
                      .toList(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

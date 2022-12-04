import 'package:digium/models/argument_model.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/providers/transaction_provider.dart';
import 'package:digium/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateTransactionTab extends StatefulWidget {
  const CreateTransactionTab({Key? key})
      : super(key: key);

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
            margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
            color: Colors.white,
            child: Column(
              children: [
                CustomField(
                  label: "Name $index",
                  hintText: "Jhon",
                  isLoading: isLoading,
                  errorText: null,
                  controller: currentController,
                  prefixIcon: Icons.person,
                  onChanged: (String? val) {},
                ),
                Visibility(
                  visible: index == _ticketsNameController.length,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
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
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Visibility(
                        visible: _ticketsNameController.length > 1,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _ticketsNameController
                                  .removeAt(_ticketsNameController.length - 1);
                            });
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
    }

    return Scaffold(
      appBar: AppBar(title: Text(museum.name),),
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
                    color: Color.fromARGB(255, 62, 176, 243)
                  ),
                ),
              ],
            ),
            
            SizedBox(width: 118,),
            ElevatedButton(
              child: Text(
                "Checkout".toUpperCase(),
                style: TextStyle(fontSize: 14),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(128, 39)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 252, 180, 42)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    // side: BorderSide(color: Colors.red)
                  )
                )
              ),
              onPressed: () async {
                      List<String> names = [];
                      for (var item in _ticketsNameController) {
                        names.add(item.text);
                      }
    
                      bool isSuccess =
                          await _transactionProvider.createTransaction(
                              museumId: museum.id, names: names);
                      if (isSuccess) {
                        Navigator.pop(context);
                      }
                    }
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ..._ticketsNameController
                .asMap()
                .entries
                .map((e) => _ticketNameInput(e.key + 1, e.value))
                .toList(),
            const SizedBox(height: 10),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Column(
            //     children: [
            //       const SizedBox(height: 10),
            //       Text(
            //         "Total ${formatCurrency.format(museum.price * _ticketsNameController.length)}",
            //         style: const TextStyle(
            //             fontSize: 24, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 10),
            //       ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.blue,
            //           minimumSize: const Size.fromHeight(50), // NEW
            //         ),
            //         onPressed: () async {
            //           List<String> names = [];
            //           for (var item in _ticketsNameController) {
            //             names.add(item.text);
            //           }
    
            //           bool isSuccess =
            //               await _transactionProvider.createTransaction(
            //                   museumId: museum.id, names: names);
            //           if (isSuccess) {
            //             Navigator.pop(context);
            //           }
            //         },
            //         child: const Text(
            //           'Order',
            //           style: TextStyle(fontSize: 18),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

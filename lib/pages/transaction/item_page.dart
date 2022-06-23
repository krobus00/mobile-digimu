import 'package:digium/providers/transaction_provider.dart';
import 'package:digium/widgets/transaction_card.dart';
import 'package:digium/widgets/transaction_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionItemPage extends StatefulWidget {
  const TransactionItemPage({Key? key}) : super(key: key);

  @override
  State<TransactionItemPage> createState() => _TransactionItemPageState();
}

class _TransactionItemPageState extends State<TransactionItemPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider _transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/header/transaction_header.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Transaction Items",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See all your past adventures",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transactionProvider.transactionItems.items!.length,
              itemBuilder: (_, index) => TranscationItemCard(
                transaction: _transactionProvider.transactionItems,
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

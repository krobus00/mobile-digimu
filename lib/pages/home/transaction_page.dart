import 'package:digium/providers/transaction_provider.dart';
import 'package:digium/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late ScrollController _controller;
  final int _paginate = 10;
  int _page = 1;
  bool _isLoading = false;

  void _loadMore() async {
    if (!_isLoading) {
      _page += 1;
      TransactionProvider _transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      bool hasNext = await _transactionProvider.getTransactions(
        firstFetch: false,
        page: _page,
        paginate: _paginate,
      );
      if (!hasNext) {
        _page -= 1;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleLoadData();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  _handleLoadData() async {
    TransactionProvider _transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    await _transactionProvider.getTransactions(
      firstFetch: true,
      page: _page,
      paginate: _paginate,
    );
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider _transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Column(
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
                  "Transactions",
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
            controller: _controller,
            itemCount: _transactionProvider.transactions.length,
            itemBuilder: (_, index) => TransactionCard(
              transaction: _transactionProvider.transactions[index],
            ),
          ),
        ),
        Visibility(
          visible: _isLoading,
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}

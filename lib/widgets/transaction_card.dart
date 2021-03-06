import 'package:digium/constants/endpoint.dart';
import 'package:digium/constants/theme.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/models/argument_model.dart';
import 'package:digium/models/transaction_model.dart';
import 'package:digium/providers/transaction_provider.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionProvider _transactionProvider =
        Provider.of<TransactionProvider>(context);
    final _navLocator = getIt.get<NavigationService>();
    return GestureDetector(
      onTap: () async {
        await _transactionProvider.getTransactionItems(
            transactionId: transaction.id);

        switch (transaction.status) {
          case "Waiting Payment":
            _navLocator.navigateTo(
              routeName: "/transaction/payment",
              arguments: TransactionDetailArgument(transaction: transaction),
            );
            break;

          default:
            _navLocator.navigateTo(
              routeName: "/transaction/items",
            );
            break;
        }
      },
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          border: Border(
            bottom:
                BorderSide(width: 1, color: Color.fromRGBO(214, 214, 214, 1)),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    getAssetURL(assetMuseumURL, transaction.museum!.background),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            transaction.museum!.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(68, 68, 68, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 20,
                          child: Center(
                            child: Text(
                              transactionStatus[transaction.status] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: transactionStatusColor[transaction.status],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          DateFormat('d MMMM yyyy hh:mm', "id_ID")
                              .format(transaction.createdAt),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(68, 68, 68, 1),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

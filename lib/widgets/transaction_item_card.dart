import 'package:digium/constants/endpoint.dart';
import 'package:digium/constants/theme.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/models/argument_model.dart';
import 'package:digium/models/transaction_model.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TranscationItemCard extends StatelessWidget {
  final TransactionModel? transaction;
  final int index;
  const TranscationItemCard(
      {Key? key, required this.transaction, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navLocator = getIt.get<NavigationService>();
    return GestureDetector(
      onTap: () async {
        if (transaction!.items![index].status == "Waiting") {
          _navLocator.navigateTo(
              routeName: "/transaction/tickets",
              arguments:
                  TicketDetailArgument(item: transaction!.items![index]));
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // set it to min
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            transaction!.items![index].name,
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
                              transaction!.items![index].status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: transactionItemStatusColor[
                                transaction!.items![index].status],
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
                              .format(transaction!.items![index].createdAt),
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

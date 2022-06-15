import 'package:digium/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceAndBuy extends StatelessWidget {
  final int price;

  PriceAndBuy({
    Key? key,
    required this.price,
  }) : super(key: key);
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Total Price",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: formatCurrency.format(price),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: primaryColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange)),
            onPressed: null,
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}

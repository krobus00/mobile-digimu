import 'package:digium/constants/endpoint.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          //2
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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              //List 1
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(214, 214, 214, 1)),
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
                            getAssetURL(assetMuseumURL,
                                'https://firebasestorage.googleapis.com/v0/b/digimu-31cdd.appspot.com/o/-LE5Rj8-rlwDZQMc3ioO%2FBackground%2Fbackground.jpg?alt=media&token=72c6d58d-1390-4640-8cbb-054242260810'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // give some padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // set it to min
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  "Museum Sampoerna",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(68, 68, 68, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: const Center(
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  width: 100,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          122, 233, 139, 1),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ],
                            ),
                            Row(children: const <Widget>[Text(" ")]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "05/05/2022",
                                  style: TextStyle(
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
              //List 2
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(214, 214, 214, 1)),
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
                            getAssetURL(assetMuseumURL,
                                'https://firebasestorage.googleapis.com/v0/b/digimu-31cdd.appspot.com/o/-LE7zWwXwW8yn0T5Flja%2FBackground%2Fbackground.jpg?alt=media&token=a2fb18f4-16c0-4fe6-b5d3-e0f8ce413894'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // give some padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // set it to min
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  "Museum Satwa",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(68, 68, 68, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: const Center(
                                    child: Text(
                                      'Waiting',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  width: 100,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(255, 61, 0, 1),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ],
                            ),
                            Row(children: const <Widget>[Text(" ")]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "16/06/2022",
                                  style: TextStyle(
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
              //List 3
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(214, 214, 214, 1)),
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
                            getAssetURL(assetMuseumURL,
                                'https://firebasestorage.googleapis.com/v0/b/digimu-31cdd.appspot.com/o/-LE_Yv8ZgI7gyQ2ufhoj%2FBackground%2FBackground.jpg?alt=media&token=120d5fd7-2067-427c-a661-99e1db5044a7'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // give some padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min, // set it to min
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  "Museum Probolinggo",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(68, 68, 68, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  child: const Center(
                                    child: Text(
                                      'Pending',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  width: 100,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(255, 168, 0, 1),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ],
                            ),
                            Row(children: const <Widget>[Text(" ")]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "28/07/2022",
                                  style: TextStyle(
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
            ],
          ),
        ),
      ],
    );
  }
}

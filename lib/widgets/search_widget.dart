import 'package:digium/providers/menu_provider.dart';
import 'package:digium/providers/museum_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    MuseumProvider _museumProvider =
        Provider.of<MuseumProvider>(context, listen: false);

    _editingController = TextEditingController(text: _museumProvider.search);
  }

  @override
  Widget build(BuildContext context) {
    MenuProvider _menuProvider = Provider.of<MenuProvider>(context);
    MuseumProvider _museumProvider = Provider.of<MuseumProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _editingController,
              onChanged: (_) => setState(() {
                _museumProvider.search = _editingController.text;
              }),
              onSubmitted: (_) async {
                if (_menuProvider.currentIndex != 1) {
                  setState(() {
                    _menuProvider.currentIndex = 1;
                  });
                }
                await _museumProvider.getMuseums(
                  firstFetch: true,
                  page: 1,
                  paginate: 10,
                  search: _museumProvider.search,
                );
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Visibility(
            visible: _editingController.text.trim().isEmpty,
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
              onPressed: null,
            ),
          ),
          Visibility(
            visible: _editingController.text.trim().isNotEmpty,
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
              onPressed: () async {
                setState(() {
                  _museumProvider.search = "";
                  _editingController.clear();
                });
                await _museumProvider.getMuseums(
                  firstFetch: true,
                  page: 1,
                  paginate: 10,
                  search: _museumProvider.search,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'data/item_api.dart';
import 'data/item_page.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  ItemPage? page;

  @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final fetchPage = await ItemApi().fetchPage(startingIndex: 0);
        setState(() {
          page = fetchPage;
        });
      });
    }

  @override
  Widget build(BuildContext context) {
    final items = page?.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: items == null ?
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 5.0,
        ):
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: item.color,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
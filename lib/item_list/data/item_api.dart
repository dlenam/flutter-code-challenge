import 'dart:math';

import 'package:flutter/material.dart';

import 'item.dart';
import 'item_page.dart';

const catalogLength = 200;

class ItemApi {
  /// This function emulates a REST API call. You can imagine replacing its
  /// contents with an actual network call, keeping the signature the same.
  ///
  /// It will fetch a page of items from [startingIndex].
  Future<ItemPage> fetchPage({required int startingIndex}) async {
    // We're emulating the delay inherent to making a network call.
    await Future<void>.delayed(const Duration(seconds: 1));

    // If the [startingIndex] is beyond the bounds of the catalog, an
    // empty page will be returned.
    if (startingIndex > catalogLength) {
      return ItemPage(
        items: [],
        startingIndex: startingIndex,
        hasNext: false,
      );
    }

    // The page of items is generated here.
    return ItemPage(
      items: List.generate(
        min(itemsPerPage, catalogLength - startingIndex),
        (index) => Item(
          color: Colors.primaries[index % Colors.primaries.length],
          name: 'Color #${startingIndex + index}',
          price: 50 + (index * 42) % 200,
        ),
      ),
      startingIndex: startingIndex,
      // Returns `false` if we've reached the [catalogLength].
      hasNext: startingIndex + itemsPerPage < catalogLength,
    );
  }
}
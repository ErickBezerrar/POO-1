import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/decididor.dart';
import '../util/ordenador.dart';

var valores = [3, 7, 15];

enum TableStatus { idle, loading, ready, error }

enum EntityType {
  car,
  boat,
  movie,
}

class DataService {
  static const int MAX_N_ITEMS = 15;
  static const int MIN_N_ITEMS = 3;
  static const int DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(int n) {
    _numberOfItems = n < 0
        ? MIN_N_ITEMS
        : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': null,
  });

  void load(int index) {
    final types = [EntityType.car, EntityType.boat, EntityType.movie];

    loadByType(types[index]);
  }

  void sortCurrentState(String property) {
    List objects = tableStateNotifier.value['dataObjects'] ?? [];

    if (objects.isEmpty) return;

    Sorter sorter = Sorter();

    var sortedObjects =
        sorter.sortItemWithCallback(objects, (current, next) {
      final correctOrder = true ? [current, next] : [next, current];
      return correctOrder[0][property]
              .compareTo(correctOrder[1][property]) >
          0;
    });

    emitSortedState(sortedObjects, property);
  }

  Uri buildUri(EntityType type) {
    return Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/${type.toString().split('.').last}/random_${type.toString().split('.').last}',
      queryParameters: {'size': '$_numberOfItems'},
    );
  }

  Future<List<dynamic>> accessApi(Uri uri) async {
    var jsonString = await http.read(uri);
    var json = jsonDecode(jsonString);

    json = [...tableStateNotifier.value['dataObjects'], ...json];

    return json;
  }

  void emitSortedState(List sortedObjects, String property) {
    var state = Map<String, dynamic>.from(tableStateNotifier.value);

    state['dataObjects'] = sortedObjects;
    state['sortCriteria'] = property;
    state['ascending'] = true;

    tableStateNotifier.value = state;
  }

  void emitLoadingState(EntityType type) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': type,
    };
  }

  void emitReadyState(EntityType type, var json, List<String> propertyNames, List<String> columnNames) {
    tableStateNotifier.value = {
      'itemType': type,
      'status': TableStatus.ready,
      'dataObjects': json,
      'propertyNames': propertyNames,
      'columnNames': columnNames,
    };
  }

  bool hasOngoingRequest() =>
      tableStateNotifier.value['status'] == TableStatus.loading;

  bool didChangeRequestedType(EntityType type) =>
      tableStateNotifier.value['itemType'] != type;

  void loadByType(EntityType type) async {
    // Ignore request if there is an ongoing request
    if (hasOngoingRequest()) return;

    if (didChangeRequestedType(type)) {
      emitLoadingState(type);
    }

    var uri = buildUri(type);
    var json = await accessApi(uri);

    List<String> propertyNames;
    List<String> columnNames;

    if (type == EntityType.car) {
      propertyNames = ["model", "brand", "speed"];
      columnNames = ["Modelo", "Marca", "Velocidade"];
    } else if (type == EntityType.boat) {
      propertyNames = ["name", "type", "length"];
      columnNames = ["Nome", "Tipo", "Comprimento"];
    } else if (type == EntityType.movie) {
      propertyNames = ["title", "director", "genre"];
      columnNames = ["Título", "Diretor", "Gênero"];
    } else {
      propertyNames = [];
      columnNames = [];
    }

    emitReadyState(type, json, propertyNames, columnNames);
  }
}

final dataService = DataService();

class Sorter {
  List sortItemWithCallback(List item,
      bool Function(dynamic, dynamic) shouldSwapCurrentWithNext) {
    List sortedItems = List.of(item);
    bool swappedAtLeastOnce;

    do {
      swappedAtLeastOnce = false;

      for (int i = 0; i < sortedItems.length - 1; i++) {
        var current = sortedItems[i];
        var next = sortedItems[i + 1];

        if (shouldSwapCurrentWithNext(current, next)) {
          var temp = sortedItems[i];
          sortedItems[i] = sortedItems[i + 1];
          sortedItems[i + 1] = temp;
          swappedAtLeastOnce = true;
        }
      }
    } while (swappedAtLeastOnce);

    return sortedItems;
  }
}
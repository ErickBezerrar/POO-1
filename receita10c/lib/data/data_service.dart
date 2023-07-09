import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/decididor.dart';
import '../util/ordenador.dart';

var valores = [3, 7, 15];

enum TableStatus { idle, loading, ready, error }

enum ItemType {
  beer,
  coffee,
  nation,
  none;

  String get asString => '$name';

  List<String> get columns => this == coffee
      ? ["Nome", "Origem", "Tipo"]
      : this == beer
          ? ["Nome", "Estilo", "IBU"]
          : this == nation
              ? ["Nome", "Capital", "Idioma", "Esporte"]
              : [];

  List<String> get properties => this == coffee
      ? ["blend_name", "origin", "variety"]
      : this == beer
          ? ["name", "style", "ibu"]
          : this == nation
              ? ["nationality", "capital", "language", "national_sport"]
              : [];
}

class DataService {
  static int get MAX_N_ITEMS => valores[2];
  static int get MIN_N_ITEMS => valores[0];
  static int get DEFAULT_N_ITEMS => valores[1];

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n) {
    _numberOfItems = n < 0
        ? MIN_N_ITEMS
        : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  String filtrar = '';
  String propriedadeOrdenacao = '';

  void carregar(index) {
    final params = [ItemType.coffee, ItemType.beer, ItemType.nation];

    carregarPorTipo(params[index]);
  }

  void ordenarEstadoAtual(String propriedade, [bool cresc = true]) {
    propriedadeOrdenacao = propriedade;
    tableStateNotifier.value = Map<String, dynamic>.from(tableStateNotifier.value);
  }

  void filtrarEstadoAtual(String filtrar) {
    this.filtrar = filtrar;
    tableStateNotifier.value = Map<String, dynamic>.from(tableStateNotifier.value);
  }

  Uri montarUri(ItemType type) {
    return Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/${type.asString}/random_${type.asString}',
        queryParameters: {'size': '$_numberOfItems'});
  }

  Future<List<dynamic>> acessarApi(Uri uri) async {
    var jsonString = await http.read(uri);

    var json = jsonDecode(jsonString);

    json = [...tableStateNotifier.value['dataObjects'], ...json];

    return json;
  }

  void emitirEstadoOrdenado(List objetosOrdenados, String propriedade) {
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);

    estado['dataObjects'] = objetosOrdenados;

    estado['sortCriteria'] = propriedade;

    estado['ascending'] = true;

    tableStateNotifier.value = estado;
  }

  void emitirEstadoCarregando(ItemType type) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': type
    };
  }

  void emitirEstadoPronto(ItemType type, var json) {
    List<dynamic> filteredObjects = json;
    if (filtrar.isNotEmpty) {
      filteredObjects = json.where((obj) => obj['name'].toLowerCase().contains(filtrar.toLowerCase())).toList();
    }

    List<dynamic> sortedObjects = filteredObjects;
    if (propriedadeOrdenacao.isNotEmpty) {
      sortedObjects.sort((a, b) => a[propriedadeOrdenacao].compareTo(b[propriedadeOrdenacao]));
    }

    tableStateNotifier.value = {
      'itemType': type,
      'status': TableStatus.ready,
      'dataObjects': sortedObjects,
      'propertyNames': type.properties,
      'columnNames': type.columns
    };
  }

  void emitirEstadoFiltrado(List objetosFiltrados) {
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);

    estado['dataObjects'] = objetosFiltrados;

    tableStateNotifier.value = estado;
  }

  bool temRequisicaoEmCurso() =>
      tableStateNotifier.value['status'] == TableStatus.loading;

  bool mudouTipoDeItemRequisitado(ItemType type) =>
      tableStateNotifier.value['itemType'] != type;

  void carregarPorTipo(ItemType type) async {
    //ignorar solicitação se uma requisição já estiver em curso

    if (temRequisicaoEmCurso()) return;

    if (mudouTipoDeItemRequisitado(type)) {
      emitirEstadoCarregando(type);
    }

    var uri = montarUri(type);

    var json = await acessarApi(uri); //, type);

    emitirEstadoPronto(type, json);
  }
}

final dataService = DataService();

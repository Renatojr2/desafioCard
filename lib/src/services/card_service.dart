import 'dart:convert';

import 'package:dio/dio.dart';
import '../entitis/card.dart';
import '../entitis/card.dart';

class CardService {
  Future<List> buscarTodosCards(Dio dio) async {
    Response<List> response = await dio.get('/cards');

    return response.data.map((card) => Card.fromJson(card)).toList();
  }

  Future<Card> buscarCardsId(Dio dio, int id) async {
    Response response = await dio.get('/cards/$id');
    return (Card.fromJson(response.data));
  }

  Future<Card> insereCards(Dio dio, Card card) async {
    Response response = await dio.post('/cards', data: jsonEncode(card));

    return Card.fromJson(response.data);
  }

  Future<Card> editarCards(Dio dio, Card card) async {
    Response response =
        await dio.put('/cards/${card.id}', data: jsonEncode(card));
    return Card.fromJson(response.data);
  }

  Future<List> deletarCards(Dio dio, int id) async {
    Response response = await dio.delete('/cards/$id');
    return response.data.map((card) => Card.fromJson(card)).toList();
  }
}

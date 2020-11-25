import 'dart:convert';

import 'package:desafiocard/src/contract/Iservice.dart';
import 'package:dio/dio.dart';
import '../entitis/card.dart';
import '../entitis/card.dart';

class CardService implements IService {
  Dio dio;
  CardService()
      : dio = Dio(
          BaseOptions(baseUrl: 'https://api-cards-growdev.herokuapp.com'),
        );
  Future<List> buscarTodosCards() async {
    Response<List> response = await dio.get('/cards');

    return response.data.map((card) => Card.fromJson(card)).toList();
  }

  Future<Card> buscarCardsId(int id) async {
    Response response = await dio.get('/cards/$id');
    return response.statusCode == 200
        ? Card.fromJson(response.data)
        : throw Error();
  }

  Future<Card> insereCards(Card card) async {
    Response response = await dio.post('/cards', data: jsonEncode(card));

    return Card.fromJson(response.data);
  }

  Future<Card> editarCards(Card card) async {
    Response response =
        await dio.put('/cards/${card.id}', data: jsonEncode(card));
    return response.statusCode == 200
        ? Card.fromJson(response.data)
        : throw Error();
  }

  Future<List> deletarCards(int id) async {
    Response response = await dio.delete('/cards/$id');
    return response.statusCode == 200
        ? response.data.map((card) => Card.fromJson(card)).toList()
        : throw Error();
  }
}

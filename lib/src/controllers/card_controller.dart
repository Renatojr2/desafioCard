import 'package:desafiocard/src/services/card_service.dart';
import 'package:dio/dio.dart';

import '../entitis/card.dart';

class CardController {
  CardService cardService;

  CardController() {
    cardService = CardService();
  }

  Future<List> buscarTodosCards(Dio dio) async {
    return cardService.buscarTodosCards(dio);
  }

  Future<Card> buscarCardsId(Dio dio, int id) async {
    return cardService.buscarCardsId(dio, id);
  }

  Future<Card> insereCards(Dio dio, Card card) async {
    return cardService.insereCards(dio, card);
  }

  Future<Card> editarCards(Dio dio, Card card) async {
    return cardService.editarCards(dio, card);
  }

  Future<List> deletarCards(Dio dio, int id) async {
    return cardService.deletarCards(dio, id);
  }
}

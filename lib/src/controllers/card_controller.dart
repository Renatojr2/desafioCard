import 'package:desafiocard/src/contract/Iservice.dart';
import 'package:desafiocard/src/services/card_service.dart';
import 'package:dio/dio.dart';

import '../entitis/card.dart';

class CardController {
  IService cardService;

  CardController(this.cardService);

  Future<List> buscarTodosCards() async {
    return cardService.buscarTodosCards();
  }

  Future<Card> buscarCardsId(int id) async {
    return cardService.buscarCardsId(id);
  }

  Future<Card> insereCards(Card card) async {
    return cardService.insereCards(card);
  }

  Future<Card> editarCards(Card card) async {
    return cardService.editarCards(card);
  }

  Future<List> deletarCards(int id) async {
    return cardService.deletarCards(id);
  }
}

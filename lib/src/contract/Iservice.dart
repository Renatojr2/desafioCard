import 'package:desafiocard/src/entitis/card.dart';

abstract class IService {
  Future<List> buscarTodosCards();
  Future<Card> buscarCardsId(int id);
  Future<Card> insereCards(Card card);
  Future<Card> editarCards(Card card);
  Future<List> deletarCards(int id);
}

import 'dart:io';

import 'package:desafiocard/src/controllers/card_controller.dart';
import 'package:desafiocard/src/entitis/card.dart';
import 'package:desafiocard/src/services/card_service.dart';
import 'package:dio/dio.dart';

void main(List<String> arguments) async {
  CardService cardService = CardService();

  var cardController = CardController(cardService);

  var sair = false;
  int opcao;
  var menu = ''' 
    ==========================================
    Bem-vindo ao sistema de Cards o/

    Escolha uma das opções:
    1 - Buscar todos os cards
    2 - Buscar card pelo ID
    3 - Criar card
    4 - Atualizar card
    5 - Deletar card
    6 - Sair
    ==========================================
   ''';

  do {
    opcao = getOption(menu);
    switch (opcao) {
      case 1:
        var lista = await cardController.buscarTodosCards();
        lista.forEach((element) => print(element));
        break;
      case 2:
        await trataErrorBuscaCard(cardController);
        break;
      case 3:
        var titleAndContent = getTitleAndContent();
        var card = await cardController.insereCards(
            Card(title: titleAndContent[0], content: titleAndContent[1]));
        print(card);
        break;
      case 4:
        await trataErrorEditarCard(cardController);
        break;
      case 5:
        await trataErrorDeletarCard(cardController);
        break;
      case 6:
        sair = true;
        print('Tchau, filhão');
        break;
      default:
        print('Opção não consta no menu');
        break;
    }
  } while (!sair);
}

void trataErrorBuscaCard(CardController cardController) async {
  try {
    var id = getId();
    var card = await cardController.buscarCardsId(id);
    print(card);
  } catch (error) {
    print('Card não encontrado');
    print(error);
  }
}

void trataErrorEditarCard(CardController cardController) async {
  try {
    var id = getId();
    var titleAndContent = getTitleAndContent();
    var card = await cardController.editarCards(Card(
      id: id,
      title: titleAndContent[0],
      content: titleAndContent[1],
    ));

    print('Card atualizado com sucesso.');
    print(card);
  } catch (error) {
    print('Card não encontrado');
    print(error);
  }
}

void trataErrorDeletarCard(CardController cardController) async {
  try {
    var id = getId();
    await cardController.deletarCards(id);
    print('Cartão deletado com sucesso!');
  } catch (error) {
    print('Card não encontrado');
    print(error);
  }
}

int getOption(String menu) {
  print(menu);
  int opcao;
  do {
    print('Digite uma opção: ');
    opcao = int.tryParse(stdin.readLineSync());
  } while (opcao == null);
  return opcao;
}

int getId() {
  int id;
  do {
    print('Digite o Id desejado: ');
    id = int.tryParse(stdin.readLineSync());
  } while (id == null);
  return id;
}

List getTitleAndContent() {
  var titleAndContent = [];
  print('Digite o Título do card:');
  titleAndContent.add(stdin.readLineSync());
  print('Digite o Conteúdo do card:');
  titleAndContent.add(stdin.readLineSync());
  return titleAndContent;
}

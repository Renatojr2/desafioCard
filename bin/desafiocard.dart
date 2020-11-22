import 'dart:convert';
import 'dart:io';

import 'package:desafiocard/src/controllers/card_controller.dart';
import 'package:desafiocard/src/entitis/card.dart';
import 'package:dio/dio.dart';

void main(List<String> arguments) async {
  var dio = Dio(
    BaseOptions(baseUrl: 'https://api-cards-growdev.herokuapp.com'),
  );

  var cardController = CardController();

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
        var lista = await cardController.buscarTodosCards(dio);
        lista.forEach((element) => print(element));
        break;
      case 2:
        var id = getId();
        var card = await cardController.buscarCardsId(dio, id);
        if (card.id == null) {
          print('Card não existente');
        } else {
          print(card);
        }
        break;
      case 3:
        var titleAndContent = getTitleAndContent();
        var card = await cardController.insereCards(
            dio, Card(title: titleAndContent[0], content: titleAndContent[1]));
        print(card);
        break;
      case 4:
        var id = getId();
        var titleAndContent = getTitleAndContent();
        var card = await cardController.editarCards(
            dio,
            Card(
              id: id,
              title: titleAndContent[0],
              content: titleAndContent[1],
            ));
        if (card.id == null) {
          print('Card não existente');
        } else {
          print('Card atualizado com sucesso.');
          print(card);
        }
        break;
      case 5:
        var id = getId();
        await cardController.deletarCards(dio, id);
        print('Cartão deletado com sucesso!');
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

import 'dart:convert';
import 'dart:io';

import 'package:desafiocard/src/entitis/card.dart';
import 'package:dio/dio.dart';

void main(List<String> arguments) {
  var dio = Dio(
    BaseOptions(baseUrl: 'https://api-cards-growdev.herokuapp.com'),
  );

  var sair = false;
  int opcao;
  var opcoes = ''' 
    ==========================================
    Bem-vindo ao sistema de Cards o/

    Escolha uma das opções:
    1 - Buscar todos os cards (verbo: GET, url: /cards)
    2 - Buscar card pelo ID  (verbo: GET, url: /cards/ID )
    3 - Criar card (verbo: POST, url: /cards, data: objeto para criar)
    4 - Atualizar card (verbo: PUT, url: /cards/ID, data: objeto para atualizar)
    5 - Deletar card (verbo: DELETE, url: /cards/ID)
    6 - Sair
   ''';

  opcao = getOption();
  switch (opcao) {
    case 1:
      buscarTodosCards(dio);
      break;
    case 2:
      buscarCardsId(dio, 1);
      break;
    case 3:
      insereCards(dio, Card(id: 2, title: 'Card2', content: 'qualquer coisa'));
      break;
  }
}

int getOption() {
  int opcao;
  do {
    print('Digite uma opção: ');
    opcao = int.tryParse(stdin.readLineSync());
  } while (opcao == null);

  return opcao;
}

void buscarTodosCards(Dio dio) async {
  Response<List> response = await dio.get('/cards');

  response.data.map((card) => Card.fromJson(card)).forEach((element) {
    print(element);
  });
}

void buscarCardsId(Dio dio, int id) async {
  Response response = await dio.get('/cards/$id');

  print(response.data.runtimeType);
  print(Card.fromJson(response.data));
}

void insereCards(Dio dio, Card card) async {
  Response response = await dio.post('/cards', data: jsonEncode(card));

  print(response.statusCode);
  print(response.data);
}

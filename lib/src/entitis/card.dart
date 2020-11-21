class Card {
  int id;
  String title;
  String content;

  Card({this.id, this.title, this.content});
  Card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'id: ${id} ... title: ${title} ... content: ${content}';
  }
}


class Review {
  Review({required this.content, required this.createdAt, required this.mapX, required   this.mapY});

  String content;
  String createdAt;
  int mapX;
  int mapY;

  Review.fromJson(Map<String, dynamic> map)
    : this(content: map['content'], createdAt: map['createdAt'], mapX: map['mapX'], mapY: map['mapY']);

  Map<String, dynamic> toJson() {
    return {'content': content, 'createdAt': createdAt, 'mapX': mapX, 'mapY': mapY};
  }
}

class Review {
  Review({
    required this.id,
    required this.content,
    required this.mapX,
    required this.mapY,
    required this.createdAt,
  });
  String id;
  String content;
  double mapX;
  double mapY;
  DateTime createdAt;

  Review.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        content: map['content'],
        mapX: map['mapX'],
        mapY: map['mapY'],
        createdAt: map['createdAt'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'mapX': mapX,
      'mapY': mapY,
      'createdAt': createdAt,
    };
  }
}

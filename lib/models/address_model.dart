//데이터 구조 관리

class Address {
  Address({
    required this.title,
    required this.category,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });
  String title;
  String category;
  String roadAddress;
  String mapx;
  String mapy;
  Address.fromJson(Map<String, dynamic> map)
    : this(
        title: map['title'],
        category: map['category'],
        roadAddress: map['roadAddress'],
        mapx: map['mapx'],
        mapy: map['mapy'],
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'roadAddress': roadAddress,
      'mapx': mapx,
      'mapy': mapy,
    };
  }
}

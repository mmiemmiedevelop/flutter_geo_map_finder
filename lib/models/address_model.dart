//데이터 구조 관리

class Address {
  Address({
    required this.title,
    required this.category,
    required this.roadAddress,
  });
  String title;
  String category;
  String roadAddress;

  Address.fromJson(Map<String, dynamic> map)
    : this(
        title: map['title'],
        category: map['category'],
        roadAddress: map['roadAddress'],
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'roadAddress': roadAddress,
    };
  }
}

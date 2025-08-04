import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review_model.dart';

class ReviewRepository {
  const ReviewRepository();

  // mapx,mapy가 일치하는 리뷰 불러오기
  Future<List<Review>> getReviews(int mapx, int mapy) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('reviews');

    final querySnapshot = await collectionRef
        .where('mapX', isEqualTo: mapx)
        .where('mapY', isEqualTo: mapy)
        .get();

    // print(
    //   'Found ${querySnapshot.docs.length} reviews for mapX: $mapx, mapY: $mapy',
    // );

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // 문서 ID 추가
        return Review.fromJson(data);
      }).toList();
    }
    return [];
  }

  // 리뷰추가
  Future<bool> insert({required Review review}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('reviews');
      final docRef = collectionRef.doc();

      final map = {
        'content': review.content,
        'createdAt': review.createdAt,
        'mapX': review.mapX,
        'mapY': review.mapY,
      };
      await docRef.set(map);
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }
}

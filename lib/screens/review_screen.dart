import 'package:flutter/material.dart';
import '../models/review_model.dart';
import 'widgets/review_list.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});
  //final Review review;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰'),
      ),
      body: ReviewList(
        reviews: [Review(id: '1', content: 'test', mapX: 1, mapY: 1, createdAt: DateTime.now())],
        onReviewTap: (review) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReviewScreen()),
          );
        },
      ),
    );
  }
}   
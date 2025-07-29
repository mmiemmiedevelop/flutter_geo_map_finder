import 'package:flutter/material.dart';
import '../../models/review_model.dart';
import 'review_list_tile.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviews;
  final Function(Review)? onReviewTap;
  final bool isLoading;
  final String? errorMessage;

  const ReviewList({
    Key? key,
    required this.reviews,
    this.onReviewTap,
    this.isLoading = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: const TextStyle(fontSize: 16, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (reviews.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '리뷰가 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewListTile(
          review: review,
          onTap: onReviewTap != null ? () => onReviewTap!(review) : null,
        );
      },
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../networks/review_repository.dart';
import '../models/review_model.dart';

class ReviewState {
  ReviewState({required this.reviews});
  List<Review>? reviews;
}

class ReviewViewModel extends Notifier<ReviewState> {
  @override
  ReviewState build() {
    return ReviewState(reviews: null);
  }

  Future<void> getReviews(int mapx, int mapy) async {
    state = ReviewState(
      reviews: await ReviewRepository().getReviews(mapx, mapy),
    );
  }

  Future<bool> insertReview(Review review) async {
    return await ReviewRepository().insert(review: review);
  }
}

final reviewViewModelProvider = NotifierProvider<ReviewViewModel, ReviewState>(
  () {
    return ReviewViewModel();
  },
);

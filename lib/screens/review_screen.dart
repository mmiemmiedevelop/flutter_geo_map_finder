import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/address_model.dart';
import '../models/review_model.dart';
import 'widgets/review_list.dart';
import '../view_model/review_view_model.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key, required this.address});
  final Address address;

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  late Address address;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    address = widget.address;
    // initState에서는 ref를 직접 사용할 수 없으므로 WidgetsBinding.instance.addPostFrameCallback 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(reviewViewModelProvider.notifier)
          .getReviews(int.parse(address.mapx), int.parse(address.mapy));
    });
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('리뷰 내용을 입력해주세요')));
      return;
    }

    final review = Review(
      content: _reviewController.text.trim(),
      createdAt: DateTime.now().toIso8601String(),
      mapX: int.parse(address.mapx),
      mapY: int.parse(address.mapy),
    );

    final success = await ref
        .read(reviewViewModelProvider.notifier)
        .insertReview(review);

    if (!mounted) return; // mounted 체크 추가

    if (success) {
      _reviewController.clear();
      // 리뷰 목록 새로고침
      ref
          .read(reviewViewModelProvider.notifier)
          .getReviews(int.parse(address.mapx), int.parse(address.mapy));

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('리뷰가 성공적으로 작성되었습니다')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('리뷰 작성에 실패했습니다')));
    }
  }

  @override
  Widget build(BuildContext context) {
    ReviewState reviewState = ref.watch(reviewViewModelProvider);
    List<Review> reviews = reviewState.reviews ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(widget.address.title)),
      body: Column(
        children: [
          Expanded(
            child: ReviewList(
              address: address,
              reviews: reviews,
              onReviewTap: (review) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewScreen(address: address),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _reviewController,
                    decoration: const InputDecoration(
                      hintText: '리뷰를 작성해주세요...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  child: const Text('작성'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

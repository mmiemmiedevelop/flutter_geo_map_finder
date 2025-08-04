import 'package:flutter/material.dart';
import '../../models/review_model.dart';
import '../../models/address_model.dart';

class ReviewListTile extends StatelessWidget {
  final Address address;
  final Review review;
  final VoidCallback? onTap;

  const ReviewListTile({
    Key? key,
    required this.address,
    required this.review,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          review.content,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _formatDate(review.createdAt),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    // T를 공백으로 바꾸고 마이크로초 제거
    return date.replaceAll('T', ' ').split('.')[0];
  }
}

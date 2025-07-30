import 'package:flutter/material.dart';
import '../../models/address_model.dart';

class AddressListTile extends StatelessWidget {
  final Address address;
  final VoidCallback? onTap;

  const AddressListTile({super.key, required this.address, this.onTap});

  // HTML 태그를 제거하고 하이라이트된 부분을 찾는 메서드
  List<TextSpan> _parseHighlightedText(String text) {
    final List<TextSpan> spans = [];
    final RegExp boldRegex = RegExp(r'<b>(.*?)</b>');

    int lastIndex = 0;

    for (final Match match in boldRegex.allMatches(text)) {
      // 태그 이전 텍스트 추가
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      }

      // 하이라이트된 텍스트 추가 (다른 색상)
      spans.add(
        TextSpan(
          text: match.group(1), // <b></b> 태그 안의 내용
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // 하이라이트 색상
          ),
        ),
      );

      lastIndex = match.end;
    }

    // 마지막 부분 텍스트 추가
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }

    // 태그가 없는 경우 기본 스타일로 반환
    if (spans.isEmpty) {
      spans.add(
        TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: RichText(
          text: TextSpan(children: _parseHighlightedText(address.title)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              address.category,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              address.roadAddress,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../models/address_model.dart';
import 'widgets/address_list.dart';
import 'review_screen.dart';
import '../view_model/naver_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  void _search(String query, {bool showEmptyMessage = false}) {
    // 빈 문자열은 api 호출 안함
    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {
      ref.read(naverViewModelProvider.notifier).search(trimmedQuery);
    } else if (showEmptyMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('검색어를 입력하세요.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _debouncedSearch(String query) {
    // 디바운싱(1초 뒤에 검색 or 바로 버튼 클릭)
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      _search(query, showEmptyMessage: false);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(
      () => _debouncedSearch(_searchController.text),
    );
  }

  void _onAddressTap(Address address) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${address.title} 선택됨'),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    NaverState naverState = ref.watch(naverViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요.',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          onSubmitted: (value) => _search(value, showEmptyMessage: true),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                _search(_searchController.text, showEmptyMessage: true),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: AddressList(
        addresses: naverState.addresses ?? [],
        onRefresh: () {
          _search(_searchController.text, showEmptyMessage: false);
        },
        onAddressTap: _onAddressTap,
      ),
    );
  }
}

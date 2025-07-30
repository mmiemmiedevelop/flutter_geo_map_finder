import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void _search(String query) {
    ref.read(naverViewModelProvider.notifier).search(query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => _search(_searchController.text));
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
          onSubmitted: (value) => _search(value),
        ),
        actions: [
          IconButton(
            onPressed: () => _search(_searchController.text),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: AddressList(
        addresses: naverState.addresses ?? [],
        onRefresh: () {
          _search(_searchController.text);
        },
        onAddressTap: _onAddressTap,
      ),
    );
  }
}

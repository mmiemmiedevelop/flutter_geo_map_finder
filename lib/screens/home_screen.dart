import 'package:flutter/material.dart';
import '../models/address_model.dart';
import 'widgets/address_list.dart';
import 'review_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Address> addresses = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // 예시 데이터 로드
    _loadSampleData();
  }

  void _loadSampleData() {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // 실제로는 API 호출을 여기서 수행
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        addresses = [
          Address(
            title: '스타벅스 강남점',
            category: '카페',
            roadAddress: '서울특별시 강남구 테헤란로 123',
          ),
          Address(
            title: '올리브영 강남역점',
            category: '화장품',
            roadAddress: '서울특별시 강남구 강남대로 456',
          ),
          Address(
            title: '맥도날드 강남점',
            category: '패스트푸드',
            roadAddress: '서울특별시 강남구 역삼동 789',
          ),
        ];
      });
    });
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
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요.',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('검색 버튼 클릭');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: AddressList(
        addresses: addresses,
        isLoading: isLoading,
        errorMessage: errorMessage,
        onRefresh: _loadSampleData,
        onAddressTap: _onAddressTap,
      ),
    );
  }
}

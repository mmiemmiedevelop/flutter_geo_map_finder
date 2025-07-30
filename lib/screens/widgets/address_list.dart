import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/address_model.dart';
import 'address_list_tile.dart';
import '../../view_model/naver_view_model.dart';

class AddressList extends ConsumerWidget {
  final List<Address> addresses;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRefresh;
  final Function(Address)? onAddressTap;

  const AddressList({
    super.key,
    required this.addresses,
    this.isLoading = false,
    this.errorMessage,
    this.onRefresh,
    this.onAddressTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NaverState naverState = ref.watch(naverViewModelProvider);
    List<Address> addresses = naverState.addresses ?? [];
    
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onRefresh, child: const Text('다시 시도')),
            ],
          ],
        ),
      );
    }

    if (addresses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '검색 결과가 없습니다',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '다른 검색어를 입력해보세요',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) {
          onRefresh!();
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return AddressListTile(
            address: address,
            onTap: () {
              if (onAddressTap != null) {
                onAddressTap!(address);
              }
            },
          );
        },
      ),
    );
  }
}

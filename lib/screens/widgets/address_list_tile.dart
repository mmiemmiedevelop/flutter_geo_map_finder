import 'package:flutter/material.dart';
import '../../models/address_model.dart';

class AddressListTile extends StatelessWidget {
  final Address address;
  final VoidCallback? onTap;

  const AddressListTile({
    super.key,
    required this.address,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          address.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

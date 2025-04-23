import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RincianTransaksiPage extends StatelessWidget {
  const RincianTransaksiPage({super.key});

  String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            const Text('Detail Pesanan', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSummarySection(),
            const SizedBox(height: 16),
            _buildDetailSection(),
            const Spacer(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Column(
      children: [
        Stack(alignment: Alignment.center, children: [
          const CircleAvatar(backgroundColor: Colors.blue, radius: 40),
          Icon(Icons.sell, color: Colors.white, size: 40),
        ]),
        const SizedBox(height: 8),
        Text('+${formatRupiah(80000)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const Text('Penjualan', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildDetailSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            const CircleAvatar(backgroundColor: Colors.blue, radius: 20),
            Icon(Icons.store, color: Colors.white, size: 20),
          ]),
          const SizedBox(height: 8),
          const Text('Mendoan Joss',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('085751748482', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('14 Apr 2025 9.30'),
              Text('Tunai'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Pencatat: Fulan'),
              Text('INV: POS181738'),
            ],
          ),
          const Divider(height: 24, thickness: 1),
          _buildProductItem('Paket A Mendoan', 3, 45000, '@Rp. 15.000'),
          _buildProductItem('Es Teh Manis', 7, 35000, '@Rp. 5.000'),
          const Divider(height: 24, thickness: 1),
          _buildTotalRow('Total Pembayaran', 80000, bold: true),
          const SizedBox(height: 8),
          _buildTotalRow('Tunai', 100000),
          _buildTotalRow('Kembalian', 80000),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Catatan: -'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
      String name, int qty, int total, String pricePerItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(pricePerItem, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(formatRupiah(total),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, int amount, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: bold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        Text(formatRupiah(amount),
            style: bold ? const TextStyle(fontWeight: FontWeight.bold) : null),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(Icons.share, 'Bagikan', () {
            // TODO: Implement share logic
          }),
          _buildIconButton(Icons.delete_outline, 'Hapus', () {
            // TODO: Implement delete logic
          }),
          _buildIconButton(Icons.print, 'Cetak', () {
            // TODO: Implement print logic
          }),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.black),
          onPressed: onTap,
        ),
        Text(label),
      ],
    );
  }
}

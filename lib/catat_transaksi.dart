import 'package:flutter/material.dart';
import 'package:inventory_pos/detail_pesanan_page.dart';
import 'package:inventory_pos/extension.dart';

class CatatTransaksiPage extends StatefulWidget {
  const CatatTransaksiPage({super.key});

  @override
  State<CatatTransaksiPage> createState() => _CatatTransaksiPageState();
}

class _CatatTransaksiPageState extends State<CatatTransaksiPage> {
  int totalBayar = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Catat Transaksi',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildPaymentSummary(),
          _buildCategoryFilter(),
          _buildSearchField(),
          Expanded(child: _buildProductList()),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailPesananPage(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text('BAYAR',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text('${totalBayar.toRupiah()}  ($count item)',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildCategoryChip('Semua Produk'),
          const SizedBox(width: 8),
          ...List.generate(4, (index) => _buildCircleButton()),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }

  Widget _buildCircleButton() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: const Icon(Icons.food_bank, size: 16, color: Colors.white),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari produk disini',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildProductItem(index);
      },
    );
  }

  Widget _buildProductItem(int index) {
    return GestureDetector(
      onTap: () {
        totalBayar += 15000;
        count += 1;
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(backgroundColor: Colors.blue, radius: 20),
                Icon(
                  Icons.food_bank,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Paket A Mendoan',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Stok: 50'),
                ],
              ),
            ),
            const Text('Rp. 15.000',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

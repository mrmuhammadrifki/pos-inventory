import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_pos/catat_transaksi.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSummary(),
            _buildTransactionList(),
            _buildCatatTransaksiButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Chip(
            label: const Text('Mendoan Joss'),
            backgroundColor: Colors.blue.shade100,
            labelStyle: const TextStyle(color: Colors.black),
          ),
          const Icon(Icons.notifications_none, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      width: double.infinity,
      color: Colors.blue.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Keuntungan Hari Ini',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.remove_red_eye_outlined,
                  size: 16, color: Colors.black),
              SizedBox(width: 4),
              Text('Rp1.500.000',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildSummaryBox('Pengeluaran', 'Rp500.000')),
              const SizedBox(width: 8),
              Expanded(child: _buildSummaryBox('Pemasukan', 'Rp2.000.000')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String title, String amount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          Text(amount,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Transaksi Terbaru',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                Text('Lihat Semua', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                final isIncome = index % 2 == 0;
                return _buildTransactionItem(
                  title:
                      isIncome ? 'INV: POS${index + 181738}' : 'Belanja Harian',
                  user: 'Fulan',
                  date: '26 Maret 2025',
                  amount: isIncome ? 80000 * (index + 1) : -5000 * (index + 1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String user,
    required String date,
    required int amount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(backgroundColor: Colors.blue, radius: 20),
              Icon(Icons.food_bank, size: 20, color: Colors.white),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('$user   $date',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(
            '${amount > 0 ? '+' : ''}${formatRupiah(amount.abs())}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: amount > 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatatTransaksiButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CatatTransaksiPage(),
          ),
        ),
        child: const Text('Catat Transaksi'),
      ),
    );
  }
}

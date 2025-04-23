import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_pos/rincian_transaksi_page.dart';

class PembayaranPage extends StatefulWidget {
  final int total;

  const PembayaranPage({Key? key, required this.total}) : super(key: key);

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  String? selectedMethod;

  int? nominalBayar;
  final _formKey = GlobalKey<FormState>();

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
        title: const Text('Pembayaran', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildTotalSection(),
            const SizedBox(height: 24),
            _buildMetodePembayaran(),
            const Spacer(),
            _buildBayarButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Column(
      children: [
        Text(formatRupiah(nominalBayar ?? widget.total),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const Text('Total Pembayaran', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Nominal Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: TextFormField(
              initialValue: widget.total.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Nominal Pembayaran',
              ),
              onChanged: (value) {
                setState(() {
                  nominalBayar = int.tryParse(value) ?? 0;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetodePembayaran() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildPaymentMethodButton('Tunai'),
              const SizedBox(width: 8),
              _buildPaymentMethodButton('QRIS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodButton(String method) {
    final bool isSelected = selectedMethod == method;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = method;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.yellow.shade200 : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(method,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildBayarButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                selectedMethod == null ? Colors.grey.shade300 : Colors.blue,
            foregroundColor: Colors.black,
          ),
          onPressed: selectedMethod == null
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RincianTransaksiPage(),
                    ),
                  );
                },
          child: Text('Bayar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

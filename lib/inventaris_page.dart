import 'package:flutter/material.dart';

class InventarisPage extends StatefulWidget {
  const InventarisPage({super.key});

  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Inventaris', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductListView(),
                _buildProductListView(),
              ],
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: _buildTambahProdukButton()),
        ],
      ),
    );
  }

  void _showAturStokBottomSheet(BuildContext context, int currentStock) {
    String adjustmentType = 'Penambahan Stok';
    int adjustment = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int totalStock = adjustmentType == 'Penambahan Stok'
                ? currentStock + adjustment
                : currentStock - adjustment;

            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Stok saat ini: $currentStock',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: adjustmentType,
                          items: ['Penambahan Stok', 'Pengurangan Stok']
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              adjustmentType = val!;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (adjustment > 0) adjustment--;
                              });
                            },
                          ),
                          Text('$adjustment',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                adjustment++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Total stok: $totalStock',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Simpan perubahan ke state / backend
                        Navigator.pop(context);
                      },
                      child: const Text('Simpan'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.grey.shade400,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        indicatorPadding: const EdgeInsets.all(6),
        tabs: const [
          Tab(text: 'Semua Produk'),
          Tab(text: 'Stok Menipis'),
        ],
      ),
    );
  }

  Widget _buildProductListView() {
    return Column(
      children: [
        _buildFilterOptions(),
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) => _buildProductItem(index),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOptions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildFilterButton('Cari'),
          const SizedBox(width: 8),
          _buildFilterButton('Semua Produk'),
          const SizedBox(width: 8),
          _buildFilterButton('Urutkan'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black),
      ),
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildProductItem(int index) {
    return GestureDetector(
      onTap: () {
        _showAturStokBottomSheet(context, 100);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Stack(alignment: Alignment.center, children: [
              const CircleAvatar(backgroundColor: Colors.blue, radius: 20),
              Icon(
                Icons.food_bank,
                size: 20,
                color: Colors.white,
              ),
            ]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Paket A Mendoan',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Stok: 100'),
                  Text('Rp. 15.000',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                _showAturStokBottomSheet(context, 100);
              },
              child: const Text('Atur Stok'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTambahProdukButton() {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: const Text('+ Tambah Produk'),
      ),
    );
  }
}

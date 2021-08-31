part of 'pages.dart';

class FormGoodsPage extends GetView<StockController> {
  final int length;
  FormGoodsPage({ required this.length});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Input Data Barang')),
                    SizedBox(height: 24),
                    TextField(
                      controller: controller.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Nama barang'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.kategori,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Kategori'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.harga,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Harga'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.jumlah,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Jumlah/Quantity'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.satuan,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Satuan'),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 12),
              child: ElevatedButton(
                onPressed: () {
                  controller.createStock(length);
                },
                child: Text('Simpan'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

part of 'pages.dart';

enum Stock { inStock, outStock }

class StockUpdatePage extends StatefulWidget {
  final Goods goods;
  final Stock stock;
  const StockUpdatePage(this.goods, this.stock, {Key? key}) : super(key: key);

  @override
  _StockUpdatePageState createState() => _StockUpdatePageState();
}

class _StockUpdatePageState extends State<StockUpdatePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Branch? selectedBranch;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StockController>();
    final branch = Get.put(BranchController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text((widget.stock == Stock.outStock)
            ? 'Pengambilan Barang'
            : 'Penambahan Barang'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    labelText('Ambil Stok Barang'),
                    SizedBox(height: 24),
                    labelText('Kode Cabang'),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: ListTile(
                        title: Text((selectedBranch == null)
                            ? 'Pilih Kode Cabang'
                            : selectedBranch!.kodeCabang),
                        onTap: () {
                          Get.bottomSheet(Container(
                                  height: Get.height * 0.5,
                                  color: Colors.white,
                                  child: (branch.listBranch.isEmpty)
                                      ? CircularProgressIndicator()
                                      : ListView.builder(
                                          itemCount: branch.listBranch.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.back(
                                                    result: branch
                                                        .listBranch[index]);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(12),
                                                height: 45,
                                                width: double.infinity,
                                                child: Text(branch
                                                    .listBranch[index]
                                                    .kodeCabang),
                                              ),
                                            );
                                          },
                                        )))
                              .then((value) {
                            if (value != null && value is Branch) {
                              selectedBranch = value;
                              setState(() {});
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 12),

                    labelText('Nama Barang'),
                    SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText:
                              widget.goods.kdGoods + " - " + widget.goods.name),
                    ),
                    SizedBox(height: 12),
                    labelText('Stok Barang'),
                    SizedBox(height: 8),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: widget.goods.sumGoods.toString()),
                    ),
                    SizedBox(height: 12),
                    labelText('Tanggal Pengambilan'),
                    //Calender
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 25,
                        left: 0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: TableCalendar(
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          focusedDay: _focusedDay,
                          availableGestures: AvailableGestures.horizontalSwipe,
                          availableCalendarFormats: {
                            CalendarFormat.month: 'Months',
                          },
                          selectedDayPredicate: (day) {
                            // Use `selectedDayPredicate` to determine which day is currently selected.
                            // If this returns true, then `day` will be marked as selected.

                            // Using `isSameDay` is recommended to disregard
                            // the time-part of compared DateTime objects.
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDay, selectedDay)) {
                              // Call `setState()` when updating the selected day
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                                print(_selectedDay);
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            // No need to call `setState()` here
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.updateJumlah,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Jumlah Barang diambil'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      minLines: 1,
                      maxLines: 3,
                      controller: controller.keterangan,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Keterangan'),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 12),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (int.tryParse(controller.updateJumlah.text)! >
                                    int.tryParse(widget.goods.sumGoods)! &&
                                widget.stock == Stock.outStock) {
                              showBotToastText(
                                  'Jumlah ambil melebihi stok barang');
                            } else {
                              controller.updateStock(
                                  widget.goods.id,
                                  int.parse(widget.goods.sumGoods),
                                  widget.stock);
                              controller.manageStock(
                                widget.stock,
                                widget.goods,
                                cabang: selectedBranch!.id,
                                kodeCabang: selectedBranch!.kodeCabang,
                                date: formatter.format(_selectedDay!.toLocal()),
                              );
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget labelText(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
  );
}

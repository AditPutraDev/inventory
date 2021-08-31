part of 'pages.dart';

class DemandPage extends StatefulWidget {
  const DemandPage({Key? key}) : super(key: key);

  @override
  _DemandPageState createState() => _DemandPageState();
}

class _DemandPageState extends State<DemandPage> {
  final controller = Get.put(RequestController());
  final auth = Get.find<AuthController>();

  DateTime _focusedDay = DateTime.now();
  List<AHSform> data = [];
  List<Map<String, dynamic>> dataAHS = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Request'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          labelText('BUAT PERMINTAAN PERALATAN'),
          data.length <= 0
              ? SizedBox()
              : SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    itemCount: data.length,
                    itemBuilder: (ctx, i) => data[i],
                  ),
                ),
          SizedBox(height: 24),
          TextButton.icon(
              onPressed: onAddForm,
              icon: Icon(Icons.add),
              label: Text('Tambah')),
          Obx(
            () => controller.isLoading.value
                ? loadingMinIndicator
                : ElevatedButton(
                    onPressed: () {
                      onSave();
                    },
                    child: Text('Submit')),
          )
        ],
      ),
    );
  }

  ///on form user deleted
  void onDelete(AHS _user) {
    setState(() {
      var find = data.firstWhere(
        (it) => it.user == _user,
      );
      data.removeAt(data.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = AHS();
      data.add(AHSform(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  onSave() {
    int total = 0;
    if (data.length > 0) {
      var allValid = true;
      data.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        data.forEach((element) {
          int qty = int.tryParse(element.user!.qty)!;
          int angka = element.user!.hargaStauan.round() * qty;
          setState(() {
            total += angka;
          });
          return dataAHS.add({
            "nama_barang": element.user!.nameBarang,
            "qty": element.user!.qty,
            "harga_satuan": element.user!.hargaStauan,
            "jumlah": angka,
          });
        });
        print(dataAHS);
        print(total);
        if (total != 0) {
          Map<String, dynamic> dataJson = {
            "kode_cabang": "",
            "user_id": "${auth.user.value.userId}",
            "jumlah_barang": "${dataAHS.length}",
            "total_jumlah": '$total',
            "tgl_permintaan": formatter.format(_focusedDay.toLocal()),
            "periode_mr": formatter.format(_focusedDay.toLocal()),
            "status_permintaan": "pending",
            "barang": dataAHS,
          };
          controller.createRequest(dataJson);
        }
      }
    }
  }
}

typedef OnDelete();

class AHSform extends StatefulWidget {
  final AHS? user;
  final state = _AHSformState();
  final OnDelete? onDelete;

  AHSform({Key? key, this.user, this.onDelete}) : super(key: key);
  @override
  _AHSformState createState() => state;

  bool isValid() => state.validate();
}

class _AHSformState extends State<AHSform> {
  final form = GlobalKey<FormState>();
  Goods? goods;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StockController());

    return Padding(
      padding: EdgeInsets.all(2),
      child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12),
              width: double.infinity,
              height: 5,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: labelText('Nama Barang'),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35), color: Colors.white),
              child: ListTile(
                title: Text((goods == null)
                    ? 'Nama Barang'
                    : '${goods!.kdGoods} - ${goods!.name}'),
                onTap: () {
                  Get.bottomSheet(Container(
                          height: Get.height * 0.5,
                          color: Colors.white,
                          child: (controller.listGoods.isEmpty)
                              ? CircularProgressIndicator()
                              : ListView.builder(
                                  itemCount: controller.listGoods.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.back(
                                            result:
                                                controller.listGoods[index]);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(12),
                                        height: 45,
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: Text(controller
                                                .listGoods[index].kdGoods +
                                            " - " +
                                            controller.listGoods[index].name),
                                      ),
                                    );
                                  },
                                )))
                      .then((value) {
                    if (value != null && value is Goods) {
                      goods = value;
                      int harga = int.tryParse(goods!.harga)!;
                      widget.user!.hargaStauan = harga;
                      widget.user!.nameBarang = goods!.name;
                      setState(() {});
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: labelText('Kategori'),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35), color: Colors.white),
              child: ListTile(
                title:
                    Text((goods == null) ? 'Kategori' : '${goods!.kategori}'),
                onTap: () {},
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: labelText('Qty'),
                ),
                SizedBox(width: Get.width * 0.35),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: labelText('Satuan'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget.user!.qty,
                    onSaved: (String? val) => widget.user!.qty = val!,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Color(0xFF43A8FC),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 16, 0, 16),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Qty',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white),
                    child: ListTile(
                      title:
                          Text((goods == null) ? 'Satuan' : '${goods!.satuan}'),
                      onTap: () {},
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: labelText('Harga Satuan'),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35), color: Colors.white),
              child: ListTile(
                title:
                    Text((goods == null) ? 'Harga Satauan' : '${goods!.harga}'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}

class AHS {
  String title;
  String volume;
  String nameBarang;
  String kategori;
  String qty;
  String satuan;
  int hargaStauan;

  AHS({
    this.title = '',
    this.volume = '',
    this.nameBarang = '',
    this.kategori = '',
    this.qty = '',
    this.satuan = '',
    this.hargaStauan = 0,
  });
}

class Checkout extends StatelessWidget {
  final List<Map<String, dynamic>> dataAHS;

  Checkout(this.dataAHS, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(dataAHS);
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [],
        ));
  }
}

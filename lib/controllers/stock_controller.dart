part of 'controllers.dart';

class StockController extends GetxController {
  var isLoading = false.obs;
  RxList<Goods> listGoods = <Goods>[].obs;
  final RxList<Goods> searchList = <Goods>[].obs;

  var name = TextEditingController();
  var kategori = TextEditingController();
  var harga = TextEditingController();
  var jumlah = TextEditingController();
  var satuan = TextEditingController();
  var updateJumlah = TextEditingController();
  var keterangan = TextEditingController();

  final search = TextEditingController();
  var searchText = "".obs;
  var isTyping = false.obs;

  @override
  void onInit() {
    this.getStock();
    super.onInit();
    search.addListener(() {
      searchText = search.text.obs;
      search.text.length != 0 ? isTyping(true) : isTyping(false);
    });
  }

  void onSearch(searchText) async {
    searchList.clear();
    if (searchText.isEmpty) {
      return;
    }

    listGoods.forEach((element) {
      if (element.name.toLowerCase().contains(searchText.toLowerCase())) {
        searchList.add(element);
      }
    });
  }

  void onTyping() {
    isTyping(false);
    search.clear();
    searchList.clear();
  }

  void getStock() {
    try {
      listGoods.clear();
      Request request = Request(url: 'read_goods.php');
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => Goods.fromJson(e)).toList();
          if (v is List<Goods>) {
            listGoods.addAll(v);
            print(data);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void createStock(int idCabang) {
    try {
      idCabang++;
      Request request = Request(
        url: 'create_goods.php',
        body: {
          "id_barang": "BRG0$idCabang",
          "nama": name.text,
          "kategori": kategori.text,
          "harga": harga.text,
          "jumlah": jumlah.text,
          "satuan": satuan.text,
        },
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (res.statusCode == 200 && data['value'] == 1) {
          getStock();
          Get.back();
          showBotToastText(data['message']);
          isLoading.toggle();
        } else {
          showBotToastText(data['message']);
          isLoading.toggle();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void updateStock(String id, int stock, Stock type) {
    try {
      isLoading.toggle();
      print("id -> $id");
      var jumlah;
      if (type == Stock.outStock) {
        jumlah = stock - int.parse(updateJumlah.text);
      } else {
        jumlah = stock + int.parse(updateJumlah.text);
      }
      print(jumlah);
      Request request = Request(
        url: 'update_goods.php',
        body: {
          "id": id,
          "jumlah": '$jumlah',
        },
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (res.statusCode == 200 && data['value'] == 1) {
          getStock();
          Get.back();
          showBotToastText(data['message']);
          isLoading.toggle();
        } else {
          showBotToastText(data['message']);
          isLoading.toggle();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void manageStock(Stock type, Goods goods,
      {String cabang = '',
      String kodeCabang = '',
      String date = ''}) {
    try {
      Request request = Request(
        url: 'in_stock.php',
        body: (type == Stock.inStock)
            ? {
                "id_cabang": cabang,
                "kode_cabang": kodeCabang,
                "id_barang": goods.kdGoods,
                "nama_barang": goods.name,
                "jumlah_stok": goods.sumGoods,
                "stok_masuk": updateJumlah.text,
                "tgl_masuk": date,
              }
            : {
                "id_cabang": cabang,
                "kode_cabang": kodeCabang,
                "id_barang": goods.kdGoods,
                "nama_barang": goods.name,
                "jumlah_stok": goods.sumGoods,
                "stok_keluar": updateJumlah.text,
                "tgl_keluar": date,
              },
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (res.statusCode == 200 && data['value'] == 1) {
          Get.back();
          showBotToastText(data['message']);
        } else {
          showBotToastText(data['message']);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

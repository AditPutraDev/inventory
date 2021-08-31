part of 'controllers.dart';

class RequestController extends GetxController {
  var isLoading = false.obs;
  RxList<Opname> list = <Opname>[].obs;
  RxList<Opname> searchList = <Opname>[].obs;
  RxList<MaterialReq> listMaterial = <MaterialReq>[].obs;

  final search = TextEditingController();
  var searchText = "".obs;
  var isTyping = false.obs;

  @override
  void onInit() {
    this.getOpname();
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

    list.forEach((element) {
      if (element.namaBarang.toLowerCase().contains(searchText.toLowerCase())) {
        searchList.add(element);
      }
    });
  }

  void onTyping() {
    isTyping(false);
    search.clear();
    searchList.clear();
  }

  void createRequest(Map<String, dynamic> data) {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'create_request_many.php',
        body: json.encode(data),
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (res.statusCode == 200 && data['value'] == 1) {
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

  void getOpname() {
    try {
      isLoading.toggle();
      list.clear();
      Request request = Request(url: 'read_stock.php');
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => Opname.fromJson(e)).toList();
          if (v is List<Opname>) {
            list.addAll(v);
            print(data);
            isLoading.toggle();
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void getMR() {
    try {
      isLoading.toggle();
      listMaterial.clear();
      Request request = Request(url: 'read_request.php');
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => MaterialReq.fromJson(e)).toList();
          if (v is List<MaterialReq>) {
            listMaterial.addAll(v);
            print(data);
            isLoading.toggle();
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

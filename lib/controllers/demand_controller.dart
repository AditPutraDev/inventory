part of 'controllers.dart';

class DemandController extends GetxController {
  final requestCT = Get.put(RequestController());
  var isLoading = false.obs;
  RxList<Req> listReq = <Req>[].obs;

  @override
  void onInit() {
    this.getReq();
    super.onInit();
  }

  void getReq() {
    try {
      isLoading.toggle();
      listReq.clear();
      Request request = Request(url: 'read_item_req.php');
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => Req.fromJson(e)).toList();
          if (v is List<Req>) {
            listReq.addAll(v);
            print(data);
            isLoading.toggle();
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void changeStatus(String id, String status) {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'update_status.php',
        body: {"id_mr": id, "status_permintaan": status},
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (data['value'] == 1) {
          showBotToastText(data['message']);
          Get.back();
          requestCT.getMR();
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
}

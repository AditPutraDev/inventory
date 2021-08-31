part of 'controllers.dart';

enum BranchStatus { create, delete }

class BranchController extends GetxController {
  RxList<Branch> listBranch = <Branch>[].obs;

  var kode = TextEditingController();
  var namaBandara = TextEditingController();
  var namaKontrak = TextEditingController();
  var nilaiKontrak = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    this.getBranch();
    super.onInit();
  }

  void getBranch() {
    try {
      isLoading.toggle();
      listBranch.clear();
      Request request = Request(url: 'read_cabang.php');
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => Branch.fromJson(e)).toList();
          if (v is List<Branch>) {
            listBranch.addAll(v);
            isLoading.toggle();
            print(data);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void manageBranch(BranchStatus type,
      {String? id, String? periode, String? awal, String? akhir}) {
    try {
      isLoading.toggle();
      Request request = Request(
        url: type == BranchStatus.create
            ? 'create_cabang.php'
            : 'delete_cabang.php',
        body: (type == BranchStatus.create)
            ? {
                "kode_cabang": kode.text,
                "nama_bandara": namaBandara.text,
                "nama_kontrak": namaKontrak.text,
                "nilai_kontrak": nilaiKontrak.text,
                "periode": periode,
                "awal_kontrak": awal,
                "berakhir_kontrak": akhir,
              }
            : {
                "id_cabang": id,
              },
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (res.statusCode == 200 && data['value'] == 1) {
          getBranch();
          if (type == BranchStatus.create) Get.back();
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
}

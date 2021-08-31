part of 'controllers.dart';

class AuthController extends GetxController {
  var email = TextEditingController(text: 'dev@gmail.com');
  var password = TextEditingController(text: 'dev');
  var newPass = TextEditingController();
  var reNewPass = TextEditingController();

  Rx<User> user = User().obs;
  RxList<User> listUser = <User>[].obs;

  var isLoading = false.obs;
  var siluet =
      'https://w7.pngwing.com/pngs/267/604/png-transparent-computer-icons-avatar-employees-icon-silhouette-user-shoulder.png';
  var background =
      'https://cohive.space/sojuhanjan/wp-content/uploads/2021/04/Apa-Itu-FGD-Focus-Group-Discussion-Dalam-Dunia-Kerja-1024x616.jpg';

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() {
    try {
      isLoading.toggle();
      listUser.clear();
      Request request = Request(url: 'read_user.php');
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => User.fromJson(e)).toList();
          if (v is List<User>) {
            listUser.addAll(v);
            isLoading.toggle();
            print(data);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void login() {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'sign_in.php',
        body: {"email": email.text, "password": password.text},
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (data['value'] == 1) {
          user.update((val) {
            val!.nama = data['nama'];
            val.username = data['username'];
            val.email = data['email'];
            val.role = data['role'];
            val.phone = data['phone'];
            val.jabatan = data['jabatan'];
            val.userId = data['user_id'];
          });
          print(data);
          showBotToastText(data['message']);
          Get.off(() => MainPage());
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

  matchPass() {
    if (newPass.text != reNewPass.text) {
      showBotToastText('Kata sandi baru harus sama');
    } else {
      changePass();
    }
  }

  void changePass() {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'update_password.php',
        body: {"user_id": user.value.userId, "password": newPass.text},
      );
      request.post().then((res) {
        final data = json.decode(res.body);
        if (data['value'] == 1) {
          showBotToastText(data['message']);
          Get.back();
          newPass.clear();
          reNewPass.clear();
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

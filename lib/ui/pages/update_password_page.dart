part of 'pages.dart';

class UpdatePasswordPage extends GetView<AuthController> {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Kata Sandi'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          labelText('Masukkan kata sandi lama Anda'),
          SizedBox(height: 12),
          TextField(
            //controller: controller.name,
            obscureText: true,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Kata sandi lama'),
          ),
          SizedBox(height: 24),
          labelText('Masukkan kata sandi baru Anda'),
          SizedBox(height: 12),
          TextField(
            controller: controller.newPass,
            obscureText: true,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Kata sandi baru'),
          ),
          SizedBox(height: 12),
          TextField(
            controller: controller.reNewPass,
            obscureText: true,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Ulangi kata sandi baru'),
          ),
          SizedBox(height: 45),
          Obx(
            () => (controller.isLoading.value)
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.matchPass();
                    },
                    child: Text('Ganti kata sandi'),
                  ),
          ),
        ],
      ),
    );
  }
}

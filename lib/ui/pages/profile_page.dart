part of 'pages.dart';

class ProfilePage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  controller.background,
                  width: double.infinity,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 42),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(controller.siluet),
                        ),
                        SizedBox(height: 12),
                        Container(
                            padding: EdgeInsets.all(6),
                            color: Colors.black54,
                            child: Column(children: [
                              Text(
                                controller.user.value.nama.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                controller.user.value.jabatan.toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                rowLine('-', title: 'Lokasi Kerja'),
                rowLine(controller.user.value.email, title: 'Email'),
                rowLine(controller.user.value.phone, title: 'Telepon'),
              ]),
            ),
          ),
          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                rowLine('Ubah kata sandi', icon: Icons.lock, onTap: () {
                  print('sandi');
                  Get.to(() => UpdatePasswordPage());
                }),
                rowLine('Keluar', icon: Icons.logout, onTap: () {
                  print('keluar');
                  Get.offAll(() => MyHomePage());
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowLine(String data,
      {String? title, IconData icon = Icons.person, Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: (title != null) ? null : onTap,
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: (title != null)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              (title != null)
                  ? Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Icon(icon),
              (title != null) ? SizedBox() : SizedBox(width: 12),
              Text('$data')
            ],
          ),
        ),
      ),
    );
  }
}

part of 'pages.dart';

class BerandaPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            color: Colors.blue,
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://foto.kontan.co.id/Y-oL3JnnlB7VnUWuMGCjW25Ixao=/smart/2020/10/19/1722209303p.jpg'),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: Text(
                    controller.user.value.nama.toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'MENU UTAMA',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              menus(
                title: 'STOK BARANG',
                color: Colors.green,
                icon: Icons.storage,
                onTap: () => Get.to(() => StockPage()),
              ),
              menus(
                title: 'PERMINTAAN BARANG',
                color: Colors.blue,
                icon: Icons.shopping_cart_sharp,
                onTap: () => Get.to(() => DemandPage()),
              ),
            ],
          ),
          Row(
            children: [
              menus(
                title: 'LAPORAN PERMINTAAN',
                color: Colors.amber,
                icon: Icons.insights_rounded,
                onTap: () => Get.to(() => DemandReportPage()),
              ),
              menus(
                title: 'LAPORAN KELUAR MASUK BARANG',
                color: Colors.red,
                icon: Icons.local_shipping,
                onTap: () => Get.to(() => OpnamePage()),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                menus(
                  title: 'Daftar Cabang',
                  color: Colors.blue,
                  icon: Icons.auto_stories,
                  onTap: () => Get.to(() => BranchPage('Daftar Cabang')),
                ),
                menus(
                  title: 'Persetujuan Atasan',
                  color: Colors.blue,
                  icon: Icons.assignment_ind,
                  onTap: () => Get.to(() => ApprovedPage()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget menus(
      {IconData? icon,
      Color? color,
      String? title,
      Function()? onTap,
      Color? txtColor}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 115,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 42),
              SizedBox(height: 12),
              Text(
                '$title',
                style: TextStyle(
                    color: txtColor == null ? Colors.white : txtColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

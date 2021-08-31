part of 'pages.dart';

enum Type { demand, approve, notif }

class DemandDetailPage extends StatelessWidget {
  final String id;
  final MaterialReq material;
  final Type type;
  const DemandDetailPage(this.id, this.material, this.type, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DemandController());
    final user = Get.find<AuthController>();
    controller.getReq();
    String title = ' Detail Perimntaan';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Obx(
        () => ListView(
          children: [
            statusClip(material.status, Colors.green),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text("Diajukan pada " + material.tglPermintaan),
            ),
            Padding(
              padding: EdgeInsets.only(left: 9, top: 12),
              child: labelText(title),
            ),
            controller.isLoading.value
                ? loadingMinIndicator
                : Column(
                    children: controller.listReq
                        .map((e) =>
                            (id != e.idMR) ? SizedBox() : DetailDemandPage(e))
                        .toList()),
            Padding(
              padding: EdgeInsets.only(left: 9, top: 12),
              child: labelText('Diajukan Oleh'),
            ),
            user.isLoading.value
                ? loadingMinIndicator
                : Column(
                    children: user.listUser
                        .map(
                          (e) => (user.user.value.userId != e.userId)
                              ? SizedBox()
                              : Card(
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    width: double.infinity,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Nama : ${e.nama}'),
                                          Text('Jabatan : ${e.jabatan}'),
                                          Text('Telepon : ${e.phone}')
                                        ]),
                                  ),
                                ),
                        )
                        .toList()),
          ],
        ),
      ),
      floatingActionButton: controller.isLoading.value
          ? loadingMinIndicator
          : (type == Type.notif)
              ? SizedBox()
              : ElevatedButton(
                  onPressed: (material.status == 'diterima')
                      ? null
                      : () {
                          if (type == Type.approve) {
                            controller.changeStatus(id, 'disetujui');
                          } else {
                            Get.defaultDialog(
                              title: 'KONFIRMASI',
                              content: Text(
                                  'Apakah Anda yakin barang sudah diterima sesuai dengan barang yang sudah Anda ajukan?',
                                  textAlign: TextAlign.center),
                              onConfirm: () {
                                controller.changeStatus(id, 'diterima');
                              },
                              textConfirm: 'Terima',
                              confirmTextColor: Colors.white,
                            );
                          }
                        },
                  child: Text((type == Type.approve)
                      ? 'Approve'
                      : (material.status == 'diterima')
                          ? 'Barang Diterima'
                          : 'Terima Barang'),
                ),
    );
  }
}

class DetailDemandPage extends StatelessWidget {
  final Req _req;
  const DetailDemandPage(this._req, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Nama Barang : " + _req.nama),
              Text("Harga Satuan: " + _req.harga),
              Text("Qty         : " + _req.qty),
              Text("jumlah      : " + _req.jumlah),
            ],
          ),
        ),
      ),
    );
  }
}

Widget statusClip(String status, Color color) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          status,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

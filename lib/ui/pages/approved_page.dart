part of 'pages.dart';

class ApprovedPage extends StatelessWidget {
  const ApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestController());
    final user = Get.find<AuthController>();

    controller.getMR();
    return Scaffold(
      appBar: AppBar(
        title: Text('Persetujuan Atasan'),
      ),
      body: Obx(
        () => ListView(
          children: [
            controller.isLoading.value
                ? loadingMinIndicator
                : Column(
                    children: controller.listMaterial
                        .map((e) => GestureDetector(
                              onTap: (e.status == 'disetujui' &&
                                      user.user.value.role != 'manager')
                                  ? () {}
                                  : () {
                                      Get.to(() => DemandDetailPage(e.idMR, e, Type.approve));
                                    },
                              child: Card(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Material Request',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)),
                                          Row(children: [
                                            CircleAvatar(radius: 4),
                                            SizedBox(width: 8),
                                            Text((e.status == 'pending')
                                                ? 'Belum disetujui'
                                                : 'Sudah Diterima')
                                          ]),
                                        ],
                                      ),
                                      Text(e.tglPermintaan),
                                      Text(
                                          'Material Request periode ${e.periodeMr}'),
                                      Text(NumberFormat.currency(
                                              locale: 'id', symbol: 'Rp ')
                                          .format(int.parse(e.total))),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}

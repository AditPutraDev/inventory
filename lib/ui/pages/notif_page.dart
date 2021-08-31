part of 'pages.dart';

class NotifPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestController());
    controller.getMR();
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: Obx(
        () => ListView(
          children: [
            controller.isLoading.value
                ? loadingMinIndicator
                : Column(
                    children: controller.listMaterial
                        .map((e) => GestureDetector(
                              onTap: () {
                                Get.to(() =>
                                    DemandDetailPage(e.idMR, e, Type.notif));
                              },
                              child: (e.status != 'disetujui')
                                  ? SizedBox()
                                  : Card(
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Material Request Disetujui',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue)),
                                              ],
                                            ),
                                            Text(e.tglPermintaan),
                                            Text(
                                                'Material Request periode ${e.periodeMr}'),
                                            Text(NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp ')
                                                    .format(
                                                        int.parse(e.total)) +
                                                " yang anda ajukan terlah disetujui"),
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

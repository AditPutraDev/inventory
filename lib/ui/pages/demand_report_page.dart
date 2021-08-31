part of 'pages.dart';

class DemandReportPage extends StatelessWidget {
  const DemandReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestController());
    controller.getMR();
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Permintaan'),
      ),
      body: Obx(
        () => ListView(
          children: [
            controller.isLoading.value
                ? loadingMinIndicator
                : Column(
                    children: controller.listMaterial
                        .map((e) => GestureDetector(
                              onTap: (e.status == 'pending')
                                  ? () {}
                                  : () {
                                      Get.to(() => DemandDetailPage(
                                          e.idMR, e, Type.demand));
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
                                          (e.status == 'pending')
                                              ? CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 18,
                                                  child: Icon(Icons.close,
                                                      size: 25,
                                                      color: Colors.white),
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  radius: 18,
                                                  child: Icon(Icons.done,
                                                      size: 25,
                                                      color: Colors.white),
                                                )
                                        ],
                                      ),
                                      Text(e.tglPermintaan),
                                      Text(
                                          'Pengajuan permintaan peralatan periode ${e.periodeMr}')
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

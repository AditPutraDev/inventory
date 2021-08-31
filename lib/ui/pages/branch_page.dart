part of 'pages.dart';

class BranchPage extends StatelessWidget {
  final String title;
  const BranchPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BranchController());
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Obx(
        () => ListView(
          children: [
            (controller.isLoading.value)
                ? SizedBox(
                    height: Get.height / 2,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : (controller.listBranch.length != 0)
                    ? Column(
                        children: controller.listBranch
                            .map((e) => BranchList(
                                  e,
                                  onDelete: () => controller.manageBranch(
                                      BranchStatus.delete,
                                      id: e.id),
                                ))
                            .toList())
                    : Center(child: Text('Data Kosong')),
            SizedBox(height: 90),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(() => FormBranchPage()),
      ),
    );
  }
}

class BranchList extends StatelessWidget {
  final Branch branch;
  final Function() onDelete;
  BranchList(this.branch, {required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() {}),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(branch.namaBandara),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  branch.namaKontrak,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
              Text(NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                  .format(int.parse(branch.nilaiKontrak))),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}

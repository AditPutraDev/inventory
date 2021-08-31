part of 'pages.dart';

class OpnameResultPage extends GetView<RequestController> {
  final String filter;
  final String title;
  const OpnameResultPage(this.filter, this.title,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(filter);
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Obx(
        () => ListView(
          children: [
            TextField(
              controller: controller.search,
              onChanged: (text) {
                controller.onSearch(controller.search.text);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  suffixIcon: (controller.isTyping.value)
                      ? IconButton(
                          onPressed: () => controller.onTyping(),
                          icon: Icon(Icons.close_rounded, color: Colors.black),
                        )
                      : SizedBox(),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search'),
            ),
            (controller.isLoading.value)
                ? loadingMinIndicator
                : (controller.searchList.length == 0 &&
                        controller.search.text.isEmpty)
                    ? Column(
                        children: controller.list
                            .map((e) => OpnameItem(e, filter))
                            .toList())
                    : (controller.searchList.length != 0)
                        ? Column(
                            children: controller.searchList
                                .map((e) => OpnameItem(e, filter))
                                .toList())
                        : Center(child: Text('Data Kosong')),
            SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

class OpnameItem extends StatelessWidget {
  final Opname opname;
  final String filter;
  OpnameItem(this.opname, this.filter);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() {}),
      child: (filter != opname.createAt.substring(0, 7))
          ? SizedBox()
          : Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(opname.idBarang),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        opname.namaBarang,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       Get.to(() => StockUpdatePage(goods, Stock.outStock));
                    //     },
                    //     icon: Icon(Icons.remove)),
                    Text(opname.jumlahStok),
                    SizedBox(width: 8), Text(opname.createAt.substring(0, 7))
                    // IconButton(
                    //     onPressed: () {
                    //       Get.to(() => StockUpdatePage(goods, Stock.inStock));
                    //     },
                    //     icon: Icon(Icons.add)),
                  ],
                ),
              ),
            ),
    );
  }
}

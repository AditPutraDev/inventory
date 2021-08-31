part of 'pages.dart';

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StockController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Barang'),
      ),
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
            (controller.searchList.length == 0 &&
                    controller.search.text.isEmpty)
                ? Column(
                    children: controller.listGoods
                        .map((e) => GoodsListItem(e))
                        .toList())
                : (controller.searchList.length != 0)
                    ? Column(
                        children: controller.searchList
                            .map((e) => GoodsListItem(e))
                            .toList())
                    : Text('Data Kosong'),
            SizedBox(height: 90),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(
          () => FormGoodsPage(length: controller.listGoods.length),
        ),
      ),
    );
  }
}

class GoodsListItem extends StatelessWidget {
  final Goods goods;

  GoodsListItem(this.goods);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() {}),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(goods.kdGoods),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  goods.name,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.to(() => StockUpdatePage(goods, Stock.outStock));
                  },
                  icon: Icon(Icons.remove)),
              Text(goods.sumGoods),
              IconButton(
                  onPressed: () {
                    Get.to(() => StockUpdatePage(goods, Stock.inStock));
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}

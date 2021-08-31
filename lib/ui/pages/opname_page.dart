part of 'pages.dart';

class OpnamePage extends StatefulWidget {
  const OpnamePage({Key? key}) : super(key: key);

  @override
  _OpnamePageState createState() => _OpnamePageState();
}

class _OpnamePageState extends State<OpnamePage> {
  DateTime selectedDate = DateTime.now();
  List<Container> months = [];
  var dataM = [
    {"bulan": "Januari", "no": "01"},
    {"bulan": "Februari", "no": "02"},
    {"bulan": "Maret", "no": "03"},
    {"bulan": "April", "no": "04"},
    {"bulan": "Mei", "no": "05"},
    {"bulan": "Juni", "no": "06"},
    {"bulan": "Juli", "no": "07"},
    {"bulan": "Agustus", "no": "08"},
    {"bulan": "September", "no": "09"},
    {"bulan": "Oktober", "no": "10"},
    {"bulan": "November", "no": "11"},
    {"bulan": "Desember", "no": "12"},
  ];

  _buildList() async {
    for (var i = 0; i < dataM.length; i++) {
      final data = dataM[i];
      months.add(
        Container(
          margin: EdgeInsets.all(12),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => OpnameResultPage(
                  '${selectedDate.year}-' + data['no']!, data['bulan']!));
              setState(() {
                print(selectedDate.year);
                print(data["bulan"]);
                print(data["no"]);
              });
            },
            child: Center(
              child: Text(
                data["bulan"] ?? '',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _buildList();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RequestController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Opname'),
      ),
      body: SingleChildScrollView(
        child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              buttonCustom(
                  onPressed: () => handleReadOnlyInputClick(context),
                  value: "${selectedDate.year}".split(' ')[0]),
              Container(
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: months))
            ]),
      ),
    );
  }

  buttonCustom({required Function() onPressed, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            value!,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> handleReadOnlyInputClick(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width,
              child: YearPicker(
                initialDate: selectedDate,
                selectedDate: selectedDate,
                firstDate: DateTime(1995),
                lastDate: DateTime.now(),
                onChanged: (val) {
                  //print(val);
                  setState(() {
                    selectedDate = val;
                  });
                  Get.back();
                },
              ),
            ));
  }
}

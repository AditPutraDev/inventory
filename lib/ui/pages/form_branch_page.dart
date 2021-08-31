part of 'pages.dart';

class FormBranchPage extends StatefulWidget {
  @override
  _FormBranchPageState createState() => _FormBranchPageState();
}

class _FormBranchPageState extends State<FormBranchPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _periodeDay;
  DateTime? _awalDay;
  DateTime? _akhirDay;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BranchController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Cabang'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Input Data Cabang')),
                    SizedBox(height: 24),
                    TextField(
                      controller: controller.kode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Kode Cabang'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.namaBandara,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Nama Bandara'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.namaKontrak,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Nama Kontrak'),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller.nilaiKontrak,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Nilai Kontrak'),
                    ),
                    SizedBox(height: 24),
                    labelText('Periode'),
                    //Calender
                    TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      availableCalendarFormats: {
                        CalendarFormat.month: 'Months',
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_periodeDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_periodeDay, selectedDay)) {
                          setState(() {
                            _periodeDay = selectedDay;
                            _focusedDay = focusedDay;
                            print(_periodeDay);
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(height: 24),
                    labelText('Awal Kontrak'),
                    //Calender
                    TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      availableCalendarFormats: {
                        CalendarFormat.month: 'Months',
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_awalDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_awalDay, selectedDay)) {
                          setState(() {
                            _awalDay = selectedDay;
                            _focusedDay = focusedDay;
                            print(_awalDay);
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(height: 24),
                    labelText('Akhir Kontrak'),
                    //Calender
                    TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      availableCalendarFormats: {
                        CalendarFormat.month: 'Months',
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_akhirDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_akhirDay, selectedDay)) {
                          setState(() {
                            _akhirDay = selectedDay;
                            _focusedDay = focusedDay;
                            print(_akhirDay);
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12, bottom: 12),
                          child: (controller.isLoading.value)
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () {
                                    controller.manageBranch(
                                      BranchStatus.create,
                                      periode: formatter
                                          .format(_periodeDay!.toLocal()),
                                      awal: formatter
                                          .format(_periodeDay!.toLocal()),
                                      akhir: formatter
                                          .format(_periodeDay!.toLocal()),
                                    );
                                  },
                                  child: Text('Simpan'),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

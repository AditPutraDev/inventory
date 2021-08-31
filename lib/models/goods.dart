part of 'models.dart';

class Goods {
  String id;
  String kdGoods;
  String name;
  String kategori;
  String harga;
  String sumGoods;
  String satuan;
  Goods(
      {this.id = '',
      this.kdGoods = '',
      this.name = '',
      this.sumGoods = '0',
      this.kategori = '',
      this.harga = '',
      this.satuan = ''});
  factory Goods.fromJson(Map<String, dynamic> map) {
    return Goods(
      id: map['id'],
      kdGoods: map['id_barang'],
      name: map['nama'],
      harga: map['harga'],
      kategori: map['kategori'],
      satuan: map['satuan'],
      sumGoods: map['jumlah'],
    );
  }
}

class AccessRoad {
  int? id;
  String? text;

  AccessRoad({this.id, this.text});
  factory AccessRoad.fromJson(Map<String, dynamic> map) {
    return AccessRoad(id: map['id'], text: map['text']);
  }
}

class Opname {
  String idBarang;
  String namaBarang;
  String jumlahStok;
  String stokMasuk;
  String stokKeluar;
  String tglMasuk;
  String tglKeluar;
  String createAt;
  Opname({
    this.idBarang = '',
    this.namaBarang = '',
    this.jumlahStok = '',
    this.stokMasuk = '',
    this.stokKeluar = '',
    this.tglMasuk = '',
    this.tglKeluar = '',
    this.createAt = '',
  });
  factory Opname.fromJson(Map<String, dynamic> map) {
    return Opname(
      idBarang: map['id_barang'],
      namaBarang: map['nama_barang'],
      jumlahStok: map['jumlah_stok'],
      stokMasuk: map['stok_masuk'],
      stokKeluar: map['stok_keluar'],
      tglMasuk: map['tgl_masuk'],
      tglKeluar: map['tgl_keluar'],
      createAt: map['created_at'],
    );
  }
}

class MaterialReq {
  String idMR;
  String jumlahBarang;
  String total;
  String tglPermintaan;
  String periodeMr;
  String status;
  MaterialReq({
    this.idMR = '',
    this.jumlahBarang = '',
    this.total = '',
    this.tglPermintaan = '',
    this.periodeMr = '',
    this.status = '',
  });
  factory MaterialReq.fromJson(Map<String, dynamic> map) {
    return MaterialReq(
      idMR: map['id_mr'],
      jumlahBarang: map['jumlah_barang'],
      total: map['total_jumlah'],
      tglPermintaan: map['tgl_permintaan'],
      periodeMr: map['periode_mr'],
      status: map['status_permintaan'],
    );
  }
}

class Req {
  String id;
  String idMR;
  String nama;
  String harga;
  String qty;
  String jumlah;
  Req({
    this.id = '',
    this.idMR = '',
    this.nama = '',
    this.harga = '',
    this.qty = '',
    this.jumlah = '',
  });
  factory Req.fromJson(Map<String, dynamic> map) {
    return Req(
      id: map['id_request'],
      idMR: map['id_mr'],
      nama: map['nama_barang'],
      harga: map['harga_satuan'],
      qty: map['qty'],
      jumlah: map['jumlah'],
    );
  }
}

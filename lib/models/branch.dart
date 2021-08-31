part of 'models.dart';

class Branch {
  String id;
  String kodeCabang;
  String namaBandara;
  String namaKontrak;
  String nilaiKontrak;
  String periode;
  String awalKontrak;
  String akhirKontrak;
  Branch(
      {this.id = '',
      this.kodeCabang = '',
      this.namaBandara = '',
      this.namaKontrak = '',
      this.nilaiKontrak = '',
      this.periode = '',
      this.akhirKontrak = '',
      this.awalKontrak = ''});
  factory Branch.fromJson(Map<String, dynamic> map) {
    return Branch(
      id: map['id_cabang'],
      kodeCabang: map['kode_cabang'],
      namaBandara: map['nama_bandara'],
      namaKontrak: map['nama_kontrak'],
      nilaiKontrak: map['nilai_kontrak'],
      periode: map['periode'],
      awalKontrak: map['awal_kontrak'],
      akhirKontrak: map['berakhir_kontrak'],
    );
  }
}

import '../exceptions/data_tidak_valid_exception.dart';

/// Class induk (abstract) untuk seluruh barang di Toko Vina.
/// Menerapkan Encapsulation: field private + getter/setter + validasi.
abstract class Item {
  String _nama;
  double _harga;
  int _stok;

  Item(String nama, double harga, int stok)
      : _nama = _validasiNama(nama),
        _harga = _validasiHarga(harga),
        _stok = _validasiStok(stok);

  // ----- Getter -----
  String get nama => _nama;
  double get harga => _harga;
  int get stok => _stok;

  /// Nilai total barang ini di rak (harga satuan x stok).
  double get totalNilai => _harga * _stok;

  // ----- Setter (dengan validasi) -----
  set nama(String value) => _nama = _validasiNama(value);
  set harga(double value) => _harga = _validasiHarga(value);
  set stok(int value) => _stok = _validasiStok(value);

  // ----- Validasi statis, dipakai constructor & setter sekaligus -----
  static String _validasiNama(String value) {
    if (value.trim().isEmpty) {
      throw DataTidakValidException('Nama barang tidak boleh kosong');
    }
    return value.trim();
  }

  static double _validasiHarga(double value) {
    if (value < 0) {
      throw DataTidakValidException('Harga tidak boleh negatif');
    }
    return value;
  }

  static int _validasiStok(int value) {
    if (value < 0) {
      throw DataTidakValidException('Stok tidak boleh negatif');
    }
    return value;
  }

  /// Polymorphism: setiap turunan wajib punya cara tampil sendiri.
  void tampilkanInfo();
}

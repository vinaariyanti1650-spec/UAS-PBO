import '../models/item.dart';

/// Mengelola seluruh data barang Toko Vina.
/// Menerapkan Collection (List, Map, Set), Higher Order Function,
/// dan simulasi penyimpanan Async/Await.
class Manager {
  final List<Item> _items = [];
  final Map<String, int> _jumlahPerKategori = {};
  final Set<String> _kategoriTersedia = {};

  List<Item> get items => List.unmodifiable(_items);
  List<String> get daftarKategori => _kategoriTersedia.toList();
  Map<String, int> get jumlahPerKategori => Map.unmodifiable(_jumlahPerKategori);

  void tambah(Item item) {
    _items.add(item);
    final kategori = item.runtimeType.toString();
    _kategoriTersedia.add(kategori);
    _jumlahPerKategori[kategori] = (_jumlahPerKategori[kategori] ?? 0) + 1;
  }

  void tampilkanSemua() {
    if (_items.isEmpty) {
      print('Belum ada data barang.');
      return;
    }
    for (var item in _items) {
      item.tampilkanInfo(); // Polymorphism: setiap item tampil sesuai jenisnya
    }
  }

  /// HOF: where()
  void cari(String keyword) {
    final hasil =
        _items.where((i) => i.nama.toLowerCase().contains(keyword.toLowerCase()));
    if (hasil.isEmpty) {
      print('Tidak ditemukan barang dengan kata kunci "$keyword".');
      return;
    }
    for (var item in hasil) {
      item.tampilkanInfo();
    }
  }

  /// HOF: fold()
  double hitungTotalNilaiStok() {
    return _items.fold(0.0, (total, item) => total + item.totalNilai);
  }

  /// HOF: any()
  bool adaBarangHampirHabis({int batasStok = 5}) {
    return _items.any((item) => item.stok <= batasStok);
  }

  /// HOF: every()
  bool semuaBarangTersedia() {
    if (_items.isEmpty) return false;
    return _items.every((item) => item.stok > 0);
  }

  /// Async/Await: simulasi proses penyimpanan data.
  Future<void> simpanData() async {
    print('Menyimpan data...');
    await Future.delayed(Duration(seconds: 2));
    print('Data berhasil disimpan.');
  }
}

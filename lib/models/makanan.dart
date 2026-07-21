import 'item.dart';

class Makanan extends Item {
  DateTime tanggalKedaluwarsa;

  Makanan(String nama, double harga, int stok, this.tanggalKedaluwarsa)
      : super(nama, harga, stok);

  bool get sudahKedaluwarsa => DateTime.now().isAfter(tanggalKedaluwarsa);

  @override
  void tampilkanInfo() {
    final tgl = tanggalKedaluwarsa.toIso8601String().split('T')[0];
    final status = sudahKedaluwarsa ? 'KEDALUWARSA' : 'Masih Layak';
    print('[Makanan] $nama'.padRight(30) +
        '| Rp${harga.toStringAsFixed(0).padLeft(9)} '
            '| Stok: ${stok.toString().padLeft(3)} '
            '| ED: $tgl ($status)');
  }
}

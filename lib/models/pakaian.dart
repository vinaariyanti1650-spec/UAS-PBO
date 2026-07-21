import 'item.dart';
import '../exceptions/data_tidak_valid_exception.dart';

class Pakaian extends Item {
  String _ukuran;

  Pakaian(String nama, double harga, int stok, String ukuran)
      : _ukuran = _validasiUkuran(ukuran),
        super(nama, harga, stok);

  String get ukuran => _ukuran;
  set ukuran(String value) => _ukuran = _validasiUkuran(value);

  static String _validasiUkuran(String value) {
    final v = value.trim().toUpperCase();
    const valid = {'XS', 'S', 'M', 'L', 'XL', 'XXL'};
    if (!valid.contains(v)) {
      throw DataTidakValidException(
          'Ukuran harus salah satu dari: ${valid.join(', ')}');
    }
    return v;
  }

  @override
  void tampilkanInfo() {
    print('[Pakaian]  $nama'.padRight(30) +
        '| Rp${harga.toStringAsFixed(0).padLeft(9)} '
            '| Stok: ${stok.toString().padLeft(3)} '
            '| Ukuran: $_ukuran');
  }
}

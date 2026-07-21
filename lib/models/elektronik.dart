import 'item.dart';
import '../exceptions/data_tidak_valid_exception.dart';

class Elektronik extends Item {
  int _garansiBulan;

  Elektronik(String nama, double harga, int stok, int garansiBulan)
      : _garansiBulan = _validasiGaransi(garansiBulan),
        super(nama, harga, stok);

  int get garansiBulan => _garansiBulan;
  set garansiBulan(int value) => _garansiBulan = _validasiGaransi(value);

  static int _validasiGaransi(int value) {
    if (value < 0) {
      throw DataTidakValidException('Garansi tidak boleh negatif');
    }
    return value;
  }

  @override
  void tampilkanInfo() {
    print('[Elektronik] $nama'.padRight(30) +
        '| Rp${harga.toStringAsFixed(0).padLeft(9)} '
            '| Stok: ${stok.toString().padLeft(3)} '
            '| Garansi: $_garansiBulan bln');
  }
}

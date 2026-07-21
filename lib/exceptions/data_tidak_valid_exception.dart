/// Exception khusus yang dilempar ketika data barang tidak memenuhi aturan
/// validasi (nama kosong, harga negatif, stok negatif, format input salah).
class DataTidakValidException implements Exception {
  final String pesan;
  DataTidakValidException(this.pesan);

  @override
  String toString() => 'DataTidakValidException: $pesan';
}

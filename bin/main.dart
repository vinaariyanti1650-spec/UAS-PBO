import 'dart:io';
import '../lib/models/item.dart';
import '../lib/models/elektronik.dart';
import '../lib/models/makanan.dart';
import '../lib/models/pakaian.dart';
import '../lib/controllers/manager.dart';
import '../lib/exceptions/data_tidak_valid_exception.dart';

final Manager manager = Manager();

void main() async {
  _isiDataAwal();

  bool keluar = false;
  while (!keluar) {
    _tampilkanMenu();
    stdout.write('Pilih menu (1-6): ');
    final pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        _tambahData();
        break;
      case '2':
        _lihatSemuaData();
        break;
      case '3':
        _cariData();
        break;
      case '4':
        _hitungTotal();
        break;
      case '5':
        await manager.simpanData();
        break;
      case '6':
        keluar = true;
        print('Terima kasih telah menggunakan Sistem Toko Vina.');
        break;
      default:
        print('Pilihan tidak valid. Silakan pilih angka 1-6.');
    }
    if (!keluar) print(''); // jarak antar-menu biar rapi dibaca
  }
}

void _tampilkanMenu() {
  print('===== SISTEM TOKO VINA =====');
  print('1. Tambah Data');
  print('2. Lihat Semua Data');
  print('3. Cari Data');
  print('4. Hitung Total');
  print('5. Simpan Data');
  print('6. Keluar');
}

/// Data contoh supaya menu 2-4 langsung punya sesuatu untuk ditampilkan.
void _isiDataAwal() {
  try {
    manager.tambah(Elektronik('Kipas Angin Mini', 85000, 12, 6));
    manager.tambah(Makanan('Biskuit Coklat', 15000, 30, DateTime(2026, 12, 31)));
    manager.tambah(Pakaian('Kaos Polos', 45000, 20, 'L'));
  } on DataTidakValidException catch (e) {
    print(e);
  }
}

void _tambahData() {
  try {
    stdout.write('Pilih jenis barang (1=Elektronik, 2=Makanan, 3=Pakaian): ');
    final jenis = stdin.readLineSync();

    stdout.write('Nama barang: ');
    final nama = stdin.readLineSync() ?? '';

    stdout.write('Harga: ');
    final harga = double.parse((stdin.readLineSync() ?? '').trim());

    stdout.write('Stok: ');
    final stok = int.parse((stdin.readLineSync() ?? '').trim());

    Item itemBaru;
    switch (jenis) {
      case '1':
        stdout.write('Garansi (bulan): ');
        final garansi = int.parse((stdin.readLineSync() ?? '0').trim());
        itemBaru = Elektronik(nama, harga, stok, garansi);
        break;
      case '2':
        stdout.write('Tanggal kedaluwarsa (YYYY-MM-DD): ');
        final tanggal = DateTime.parse((stdin.readLineSync() ?? '').trim());
        itemBaru = Makanan(nama, harga, stok, tanggal);
        break;
      case '3':
        stdout.write('Ukuran (S/M/L/XL): ');
        final ukuran = stdin.readLineSync() ?? '';
        itemBaru = Pakaian(nama, harga, stok, ukuran);
        break;
      default:
        print('Jenis barang tidak dikenali. Data dibatalkan.');
        return;
    }

    manager.tambah(itemBaru);
    print('Data berhasil ditambahkan.');
  } on DataTidakValidException catch (e) {
    print(e);
  } on FormatException catch (e) {
    print('Input tidak valid, pastikan harga/stok/tanggal berformat benar. (${e.message})');
  } catch (e) {
    print('Terjadi kesalahan tak terduga: $e');
  }
}

void _lihatSemuaData() {
  manager.tampilkanSemua();
}

void _cariData() {
  stdout.write('Masukkan kata kunci nama barang: ');
  final keyword = stdin.readLineSync() ?? '';
  manager.cari(keyword);
}

void _hitungTotal() {
  final total = manager.hitungTotalNilaiStok();
  print('Total nilai seluruh stok : Rp${total.toStringAsFixed(0)}');
  print('Ada barang stok menipis (<=5) : ${manager.adaBarangHampirHabis() ? 'Ya' : 'Tidak'}');
  print('Semua barang tersedia (stok>0) : ${manager.semuaBarangTersedia() ? 'Ya' : 'Tidak'}');
  print('Kategori barang di toko : ${manager.daftarKategori.join(', ')}');
  manager.jumlahPerKategori.forEach((kategori, jumlah) {
    print('  - $kategori: $jumlah item');
  });
}

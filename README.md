# Sistem Toko Vina

**Nama:** Vina Ariyanti
**NIM:** 25124001650
**Tema Aplikasi:** Sistem Toko (manajemen barang toko berbasis CLI)

## Fitur Program

- **Tambah Data** — menambahkan barang baru ke salah satu dari 3 kategori:
  Elektronik (dengan garansi), Makanan (dengan tanggal kedaluwarsa), atau
  Pakaian (dengan ukuran).
- **Lihat Semua Data** — menampilkan seluruh barang yang tersimpan, masing-masing
  dengan format tampilan sesuai jenisnya (polymorphism).
- **Cari Data** — mencari barang berdasarkan potongan nama (case-insensitive).
- **Hitung Total** — menghitung total nilai seluruh stok (harga × stok, dijumlah
  per barang), serta ringkasan status stok menipis, ketersediaan barang, dan
  jumlah barang per kategori.
- **Simpan Data** — simulasi penyimpanan data secara asynchronous (jeda 2 detik).
- **Validasi otomatis** — nama tidak boleh kosong, harga/stok tidak boleh
  negatif, ukuran pakaian harus salah satu dari S/M/L/XL/dst. Pelanggaran
  aturan ini melempar `DataTidakValidException` dan ditangani dengan try-catch
  agar program tidak crash.

## Konsep OOP yang Diterapkan

| Konsep | Lokasi |
|---|---|
| Class & Object | `Item`, `Elektronik`, `Makanan`, `Pakaian`, `Manager` |
| Encapsulation | Field `_nama`, `_harga`, `_stok` (private) + getter/setter + validasi |
| Inheritance | `Elektronik`, `Makanan`, `Pakaian` mewarisi `Item` |
| Polymorphism | `tampilkanInfo()` di-override tiap turunan, disimpan dalam `List<Item>` |
| Collection | `List<Item>`, `Map<String, int>`, `Set<String>` di `Manager` |
| Higher Order Function | `.where()` (cari), `.fold()` (total), `.any()` (stok menipis), `.every()` (semua tersedia) |
| Exception | `DataTidakValidException` (custom), ditangani via try-catch di `main.dart` |
| Async/Await | `Manager.simpanData()` |

## Struktur Folder

```
project_uas/
├── bin/
│   └── main.dart
├── lib/
│   ├── models/
│   │   ├── item.dart
│   │   ├── elektronik.dart
│   │   ├── makanan.dart
│   │   └── pakaian.dart
│   ├── controllers/
│   │   └── manager.dart
│   └── exceptions/
│       └── data_tidak_valid_exception.dart
├── pubspec.yaml
└── README.md
```

## Cara Menjalankan Program

1. Pastikan Dart SDK sudah terpasang (`dart --version`).
2. Masuk ke folder proyek:
   ```
   cd project_uas
   ```
3. Jalankan program:
   ```
   dart run bin/main.dart
   ```
4. Ikuti menu yang muncul di terminal (ketik angka 1–6 lalu Enter).

## Catatan

Program diisi dengan 3 data contoh saat pertama dijalankan (menu 2–4 langsung
bisa dicoba tanpa input manual). Belum diuji dengan `dart run` di lingkungan
pembuatan berkas ini karena Dart SDK tidak tersedia di sana — cek poin
verifikasi di bawah sebelum dikumpulkan.

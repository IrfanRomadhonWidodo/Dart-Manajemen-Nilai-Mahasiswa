# Praktikum Pemrograman Mobile - Dart Manajemen Nilai Mahasiswa

## Identitas
Nama  : Irfan Romadhon Widodo  
NIM   : H1D023023  
Shift : Shift D (Lama), Shift F (Baru)  

---

## Deskripsi Program
Program ini merupakan studi kasus sederhana untuk menerapkan **dasar pemrograman Dart** dengan konsep **class**, **input/output**, **perulangan**, **kondisional**, dan **pengolahan data dalam list**.  
Program berfungsi untuk mengelola data mahasiswa (nama dan nilai), menghitung rata-rata nilai, menampilkan konversi nilai huruf, serta menentukan mahasiswa dengan nilai tertinggi dan terendah.

---

## Source Code dan Penjelasan

```dart
// Import library untuk input/output dan fungsi matematika
import 'dart:io';
import 'dart:math';

//////////////////////////////////////////////////////////////
// (1) CLASS MAHASISWA
// Class ini digunakan untuk menyimpan data mahasiswa,
// terdiri dari atribut nama dan nilai. Selain itu, terdapat
// method getNilaiHuruf() untuk mengonversi nilai angka ke huruf.
//////////////////////////////////////////////////////////////
class Mahasiswa {
  String nama;
  int nilai;

  // Konstruktor untuk inisialisasi nama dan nilai
  Mahasiswa(this.nama, this.nilai);

  // Method konversi nilai angka ke huruf
  String getNilaiHuruf() {
    if (nilai >= 85)
      return 'A';
    else if (nilai >= 70)
      return 'B';
    else if (nilai >= 55)
      return 'C';
    else if (nilai >= 40)
      return 'D';
    else
      return 'E';
  }
}

//////////////////////////////////////////////////////////////
// (2) FUNGSI UTAMA (MAIN)
// Berisi logika utama untuk:
// - Input jumlah mahasiswa
// - Input data tiap mahasiswa
// - Menghitung rata-rata nilai
// - Menentukan nilai tertinggi dan terendah
// - Menampilkan hasil dalam bentuk tabel
//////////////////////////////////////////////////////////////
void main() {
  print("=== Sistem Manajemen Nilai Mahasiswa ===\n");

  //////////////////////////////////////////////////////////////
  // (3) INPUT JUMLAH MAHASISWA
  // Menggunakan stdin untuk membaca input dari pengguna.
  // Fungsi int.tryParse() memastikan input valid (bertipe angka).
  //////////////////////////////////////////////////////////////
  stdout.write("Masukkan jumlah mahasiswa: ");
  int? jumlah = int.tryParse(stdin.readLineSync() ?? '');

  if (jumlah == null || jumlah <= 0) {
    print("Input tidak valid. Program dihentikan.");
    return;
  }

  List<Mahasiswa> daftarMahasiswa = [];

  //////////////////////////////////////////////////////////////
  // (4) PENGULANGAN INPUT DATA
  // Menggunakan for loop untuk menginput nama dan nilai mahasiswa.
  // Jika input tidak valid, data tersebut dilewati.
  //////////////////////////////////////////////////////////////
  for (int i = 0; i < jumlah; i++) {
    print("\nMahasiswa ke-${i + 1}");
    stdout.write("Nama  : ");
    String? nama = stdin.readLineSync();

    stdout.write("Nilai : ");
    int? nilai = int.tryParse(stdin.readLineSync() ?? '');

    if (nama == null || nilai == null) {
      print("Input tidak valid. Data dilewati.");
      continue;
    }

    daftarMahasiswa.add(Mahasiswa(nama, nilai));
  }

  if (daftarMahasiswa.isEmpty) {
    print("Tidak ada data yang valid. Program dihentikan.");
    return;
  }

  //////////////////////////////////////////////////////////////
  // (5) MENGHITUNG RATA-RATA NILAI
  // Menggunakan map() untuk mengambil nilai tiap mahasiswa,
  // lalu reduce() untuk menjumlahkan seluruh nilai.
  //////////////////////////////////////////////////////////////
  double rataRata =
      daftarMahasiswa.map((m) => m.nilai).reduce((a, b) => a + b) /
      daftarMahasiswa.length;

  //////////////////////////////////////////////////////////////
  // (6) MENENTUKAN NILAI TERTINGGI DAN TERENDAH
  // Menggunakan fungsi max() dan min() dari library dart:math,
  // lalu mencari mahasiswa dengan nilai tersebut.
  //////////////////////////////////////////////////////////////
  int nilaiTertinggi = daftarMahasiswa.map((m) => m.nilai).reduce(max);
  int nilaiTerendah = daftarMahasiswa.map((m) => m.nilai).reduce(min);
  Mahasiswa top = daftarMahasiswa.firstWhere((m) => m.nilai == nilaiTertinggi);
  Mahasiswa low = daftarMahasiswa.firstWhere((m) => m.nilai == nilaiTerendah);

  //////////////////////////////////////////////////////////////
  // (7) MENAMPILKAN DATA DALAM BENTUK TABEL
  // Menggunakan padRight() agar tampilan kolom rata di terminal.
  //////////////////////////////////////////////////////////////
  print("\n=== Rekap Nilai Mahasiswa ===");
  print("---------------------------------------------------");
  print("| No | Nama               | Nilai | Huruf |");
  print("---------------------------------------------------");
  for (int i = 0; i < daftarMahasiswa.length; i++) {
    Mahasiswa m = daftarMahasiswa[i];
    print(
      "| ${i + 1}  | ${m.nama.padRight(18)} | ${m.nilai.toString().padRight(5)} | ${m.getNilaiHuruf().padRight(6)}|",
    );
  }
  print("---------------------------------------------------");

  //////////////////////////////////////////////////////////////
  // (8) MENAMPILKAN RINGKASAN HASIL DAN STATUS KELAS
  // Menampilkan rata-rata, nilai tertinggi, nilai terendah,
  // dan status kinerja kelas berdasarkan rata-rata.
  //////////////////////////////////////////////////////////////
  print("\nRata-rata nilai  : ${rataRata.toStringAsFixed(2)}");
  print("Nilai tertinggi  : ${top.nama} (${top.nilai})");
  print("Nilai terendah   : ${low.nama} (${low.nilai})");

  if (rataRata >= 70) {
    print("Status kelas     : Kinerja baik 🎉");
  } else if (rataRata >= 55) {
    print("Status kelas     : Cukup baik 🙂");
  } else {
    print("Status kelas     : Perlu perbaikan 😢");
  }

  print("\n=== Program Selesai ===");
}

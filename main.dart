import 'dart:io';
import 'dart:math';

// Kelas untuk menyimpan data mahasiswa
class Mahasiswa {
  String nama;
  int nilai;

  Mahasiswa(this.nama, this.nilai);

  // Method untuk mengonversi nilai angka ke huruf
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

void main() {
  print("=== Sistem Manajemen Nilai Mahasiswa ===\n");

  stdout.write("Masukkan jumlah mahasiswa: ");
  int? jumlah = int.tryParse(stdin.readLineSync() ?? '');

  if (jumlah == null || jumlah <= 0) {
    print("Input tidak valid. Program dihentikan.");
    return;
  }

  List<Mahasiswa> daftarMahasiswa = [];

  // Input data mahasiswa
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

  // Menghitung rata-rata nilai
  double rataRata =
      daftarMahasiswa.map((m) => m.nilai).reduce((a, b) => a + b) /
      daftarMahasiswa.length;

  // Menentukan mahasiswa dengan nilai tertinggi dan terendah
  int nilaiTertinggi = daftarMahasiswa.map((m) => m.nilai).reduce(max);
  int nilaiTerendah = daftarMahasiswa.map((m) => m.nilai).reduce(min);
  Mahasiswa top = daftarMahasiswa.firstWhere((m) => m.nilai == nilaiTertinggi);
  Mahasiswa low = daftarMahasiswa.firstWhere((m) => m.nilai == nilaiTerendah);

  // Menampilkan data semua mahasiswa dalam tabel
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

  // Menampilkan ringkasan hasil
  print("\nRata-rata nilai  : ${rataRata.toStringAsFixed(2)}");
  print("Nilai tertinggi  : ${top.nama} (${top.nilai})");
  print("Nilai terendah   : ${low.nama} (${low.nilai})");

  // Menampilkan status umum berdasarkan rata-rata kelas
  if (rataRata >= 70) {
    print("Status kelas     : Kinerja baik 🎉");
  } else if (rataRata >= 55) {
    print("Status kelas     : Cukup baik 🙂");
  } else {
    print("Status kelas     : Perlu perbaikan 😢");
  }

  print("\n=== Program Selesai ===");
}

# Validasi MakanYuk Malang

Tanggal: 24 Oktober 2026 (Asia/Jakarta).
Mahasiswa: Aldza Salwatul Aisy / 240605110227.

## Pemeriksaan akhir perubahan rekomendasi dan Windows

- dart format .: 30 file diformat, berhasil.
- flutter analyze: No issues found.
- flutter test: 20 tes lulus, 0 gagal.
- node --test tools/demo_api.test.mjs: 1 tes HTTP server lulus.
- flutter create --platforms=windows --project-name makanyuk_malang .:
  runner Windows tersedia; tidak mengganti implementasi Flutter.
- flutter run -d windows: build debug berhasil (235,6 detik).
- flutter run -d windows --no-enable-impeller: build ulang berhasil (31,2 detik),
  VM service tersedia. Jendela aplikasi diverifikasi dari proses di luar sandbox:
  judul MakanYuk Malang, MainWindowHandle tidak nol, Responding=True.
  Aplikasi dibiarkan berjalan untuk pengguna.
- PDF laporan: 11 halaman dirender memakai pypdfium2; contact sheet dan halaman
  padat diperiksa secara visual. Tidak ditemukan konten terpotong/bertumpuk.
  Format mengikuti BAB I-III contoh LangitKita dengan materi khusus MakanYuk.

## Cakupan tes

Model nullable dan angka valid; penolakan data invalid; JSON asset asli dan ID unik;
pencarian case-insensitive dan kategori gabungan; simpan/hapus favorit dan restore;
HTTP mapping ke domain; status gagal, jaringan gagal, JSON rusak dan source mismatch
fallback ke demo dengan pemberitahuan; penolakan HTTP publik; navigasi, detail ID,
ID hilang, reset pencarian kosong; seluruh route pada lebar 320, 600 dan 1100.
Detail tempat nyata juga disertakan dalam pemeriksaan layout.

15 referensi memiliki query Google/Maps yang ter-encode dengan benar; lima contoh
fiktif tetap tanpa query. Tes widget memeriksa target Google/Maps serta pesan
kegagalan ketika launcher mengembalikan false maupun melempar exception.
Launcher di-mock; ini bukan pengujian manual hasil Google/Maps di Windows/Android.

## Bukti tahap MVP sebelumnya

Sebelum perubahan katalog: build APK debug berhasil; alur browser Beranda,
Eksplor, Detail dan Favorit serta persistensi setelah reload pernah diperiksa.
Screenshot di docs/screenshots/ berasal dari tahap ini dengan lima contoh fiktif.
APK dan screenshot tersebut belum dibangun/diambil ulang pada perubahan ini.

## Batas validasi dan tindak lanjut

- Google Places live belum dikonfigurasi/diverifikasi. JSON lokal berisi 15 referensi
  statis dan lima contoh fiktif; rating, harga, jam buka dan koordinat tidak dikarang.
- Pembukaan tautan eksternal secara manual serta uji Android fisik belum dilakukan.
- Screenshot laporan perlu diperbarui untuk katalog terbaru.
- Kelas, fakultas, kampus dan logo resmi masih perlu dilengkapi pada Markdown
  laporan lalu PDF dibuat ulang; PDF terbaru tidak memiliki field formulir interaktif.
- Source sudah diunggah ke https://github.com/aldzaaa/MakanYuk-Malang
  pada branch main. PDF belum diunggah ke Google Drive.
- Flutter doctor mendeteksi sebagian lisensi Android belum diterima;
  toolchain Visual Studio untuk Windows terdeteksi siap.

## Pemeriksaan publikasi GitHub

- README diperjelas: clone, Windows/Android, alur penggunaan, data dan API,
  dokumentasi, screenshot tahap awal serta batas pemeriksaan.
- Tautan file lokal dan pasangan blok kode README diperiksa, valid.
- Build/cache/konfigurasi mesin dan secret dikecualikan dari commit.
- .gitattributes menetapkan PDF/font/gambar sebagai binary. PDF pada commit
  diverifikasi identik byte-per-byte dengan file asli.
- Push branch main berhasil; origin/main menjadi upstream.
- Tes Flutter tidak diulang pada pembaruan dokumentasi/publikasi ini;
  hasil 20 tes di atas berasal dari pemeriksaan implementasi sebelumnya.
- PDF laporan masih mencatat status sebelum publikasi GitHub.

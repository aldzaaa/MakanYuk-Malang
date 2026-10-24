# MakanYuk Malang

**Jelajahi Rasa, Temukan Cerita.** Aplikasi Flutter eksplorasi kuliner Kota Malang
untuk UTS Mobile Programming. Dibuat untuk Aldza Salwatul Aisy (240605110227).

Repository: [aldzaaa/MakanYuk-Malang](https://github.com/aldzaaa/MakanYuk-Malang).
Target utama adalah Android; aplikasi juga dapat dijalankan sebagai desktop Windows
atau preview web dari source Flutter yang sama. Tidak memerlukan login.

## Mulai cepat di Windows

Siapkan Flutter (Dart minimal 3.13.2 sesuai `pubspec.yaml`), Git, dan Visual Studio
dengan workload **Desktop development with C++**. Visual Studio Code saja tidak
menyediakan compiler desktop Windows.

```sh
git clone https://github.com/aldzaaa/MakanYuk-Malang.git
cd MakanYuk-Malang
flutter doctor
flutter pub get
flutter run -d windows --no-enable-impeller
```

Perintah tersebut menjalankan katalog lokal tanpa backend atau API key. Jika
Flutter belum ditemukan, tambahkan folder `flutter/bin` ke PATH terlebih dahulu.
Untuk target Android, siapkan Android SDK dan emulator/perangkat, lalu gunakan
`flutter devices` dan `flutter run -d <device-id>`.

## Fitur

- Beranda: branding, lokasi Kota Malang, kategori, pencarian dan pilihan kuliner.
- Eksplor: daftar, pencarian nama tanpa membedakan kapital, filter kategori,
  hasil kosong, loading, error dan tombol coba lagi/muat ulang.
- Detail: data berdasarkan ID stabil, ilustrasi/foto dengan fallback, nama,
  kategori, alamat, deskripsi dan rating bila tersedia.
- Favorit: tambah/hapus dari kartu/detail, daftar favorit dan penyimpanan
  SharedPreferences. Favorit tetap ada setelah aplikasi dibuka ulang.
- Navigasi bawah mempertahankan state tab; detail mendukung back dan ID hilang.
- JSON offline dan REST API melalui repository; kegagalan API menampilkan
  pemberitahuan fallback demo, bukan berpura-pura menjadi data langsung.
- 15 referensi kuliner Malang memiliki tombol Google dan Maps langsung pada kartu
  serta detail. Tautan memakai pencarian nama; koordinat tidak dibuat-buat.

## Menjalankan

Gunakan Flutter stable yang kompatibel dengan `pubspec.yaml` (proyek dibuat
dengan Flutter 3.47.2 / Dart 3.13.2). Pasang Android SDK untuk target Android.

```sh
flutter doctor
flutter pub get
flutter devices
flutter run -d <device-id>
```

Preview browser dari source Flutter yang sama:

```sh
flutter run -d chrome --web-port 5210
```

Menjalankan aplikasi desktop Windows (runner `windows/` tersedia):

```sh
flutter run -d windows
```

Memerlukan Visual Studio dengan workload **Desktop development with C++**.
Windows menggunakan source, pencarian, tautan eksternal dan favorit yang sama;
target tugas UTS tetap Flutter mobile Android.

Alternatif tanpa debugger Chrome:

```sh
flutter run -d web-server --web-port 5210 --web-hostname 127.0.0.1
```

Buka http://127.0.0.1:5210. Favorit browser disimpan per origin
(localhost dan 127.0.0.1 memiliki penyimpanan berbeda).

## Alur penggunaan

1. Buka **Beranda**, lalu pilih **Mulai jelajah** atau tab **Eksplor**.
2. Ketik nama kuliner dan pilih kategori; gunakan **Reset pencarian** jika kosong.
3. Ketuk kartu untuk membaca detail. Pada 15 referensi tempat nyata, tombol
   **Google** dan **Maps** langsung membuka pencarian nama tempat.
4. Tekan ikon hati untuk menyimpan atau menghapus pilihan. Buka tab **Favorit**
   untuk melihatnya; ID favorit disimpan lokal saat aplikasi ditutup.

Daftar dan favorit dapat digunakan offline. Pencarian Google/Maps serta sumber
API remote memerlukan internet. Hasil Maps dapat memuat beberapa cabang.

## Routes

| Route | Halaman |
| --- | --- |
| / atau /home | Beranda |
| /explore | Pencarian, kategori dan seluruh kuliner |
| /favorites | Pilihan tersimpan |
| /culinary/:id | Detail item atau keadaan ID tidak ditemukan |

## Arsitektur

Material 3, feature-first MVVM, Riverpod, go_router, typed domain model,
repository dan datasource. Widget tidak memanggil REST API langsung.

```text
lib/app/                  app, router dan dependency providers
lib/core/                 tema, tokens dan widget bersama
lib/features/home/        Beranda
lib/features/explore/     UI, query dan filter viewmodel
lib/features/favorites/   UI, viewmodel dan SharedPreferences store
lib/features/culinary_detail/ UI detail
lib/culinary/domain/      CulinaryPlace, CulinaryCatalog, kontrak repository
lib/culinary/data/        JSON, remote HTTP, DTO dan repository fallback
assets/data/              15 referensi kuliner dan lima contoh fiktif
assets/fonts/             Plus Jakarta Sans lokal dan lisensi OFL
docs/                     spesifikasi, rancangan, screenshot dan validasi
test/                     unit, repository dan widget tests
tools/                    server demo, test HTTP dan generator laporan
windows/                  runner aplikasi desktop Windows
android/                  runner aplikasi mobile Android
```

## Data demo

JSON berisi 15 referensi tempat nyata (termasuk Bakso President, Rawon Nguling,
Toko Oen dan Depot Hok Lay) dan lima contoh fiktif. Daftar referensi dan sumbernya
ada di [docs/CULINARY_REFERENCES.md](docs/CULINARY_REFERENCES.md).
Tombol **Google** membuka pencarian nama dan **Maps** membuka pencarian lokasi
di aplikasi/browser eksternal. Ketuk bagian kartu lainnya untuk membuka detail.
Daftar lokal bukan data Google Places langsung; periksa cabang dan kondisi
terbaru melalui tautan. Membuka Google/Maps memerlukan koneksi internet.

Lima tempat bernama Contoh Bakso Malang, Contoh Rawon Hangat,
Contoh Soto Nusantara, Contoh Kafe Senja dan Contoh Jajanan Sore adalah fiktif.
Alamat lima contoh ini berupa ilustrasi. Bukan rekomendasi tempat nyata atau data rating,
harga, jam buka dan koordinat terverifikasi. Placeholder visual adalah
ilustrasi kategori, bukan foto restoran. Semua sumber demo diberi label.
JSON, font dan ilustrasi tersedia offline tanpa panggilan internet.

## REST API

Tanpa konfigurasi, aplikasi memakai JSON offline. Untuk mengaktifkan remote,
isi **base URL backend milik Anda**, bukan API key:

```sh
flutter run -d chrome --web-port 5210 --dart-define=CULINARY_API_URL=https://backend.example.com
```

Alamat `backend.example.com` hanya contoh, bukan endpoint aktif.
Endpoint yang diminta: `GET /api/v1/culinary?category=all&limit=20`.
Kontrak lengkap: [docs/API.md](docs/API.md).

Server demo lokal tanpa dependency Node tambahan:

```sh
node tools/demo_api.mjs
flutter run -d chrome --web-port 5210 --dart-define=CULINARY_API_URL=http://127.0.0.1:8787
```

Server demo menyajikan JSON melalui HTTP dengan `isDemo: true`.
Ini membuktikan alur REST API; **bukan koneksi langsung Google Places**.
Android emulator dapat memakai host `10.0.2.2`; API produksi wajib HTTPS.
Kebijakan HTTP Android release tetap aman; gunakan HTTPS untuk perangkat nyata.

Jika memilih Google Places, backend proxy wajib menyimpan key di server,
membatasi parameter/request/biaya, serta menjaga atribusi dan ketentuan
penggunaan/caching. Data Google tidak disimpan di SharedPreferences;
hanya ID favorit yang disimpan. Integrasi live Google belum diuji karena
backend dan kredensial belum disediakan. Jangan memasukkan secret ke Dart/assets.

## Pemeriksaan

```sh
dart format .
flutter analyze
flutter test
node --test tools/demo_api.test.mjs
flutter build apk --debug
```

APK debug: `build/app/outputs/flutter-apk/app-debug.apk`.
Hasil yang benar-benar dijalankan dicatat di [docs/VALIDATION.md](docs/VALIDATION.md).

## Luaran UTS

Desain mandiri dan perbandingan implementasi: [docs/UI_DESIGN.md](docs/UI_DESIGN.md).
Laporan memuat identitas Aldza Salwatul Aisy dan NIM 240605110227.
Kelas diisi sendiri oleh mahasiswa. Logo/fakultas harus dilengkapi dengan identitas resmi.
Source proyek tersedia pada [repository GitHub](https://github.com/aldzaaa/MakanYuk-Malang).
Folder `build/`, cache Flutter, konfigurasi mesin lokal dan secret tidak disertakan;
jalankan `flutter pub get` sebelum menjalankan atau membangun aplikasi.
APK/EXE dibangun sendiri dari source, bukan disimpan di repository. Untuk Windows,
folder distribusi hasil build harus dibagikan lengkap beserta DLL dan folder data,
bukan hanya file EXE.

Laporan PDF tersedia di repository, tetapi belum diunggah ke Google Drive.
Untuk pengumpulan, unggah PDF ke Google Drive dan sertakan link repository serta
link laporan dengan izin akses yang sesuai ketentuan dosen.

Laporan terbaru mengikuti format BAB I-III seperti contoh LangitKita. Sumber
editable: [docs/LAPORAN_EDITABLE.md](docs/LAPORAN_EDITABLE.md), PDF:
[docs/Laporan_UTS_MakanYuk_Malang_Aldza.pdf](docs/Laporan_UTS_MakanYuk_Malang_Aldza.pdf).
Generator opsional `tools/build_report.py` memerlukan Python dengan ReportLab dan
pypdf. Screenshot laporan masih dokumentasi tahap awal dan perlu diperbarui
untuk katalog terbaru. Cover memakai placeholder kelas, kampus/fakultas dan logo
resmi, bukan field formulir PDF. Isi Markdown lalu buat ulang PDF.

Jika renderer Windows bermasalah pada perangkat, jalankan:

```sh
flutter run -d windows --no-enable-impeller
```


## Tampilan aplikasi

Screenshot berikut merupakan dokumentasi tahap awal dengan lima contoh fiktif.
Versi sekarang memiliki 15 referensi tambahan; screenshot perlu diperbarui untuk
menunjukkan tombol Google/Maps dan katalog terbaru.

| Beranda | Eksplor |
| --- | --- |
| ![Beranda](docs/screenshots/01-beranda.png) | ![Eksplor](docs/screenshots/02-eksplor.png) |

| Detail | Favorit |
| --- | --- |
| ![Detail](docs/screenshots/03-detail.png) | ![Favorit](docs/screenshots/04-favorit.png) |

## Status dan dokumentasi

Pemeriksaan terakhir: analisis statis bersih, **20 tes Flutter** dan **1 tes server**
lulus; build dan jendela Windows telah diverifikasi. Rincian cakupan serta
batas pemeriksaan: [VALIDATION.md](docs/VALIDATION.md).

- [Kebutuhan produk](docs/PRD.md) dan [arsitektur](docs/ARCHITECTURE.md).
- [Rancangan UI](docs/UI_DESIGN.md) dan [referensi kuliner](docs/CULINARY_REFERENCES.md).
- [Kontrak REST API](docs/API.md).
- [Checklist pengumpulan](docs/SUBMISSION_CHECKLIST.md).

Google Places live belum diaktifkan. Uji manual Android fisik dan pembukaan hasil
Google/Maps belum dilakukan. Cover laporan masih memerlukan kelas, identitas
kampus/fakultas dan logo resmi. Tidak ada fitur pemesanan atau pembayaran.

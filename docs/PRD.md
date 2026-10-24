# PRODUCT REQUIREMENTS DOCUMENT

## MakanYuk Malang

**Versi:** 1.0\
**Platform:** Android menggunakan Flutter\
**Tipe produk:** Culinary Discovery & Recommendation\
**Status:** Planning — UTS Mobile Programming

### 1. Product Overview

MakanYuk Malang adalah aplikasi mobile yang membantu pengguna menemukan rekomendasi kuliner di Kota Malang, mulai dari makanan tradisional, bakso, rawon, soto, makanan ringan, restoran, hingga kafe.

Aplikasi menyediakan informasi kuliner dalam antarmuka modern, estetik, responsif, dan mudah digunakan. Informasi diambil melalui API ketika tersedia dan menggunakan data JSON lokal untuk mode demo atau fallback.

### 2. Problem Statement

Pengguna sering kesulitan menentukan tempat makan karena informasi tersebar di berbagai platform, membutuhkan waktu untuk membandingkan pilihan, dan tidak selalu mengetahui kuliner khas daerah Malang.

### 3. Product Goals

1. Memudahkan pencarian rekomendasi kuliner di Malang.
2. Memberikan pengalaman eksplorasi kuliner yang sederhana dan menarik.
3. Menampilkan informasi tempat makan secara terstruktur.
4. Menyediakan pencarian dan filter berdasarkan kategori.
5. Memungkinkan pengguna menyimpan tempat favorit.
6. Mengimplementasikan Flutter, widget, layout responsif, navigasi, data JSON, dan integrasi API.
7. Menghasilkan proyek terstruktur yang mudah dikembangkan.

### 4. Target Users

- Mahasiswa di Malang.
- Masyarakat lokal yang ingin mencari tempat makan.
- Wisatawan yang mengunjungi Malang.
- Pengguna yang ingin mengeksplorasi kuliner baru.

### 5. MVP Features — Wajib UTS

**FR-01: Home Screen**

- Branding MakanYuk Malang.
- Lokasi eksplorasi default: Kota Malang.
- Search bar.
- Kategori makanan.
- Rekomendasi pilihan.
- Kartu tempat kuliner.

**FR-02: Explore Screen**

- Menampilkan daftar tempat makan.
- Pencarian berdasarkan nama.
- Filter kategori.
- Empty state apabila pencarian tidak menghasilkan data.
- Loading dan error state.

**FR-03: Culinary Detail Screen**

- Nama dan kategori.
- Foto atau placeholder.
- Alamat.
- Rating jika tersedia.
- Deskripsi jika tersedia.
- Tombol membuka lokasi melalui aplikasi peta.
- Tombol menambah atau menghapus favorit.

**FR-04: Favorites Screen**

- Daftar kuliner tersimpan.
- Penghapusan favorit.
- Penyimpanan lokal agar favorit tetap ada setelah aplikasi ditutup.
- Empty state untuk daftar kosong.

**FR-05: Data Integration**

- Membaca JSON lokal.
- Integrasi REST API melalui repository.
- Mengubah data API menjadi model Dart.
- Menangani kegagalan jaringan.
- Menyediakan mode data lokal ketika API belum tersedia.
- Menandai sumber data agar pengguna tidak menganggap dummy sebagai data langsung.

**FR-06: Navigation**

- Bottom navigation untuk Beranda, Eksplor, dan Favorit.
- Detail menggunakan route terpisah.
- Tombol back sesuai navigasi Android.
- Menjaga state tab saat perpindahan halaman apabila diperlukan.

### 6. Non-Functional Requirements

- Tampilan clean dan konsisten dengan Material 3.
- Responsif di berbagai ukuran smartphone.
- Tidak mengalami layout overflow.
- Tidak memerlukan login untuk versi UTS.
- Error API tidak menyebabkan aplikasi crash.
- Komponen dapat digunakan kembali.
- Tidak mengandung API key atau secret dalam repository.
- Kode dapat diperiksa menggunakan flutter analyze.
- Mendukung pengujian widget dan unit test.

### 7. Design System

**Brand:** MakanYuk Malang\
**Tagline:** Jelajahi Rasa, Temukan Cerita.

**Colors**

- Primary: #D75A32
- Background: #FFF8F0
- Text: #24352F
- Surface: #FFFFFF
- Accent: #E8D9C5

**Typography:** Plus Jakarta Sans.

**Design Principles**

- Mobile-first.
- Clean interface.
- Konsistensi jarak dan ukuran.
- Kartu dengan rounded corners.
- Foto makanan menjadi fokus visual.
- Informasi mudah dibaca.
- Tombol memiliki label dan feedback interaksi yang jelas.
- Aksesibilitas dan kontras warna diperhatikan.

### 8. Out of Scope — Tidak Wajib UTS

- Pemesanan makanan.
- Pembayaran.
- Login dan registrasi.
- Chatbot AI.
- Sistem ulasan yang ditulis pengguna.
- Dashboard admin.
- Sistem delivery.
- Rekomendasi berbasis machine learning.

Fitur tersebut boleh dipertimbangkan setelah MVP selesai, bukan sebelumnya.

### 9. Acceptance Criteria

MVP dianggap selesai jika:

- Minimal empat halaman tersedia dan berfungsi.
- Navigasi antarlayar berjalan baik.
- Data JSON lokal berhasil ditampilkan.
- Integrasi API tersedia dan dapat diuji menggunakan konfigurasi yang sah.
- Pencarian dan filter bekerja.
- Detail menampilkan data item yang dipilih.
- Favorit dapat ditambah, dihapus, dan disimpan secara lokal.
- Terdapat loading, empty, dan error state.
- Tidak ada error penting dari flutter analyze.
- Pengujian fitur utama berhasil.
- README menjelaskan instalasi, arsitektur, API, fitur, dan penggunaan.
- Desain awal serta screenshot implementasi siap untuk laporan PDF.

### 10. Deliverables

1. Flutter source code.
2. Repository GitHub.
3. README.md.
4. Desain awal UI.
5. Screenshot implementasi.
6. Laporan UTS dalam format PDF.


# MakanYuk Malang — Master Development Blueprint

Version 1.0 — UTS Mobile Programming

Kita akan menyiapkan tiga dokumen utama yang nantinya menjadi pedoman untuk membangun MakanYuk Malang menggunakan Flutter, baik dikerjakan manual maupun dibantu AI coding agent seperti Codex.

01\. PRD — Product Requirements Document

Menetapkan tujuan aplikasi, fitur, kebutuhan pengguna, prioritas, dan kriteria keberhasilan.

02\. Development Plan & System Architecture

Menetapkan tech stack, arsitektur Flutter, struktur folder, alur API, penyimpanan data, dan tahapan pembangunan.

03\. AGENTS.md — AI Coding Agent Rules

Mengatur cara AI menulis, menguji, memperbaiki, dan mendokumentasikan kode agar proyek tidak berantakan.

## 1. PRD — Product Requirements Document

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

## 2. Planning & System Architecture

Saya memilih Feature-first + MVVM + Repository Pattern. Pola ini sesuai dengan prinsip pemisahan UI dan data pada panduan arsitektur Flutter, tanpa perlu menambahkan kompleksitas Clean Architecture penuh untuk proyek UTS.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://docs.flutter.dev\&sz=32)

Flutter Docs



### Diagram arsitektur

# DEVELOPMENT PLAN & SYSTEM ARCHITECTURE

## MakanYuk Malang — Flutter

### 1. Technical Decisions

| Layer             | Technology                       |
| ----------------- | -------------------------------- |
| Mobile app        | Flutter + Dart                   |
| UI system         | Material 3                       |
| Architecture      | Feature-first MVVM               |
| State management  | Riverpod                         |
| Navigation        | go_router                        |
| API client        | http                             |
| Models            | Dart typed models                |
| Demo data         | Local JSON assets                |
| Favorites storage | shared_preferences               |
| Typography        | google_fonts                     |
| External maps     | url_launcher                     |
| Testing           | flutter_test                     |
| Backend proxy     | Optional server or edge function |
| Future database   | Supabase PostgreSQL              |

Gunakan versi package yang kompatibel dengan Flutter SDK terpasang. Jangan mengunci versi tanpa pemeriksaan kompatibilitas.

### 2. Folder Structure

```
makanyuk_malang/
├── android/
├── assets/
│   ├── data/
│   │   └── culinary_seed.json
│   └── images/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart
│   │   ├── router.dart
│   │   └── providers.dart
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   ├── features/
│   │   ├── home/
│   │   │   └── presentation/
│   │   ├── explore/
│   │   │   └── presentation/
│   │   ├── culinary_detail/
│   │   │   └── presentation/
│   │   └── favorites/
│   │       ├── presentation/
│   │       └── data/
│   └── culinary/
│       ├── domain/
│       │   ├── models/
│       │   └── repositories/
│       ├── data/
│       │   ├── datasources/
│       │   ├── dto/
│       │   └── repositories/
│       └── presentation/
│           └── providers/
├── test/
│   ├── models/
│   ├── repositories/
│   └── widgets/
├── docs/
│   ├── PRD.md
│   ├── ARCHITECTURE.md
│   └── UI_DESIGN.md
├── AGENTS.md
├── README.md
├── .gitignore
└── pubspec.yaml
```

Gunakan file terpisah ketika tanggung jawabnya berbeda. Hindari pembuatan file atau abstraksi tanpa kebutuhan.

### 3. Data Model

Model utama: `CulinaryPlace`

```
id: String
name: String
category: String
address: String
description: String?
imageUrl: String?
latitude: double?
longitude: double?
rating: double?
ratingCount: int?
source: CulinarySource
```

Semua data tempat makan harus melalui model yang sama, terlepas dari asal data API atau JSON.

ID Google Places dipertahankan sebagai referensi API. Untuk data lokal gunakan ID yang konsisten dan tidak bentrok.

### 4. API Architecture

Sumber remote yang direkomendasikan adalah Google Places API (New), diakses melalui backend proxy ketika menggunakan API web service yang membutuhkan secret.

```
Flutter App
    ↓
CulinaryRepository
    ↓
RemoteDataSource
    ↓
Backend Proxy
    ↓
Google Places API
```

Fallback demo:

```
Remote data gagal / mode demo
    ↓
LocalJsonDataSource
    ↓
CulinaryRepository
    ↓
UI dengan label "Data Demo"
```

Keberadaan data lokal tidak boleh menutupi kesalahan API secara diam-diam. Repository harus menyampaikan mode sumber data ke UI.

### 5. Backend Contract

Rancangan endpoint milik aplikasi:

`GET /api/v1/culinary?category=all&limit=20`

Response:

```
{
  "data": [
    {
      "id": "place_001",
      "name": "Contoh Kuliner",
      "category": "Restoran",
      "address": "Malang",
      "description": null,
      "imageUrl": null,
      "latitude": null,
      "longitude": null,
      "rating": null,
      "ratingCount": null,
      "source": "google_places"
    }
  ],
  "source": "google_places",
  "isDemo": false
}
```

Kontrak tersebut adalah desain internal, bukan endpoint yang sudah tersedia.

Backend wajib:

- Menyimpan secret di environment server.
- Memvalidasi parameter permintaan.
- Membatasi jumlah hasil.
- Mengendalikan request dan biaya API.
- Mematuhi ketentuan penyimpanan, atribusi, dan penggunaan Google Places.
- Tidak menggunakan cache data Places secara bebas tanpa memperhatikan ketentuan layanan.

### 6. Navigation Architecture

```
/
├── /home
├── /explore
├── /favorites
└── /culinary/:id
```

Gunakan bottom navigation pada tiga halaman utama dan route terpisah untuk detail.

Navigasi detail harus membawa identifier tempat, bukan bergantung pada indeks list.

Jika aplikasi direfresh atau dibuka dari deep link, halaman detail menangani ID yang tidak ditemukan secara elegan.

### 7. State Management

Gunakan Riverpod untuk:

- Daftar kuliner dan status pemuatan.
- Query pencarian dan filter.
- Detail kuliner.
- State daftar favorit.
- Sumber data remote atau demo.

Setiap state yang mengambil data harus menangani:

- Initial.
- Loading.
- Success.
- Empty.
- Error.

Debounce pencarian apabila permintaan dijalankan ke server. Filter daftar lokal boleh dilakukan langsung tanpa network request tambahan.

### 8. UI Components

Buat widget reusable:

- AppBottomNavigation.
- CulinaryCard.
- CategoryChip.
- SearchField.
- FeaturedSection.
- RatingDisplay.
- FavoriteButton.
- LoadingSkeleton.
- EmptyState.
- ErrorState.

Gunakan design tokens untuk warna, spacing, radius, dan typography.

Tidak boleh menampilkan foto rusak atau informasi palsu saat API tidak memiliki gambar, rating, atau harga.

### 9. Implementation Milestones

**Phase 0 — Project Foundation**

- Inisialisasi Flutter.
- Setup package.
- Setup theme dan router.
- Buat model dan contoh JSON.
- Buat folder dokumentasi.

Selesai apabila aplikasi berhasil dibuka dan theme aktif.

**Phase 1 — UI Foundation**

- Home.
- Explore.
- Detail.
- Favorites.
- Reusable widgets.
- Responsive layout.

Selesai apabila semua halaman memiliki tampilan dan navigasi fungsional dengan data lokal.

**Phase 2 — Business Logic**

- Search.
- Filter kategori.
- Detail lookup.
- Tambah/hapus favorit.
- Persistensi favorit.

Selesai apabila seluruh interaksi pengguna berjalan tanpa API.

**Phase 3 — API Integration**

- Remote data source.
- Model mapping.
- Proxy configuration.
- Error handling.
- Demo fallback.
- Atribusi dan kepatuhan data.

Selesai apabila integrasi bisa diverifikasi dengan endpoint aktif dan mode demo tetap tersedia.

**Phase 4 — Quality Assurance**

- Unit test repository/model.
- Widget test navigasi dan keadaan kosong.
- Uji layout pada berbagai ukuran layar.
- flutter analyze.
- flutter test.
- Uji manual pada Android emulator/device.

Selesai apabila tidak ada masalah kritis yang diketahui.

**Phase 5 — Submission**

- Screenshot aplikasi.
- Dokumentasi desain.
- README dan cara menjalankan aplikasi.
- Push repository GitHub.
- Menulis laporan.
- Ekspor laporan sebagai PDF.

### 10. Definition of Done

Sebuah fitur selesai jika implementasi, kondisi loading/error/empty yang relevan, pengujian, dan dokumentasi telah dipenuhi.

Keseluruhan MVP selesai jika semua acceptance criteria dalam PRD terpenuhi dan proyek dapat dijalankan ulang dari README.

Keputusan arsitektur penting: Supabase tidak wajib digunakan dalam MVP. SharedPreferences cukup untuk ID favorit lokal, sedangkan daftar kuliner diperoleh dari JSON atau API. Ini lebih sederhana dan sesuai fokus penilaian UTS.

Google Places Nearby Search menggunakan permintaan POST, membutuhkan field mask, dan pemilihan field memengaruhi biaya. Karena itu, pemanggilan API serta data yang diminta perlu dibatasi.&#x20;

[image](https://www.google.com/s2/favicons?domain=https://developers.google.com\&sz=32)

Google for Developers



## 3. AGENTS.md — Aturan untuk Codex / AI Coding Agent

Dokumen ketiga ini sangat penting. Tujuannya agar ketika Codex membantu membangun proyek, agent tidak tiba-tiba mengganti framework, membuat terlalu banyak file, menghapus fitur, atau mengklaim aplikasi sudah berhasil tanpa pengujian.

Simpan dengan nama `AGENTS.md` di root proyek.

# AGENTS.md

# MakanYuk Malang — AI Development Rules

## 1. Agent Identity

You are a senior Flutter engineer, mobile UI/UX developer, and software architect working on MakanYuk Malang.

Your responsibility is to build a maintainable, beautiful, functional, and testable Flutter mobile application according to the project requirements.

This is a university Mobile Programming midterm project. Prioritize completing the MVP before adding optional functionality.

## 2. Source of Truth

Before implementing features, read these files:

1. `docs/PRD.md`
2. `docs/ARCHITECTURE.md`
3. `docs/UI_DESIGN.md`, if available
4. `README.md`
5. Existing relevant source code

Use these documents as requirements. If they conflict, explain the conflict and prefer explicit acceptance criteria in the PRD unless the user provides updated instructions.

Do not silently change product scope.

## 3. Mandatory Technology Rules

- Flutter and Dart are mandatory.
- Use Material 3.
- Use feature-first MVVM architecture.
- Use Riverpod for shared application state.
- Use go_router for routing.
- Use typed models for application data.
- Use repositories and data sources for data access.
- Support local JSON demo data.
- Keep API integration replaceable.
- Use SharedPreferences for local favorites.
- Do not introduce Firebase, Supabase, Bloc, GetX, or other alternatives without a documented requirement and explicit approval.

Do not use React Native, Kotlin-native, Java-native, or a web application as a substitute for Flutter.

## 4. Coding Standards

### Dart

- Follow effective Dart conventions.
- Use null safety.
- Prefer `const` where applicable.
- Avoid `dynamic` unless unavoidable at data boundaries.
- Use clear, descriptive names.
- Keep methods focused on one responsibility.
- Keep widgets small and reusable.
- Avoid duplicated business logic.
- Avoid unnecessary dependencies.
- Use formatters and static analysis.

### Architecture

- Widgets must not call external API endpoints directly.
- Widgets must not contain repository implementation details.
- State objects or view models coordinate interaction logic.
- Repositories provide domain models.
- Data sources handle external and local storage operations.
- API DTOs must be converted to domain models.
- Avoid circular dependencies.

### Folder Discipline

- Store feature-specific code within the appropriate feature.
- Store reusable components in core.
- Do not place every feature in main.dart.
- Do not create unnecessary service, helper, or utility files.
- Do not rename established files without a clear reason.
- Update imports when moving files.

## 5. UI/UX Rules

Use the MakanYuk Malang design system.

Primary color: `#D75A32`\
Background: `#FFF8F0`\
Text: `#24352F`\
Accent: `#E8D9C5`

Typography: Plus Jakarta Sans.

UI must:

- Be clean, modern, and mobile-first.
- Use consistent spacing and rounded corners.
- Be responsive.
- Avoid RenderFlex overflow.
- Use appropriate icons and readable text.
- Handle long restaurant names and addresses.
- Include meaningful loading, empty, and error states.
- Use suitable image placeholders.
- Avoid excessively complex animations.
- Preserve consistent component styling.

Do not redesign existing approved screens without a requirement.

## 6. Navigation Rules

Required routes:

- Home.
- Explore.
- Culinary Detail.
- Favorites.

Navigation must:

- Work from both cards and navigation elements.
- Support Android back behavior.
- Pass stable place identifiers.
- Handle missing details safely.
- Avoid stacking duplicate pages unnecessarily.

## 7. Data Rules

Never hardcode an entire restaurant database inside UI widgets.

Use:

- A culinary domain model.
- Local JSON data source.
- Remote API data source.
- Repository abstraction.

Do not mix response DTOs with UI models.

Dummy data:

- Must be clearly identified as demo data.
- Must have consistent IDs.
- Must not claim verified real-world ratings, prices, or opening hours.
- Must remain available for offline demonstrations.

Remote data:

- Validate nullable fields.
- Handle malformed and unsuccessful responses.
- Handle unavailable network conditions.
- Never fabricate missing values.
- Preserve source attribution where required.

## 8. API & Security Rules

- Never hardcode secret API keys.
- Never commit credentials or service-role keys.
- Do not place confidential Google Places web-service keys in Flutter source or mobile assets.
- Use backend proxy or an appropriately secured provider-supported mobile integration.
- Use environment configuration where appropriate.
- Keep private secrets on the server.
- Limit API requests and requested fields.
- Document necessary API setup.
- Follow provider attribution, usage, caching, and billing requirements.
- Do not log personal information or secrets.

Do not claim that API integration is working unless it has actually been verified.

## 9. Feature Implementation Rules

Implement in this order:

1. Project setup.
2. Theme and design system.
3. Domain model and JSON.
4. Repository.
5. Home screen.
6. Explore screen.
7. Detail screen.
8. Favorites screen.
9. Search and filter.
10. Local favorites persistence.
11. Remote API integration.
12. Tests.
13. Documentation.

Complete the current milestone before starting another unrelated feature.

Do not add authentication, checkout, delivery, chatbot, machine learning, or administration features unless requested.

## 10. Testing & Validation

After meaningful changes, run applicable checks:

```
dart format .
flutter analyze
flutter test
```

When relevant, also run or build the Android application.

Required checks:

- All primary routes work.
- Search returns expected local results.
- Category filters behave correctly.
- Detail route displays the selected item.
- Favorites can be added and removed.
- Favorites survive an application restart.
- Missing images use placeholders.
- API errors are handled gracefully.
- JSON fallback functions.
- No important layout overflow.

Never report a test as passed without executing it.

If a tool or environment is unavailable, report that limitation explicitly.

## 11. Agent Workflow

For every development task:

### Step 1 — Inspect

Read relevant documents and existing implementation.

### Step 2 — Plan

Identify affected files, dependencies, and acceptance criteria.

### Step 3 — Implement

Make focused changes that preserve existing behavior.

### Step 4 — Validate

Run formatting, analysis, tests, and relevant runtime checks when available.

### Step 5 — Report

Provide a concise implementation summary:

- What changed.
- Which files changed.
- Which tests were run.
- Whether tests passed.
- Known issues or blockers.
- Recommended next implementation step.

Do not claim completion if acceptance criteria remain unmet.

## 12. Change Control

Before adding any major dependency or changing architecture:

- Explain why it is necessary.
- Compare the proposed change with the existing approach.
- Avoid the change if the current architecture is sufficient.

Do not delete working features to simplify implementation.

Do not rewrite unrelated modules.

Respect code and decisions already approved.

## 13. Documentation Rules

Update README.md when:

- Installation steps change.
- Dependencies change.
- Configuration changes.
- Features are added.
- API setup changes.

Keep technical documentation accurate and consistent with the actual project.

README must explain:

- Project overview.
- Flutter setup.
- How to run.
- Main features.
- Screen descriptions.
- Project structure.
- Demo data.
- API configuration.
- Testing commands.

## 14. Definition of Done

A task is complete only when:

- Required functionality is implemented.
- Relevant edge cases are handled.
- Architecture rules are respected.
- Code is formatted.
- Available tests have passed.
- Documentation is updated where necessary.
- Remaining issues are clearly reported.

## 15. Final Priority Rule

Prioritize in this order:

1. Functional correctness.
2. UTS requirements.
3. Clean and consistent UI.
4. Maintainable architecture.
5. Data and API reliability.
6. Testing and documentation.
7. Optional enhancements.

Build the smallest complete, polished application that satisfies the product requirements.

Never sacrifice functional correctness merely to make the UI visually attractive.

## 4. Dependency dan urutan eksekusi

Agar Codex tidak membangun semuanya sekaligus tanpa validasi, saya sarankan menggunakan sistem milestone dengan checkpoint.

Project Milestone Tracker

0/15 tugas

Phase 0: Foundation

0/3

Proyek Flutter dibuat

Theme dan router aktif

Model dan JSON siap

Phase 1: UI Implementation

0/3

Home dan Explore selesai

Detail dan Favorit selesai

Tampilan responsif

Phase 2: Features

0/3

Pencarian dan filter berjalan

Favorit tersimpan permanen

Error dan empty state tersedia

Phase 3: API Integration

0/3

Backend proxy dikonfigurasi

Data API dinormalisasi

Fallback JSON teruji

Phase 4: Finalization

0/3

Analisis dan pengujian selesai

README dan screenshot tersedia

Laporan UTS selesai

## 5. Master Prompt untuk memulai Codex

Setelah membuat proyek Flutter dan memasukkan ketiga dokumen tadi, gunakan instruksi berikut sebagai langkah pertama.

Saya sedang membangun aplikasi Flutter bernama **MakanYuk Malang** untuk UTS Mobile Programming.

Baca dan pahami seluruh dokumen berikut sebelum menulis kode:

- `docs/PRD.md`
- `docs/ARCHITECTURE.md`
- `AGENTS.md`

Tugasmu adalah menjadi senior Flutter developer dan membangun proyek secara bertahap berdasarkan dokumen tersebut.

**Mulai dari Phase 0 — Project Foundation saja.**

Yang perlu dilakukan:

1. Periksa kondisi proyek Flutter.
2. Siapkan struktur folder sesuai arsitektur.
3. Konfigurasi dependencies yang diperlukan.
4. Buat design system Material 3 menggunakan palet MakanYuk Malang.
5. Siapkan navigasi dasar.
6. Buat model data kuliner.
7. Siapkan JSON demo data yang valid.
8. Pastikan aplikasi bisa dijalankan.

**Aturan wajib:**

- Jangan mengimplementasikan fitur fase berikutnya sebelum fase sekarang tervalidasi.
- Jangan memasukkan API key dalam kode.
- Jangan membuat kode placeholder yang menyebabkan aplikasi gagal build.
- Jangan menggunakan data fiktif seolah-olah merupakan fakta tempat makan.
- Gunakan clean code dan widget reusable.
- Jalankan `dart format .`, `flutter analyze`, dan `flutter test` apabila environment mendukung.
- Laporkan file yang dibuat, hasil validasi, kendala, dan langkah selanjutnya.

Target Phase 0 adalah fondasi Flutter yang rapi, berjalan, dan siap dikembangkan menjadi UI MakanYuk Malang.

## 6. Rekomendasi keputusan final

Gunakan Flutter + Riverpod + go_router. Ini akan membuat manajemen state dan navigasi lebih konsisten.

Jangan buat database server pada tahap awal. JSON lokal dan penyimpanan favorit sudah cukup untuk membuktikan konsep. Siapkan remote repository agar API dapat diintegrasikan setelahnya.

Utamakan Kota Malang. Wilayah lain seperti Kabupaten Malang dan Batu dapat menjadi fitur lanjutan agar hasil rekomendasi tidak keluar dari fokus proyek.

Pertahankan scope UTS. Empat halaman yang matang, pencarian berfungsi, favorit tersimpan, dan integrasi data yang jelas jauh lebih bernilai daripada banyak fitur yang belum selesai.

Ketiga dokumen ini merupakan spesifikasi awal proyek, bukan bukti bahwa kodenya sudah diimplementasikan. Setelah isinya dimasukkan ke repository, Codex dapat menggunakan `AGENTS.md` untuk mengikuti aturan pengembangan, sementara PRD dan Architecture menjadi acuan teknisnya.

Langkah berikutnya yang paling tepat: jalankan master prompt Phase 0, lalu lanjutkan pembangunan UI secara bertahap berdasarkan hasil validasi setiap fase.
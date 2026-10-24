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




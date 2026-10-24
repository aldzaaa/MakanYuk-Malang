# Kontrak dan pengujian API

Konfigurasi compile-time: `CULINARY_API_URL` berupa base URL tanpa secret,
query, userinfo atau fragment. HTTPS wajib kecuali host pengembangan lokal.
HTTP timeout 10 detik; respons dibatasi 1 MiB dan paling banyak 20 tempat.

```json
{
  "data": [{
    "id": "place_001", "name": "Nama dari provider", "category": "Restoran",
    "address": "Alamat dari provider", "description": null, "imageUrl": null,
    "latitude": null, "longitude": null, "rating": null, "ratingCount": null,
    "source": "google_places"
  }],
  "source": "google_places",
  "isDemo": false,
  "attributions": []
}
```

Untuk demo: source envelope dan setiap item harus `demo`, isDemo true.
ID harus unik, kolom wajib tidak kosong, angka valid, dan label source konsisten.
DTO memvalidasi respons sebelum dikonversi menjadi CulinaryCatalog/CulinaryPlace.
Kegagalan HTTP, jaringan, parsing atau konfigurasi menghasilkan JSON lokal
dengan banner kegagalan API yang terlihat. Jika JSON juga gagal, UI error + coba lagi.
Respons kosong yang valid tetap kosong (tidak diam-diam diganti demo).

## Server kontrak yang tersedia

Jalankan `node tools/demo_api.mjs`; server hanya bind ke 127.0.0.1:8787.
GET /api/v1/culinary?category=all&limit=20, kategori valid sesuai seed,
limit integer 1-20. Hasil demo, no-store, CORS hanya browser localhost.
Validasi server diuji melalui request HTTP nyata dengan node:test.
Server ini **bukan** backend produksi atau proxy Places.

## Menyiapkan backend live

Ikuti spesifikasi ARCHITECTURE.md. Google Places API New diakses dari server
dengan key environment server, field mask seperlunya, validasi kategori/limit,
rate limit serta quota/budget provider. Jangan memanggil Places web service
bersecret dari Flutter. Atribusi Google Maps/provider wajib ditampilkan.
Jangan menyimpan data Places secara permanen tanpa dasar izin provider.
Sediakan Terms of Use dan Privacy Policy yang sesuai sebelum publikasi live.

Referensi resmi:
- https://developers.google.com/maps/documentation/places/web-service/text-search
- https://developers.google.com/maps/documentation/places/web-service/choose-fields
- https://developers.google.com/maps/documentation/places/web-service/policies

Status: client REST dan fallback teruji; koneksi live Google tidak diklaim aktif.
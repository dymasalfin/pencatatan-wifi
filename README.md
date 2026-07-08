# Pencatatan WiFi (FTTH)

Aplikasi pencatatan pemasangan WiFi/FTTH untuk tim teknisi — realtime, multi-user, dengan login.

**Link aplikasi:** https://dymasalfin.github.io/pencatatan-wifi/

## Cara kerja singkat

- Aplikasi = **satu file** `index.html` (HTML + CSS + JavaScript murni, tanpa build/install). Library dari CDN: Bootstrap 5, supabase-js v2, jsPDF.
- Data tersimpan di **Supabase** (PostgreSQL + Realtime). Semua pengguna yang login melihat data yang sama; perubahan (tambah/edit/hapus) langsung muncul di perangkat lain tanpa refresh.
- Hosting di **GitHub Pages**: setiap push ke branch `main` otomatis memperbarui link aplikasi dalam 1–2 menit.

## Struktur data (Supabase)

| Tabel | Isi |
|---|---|
| `catatan` | Data pemasangan: tanggal (otomatis), koordinat, barang (modem), olt, pon, redaman, teknisi, titik (nama pelanggan) |
| `modem` | Daftar nama modem untuk dropdown (bisa ditambah dari aplikasi) |
| `teknisi` | Daftar nama teknisi untuk dropdown (bisa ditambah dari aplikasi) |

Keamanan: RLS (Row Level Security) aktif — hanya user **login** yang bisa baca/tulis. Pendaftaran akun bebas **dimatikan**; akun dibuat manual di dashboard Supabase (Authentication → Users → Add user → centang *Auto Confirm User*).

File SQL di repo ini adalah riwayat setup database (untuk referensi / setup ulang dari nol):
1. `supabase-setup.sql` — tabel catatan & modem + realtime
2. `supabase-teknisi.sql` — tabel teknisi
3. `supabase-kunci-akses.sql` — penguncian akses (hanya login)

## Konfigurasi

Koneksi database ada di bagian atas `<script>` dalam `index.html`:

```js
const SUPABASE_URL = "https://....supabase.co";
const SUPABASE_KEY = "sb_publishable_...";  // publishable key — memang boleh publik
```

Jika kedua konstanta dikosongkan, aplikasi berjalan mode lokal (localStorage, tanpa login) — berguna untuk uji coba tampilan.

## Cara mengembangkan

1. Clone repo, edit `index.html`, buka langsung di browser untuk tes.
2. Push ke `main` → GitHub Pages memperbarui otomatis.

## Akses yang dibutuhkan pengelola baru

1. **Repo GitHub ini** — pemilik repo mengundang lewat: Settings → Collaborators → Add people.
2. **Project Supabase** — pemilik mengundang lewat dashboard Supabase: Organization → Team → Invite member. Dari dashboard ini dikelola: akun teknisi, isi database, dan SQL Editor.

## Catatan operasional

- **Backup:** paket gratis Supabase tidak punya backup otomatis — biasakan Export Excel berkala dari aplikasi.
- **Project tidur:** project Supabase gratis di-pause jika tidak diakses ±1 minggu; pulihkan lewat dashboard (tombol Restore), data tidak hilang.
- Export PDF/Excel mengambil hingga 10.000 baris; jika kolom pencarian sedang terisi, yang diexport adalah hasil pencariannya.

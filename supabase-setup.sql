-- Setup database Pencatatan WiFi (FTTH)
-- Jalankan sekali di Supabase: menu "SQL Editor" > New query > paste semua ini > Run

-- Tabel catatan pemasangan
create table catatan (
  id bigint generated always as identity primary key,
  tanggal timestamptz not null default now(),
  koordinat text,
  barang text,
  olt text,
  pon text,
  redaman text,
  teknisi text,
  titik text
);

-- Index supaya tetap cepat walau ratusan ribu baris
create index catatan_tanggal_idx on catatan (tanggal desc);

-- Tabel daftar modem (dipakai bersama semua teknisi)
create table modem (
  id bigint generated always as identity primary key,
  nama text not null unique
);

insert into modem (nama) values
 ('Huawei HG8145V5'),
 ('Huawei EG8245H5'),
 ('Huawei Biasa'),
 ('ZTE F609');

-- Izin akses: siapa pun yang punya link boleh baca & tulis
alter table catatan enable row level security;
create policy "akses publik catatan" on catatan
  for all using (true) with check (true);

alter table modem enable row level security;
create policy "akses publik modem" on modem
  for all using (true) with check (true);

-- Aktifkan realtime untuk kedua tabel
alter publication supabase_realtime add table catatan;
alter publication supabase_realtime add table modem;

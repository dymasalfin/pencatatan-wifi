-- Tabel daftar teknisi (dipakai bersama, bisa ditambah dari aplikasi)
-- Jalankan di Supabase: SQL Editor > New query > paste semua > Run

create table teknisi (
  id bigint generated always as identity primary key,
  nama text not null unique
);

insert into teknisi (nama) values
 ('IBRA'),
 ('NAFIS'),
 ('PAK NO'),
 ('PANI');

alter table teknisi enable row level security;
create policy "akses publik teknisi" on teknisi
  for all using (true) with check (true);

alter publication supabase_realtime add table teknisi;

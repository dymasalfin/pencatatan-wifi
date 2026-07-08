-- Kunci akses: hanya pengguna yang login yang bisa baca/tulis data.
-- Jalankan di Supabase: SQL Editor > New query > paste semua > Run.
-- Jalankan SETELAH akun teknisi dibuat, supaya tidak ada yang terkunci di luar.

drop policy "akses publik catatan" on catatan;
drop policy "akses publik modem" on modem;

create policy "hanya login catatan" on catatan
  for all to authenticated using (true) with check (true);

create policy "hanya login modem" on modem
  for all to authenticated using (true) with check (true);

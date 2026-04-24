create table if not exists public.backup_snapshot_batches (
  id bigserial primary key,
  account_id uuid not null,
  installation_id text not null,
  batch_key text not null,
  domain_key text not null,
  operation_key text not null,
  payload_version integer not null default 1,
  snapshot_prepared_at timestamptz not null,
  uploaded_at timestamptz not null,
  payload_json jsonb not null,
  inserted_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  unique (account_id, installation_id, domain_key, operation_key)
);

create index if not exists backup_snapshot_batches_account_uploaded_idx
  on public.backup_snapshot_batches (account_id, uploaded_at desc);

alter table public.backup_snapshot_batches enable row level security;

create policy if not exists "Users can read their own backup batches"
  on public.backup_snapshot_batches
  for select
  to authenticated
  using (auth.uid() = account_id);

create policy if not exists "Users can upsert their own backup batches"
  on public.backup_snapshot_batches
  for insert
  to authenticated
  with check (auth.uid() = account_id);

create policy if not exists "Users can update their own backup batches"
  on public.backup_snapshot_batches
  for update
  to authenticated
  using (auth.uid() = account_id)
  with check (auth.uid() = account_id);

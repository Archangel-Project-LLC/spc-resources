-- Silverback Client CRM — database schema
-- Run this once in your Supabase project: SQL Editor → New query → paste → Run.
-- It creates the clients table, locks it down so each coach only ever sees their
-- own rows (Row-Level Security), and keeps an updated_at timestamp current.

create table if not exists public.clients (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users (id) on delete cascade default auth.uid(),
  name          text not null,
  status        text not null default 'lead' check (status in ('lead','active','paused','ended')),
  email         text,
  phone         text,
  goal          text,
  start_date    date,
  next_checkin  date,
  fee           numeric not null default 0,
  notes         text,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

-- Fast lookups of "my clients".
create index if not exists clients_user_id_idx on public.clients (user_id);

-- Row-Level Security: without a policy, no one can read or write. With these,
-- an authenticated coach can only touch rows where user_id matches their login.
alter table public.clients enable row level security;

drop policy if exists "Coaches manage their own clients" on public.clients;
create policy "Coaches manage their own clients"
  on public.clients
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Keep updated_at fresh on every change.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists clients_set_updated_at on public.clients;
create trigger clients_set_updated_at
  before update on public.clients
  for each row execute function public.set_updated_at();

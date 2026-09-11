-- Kozy cloud sync database
-- Run this in Supabase SQL Editor before using cloud sync.

create table if not exists public.kozy_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.kozy_state enable row level security;

revoke all on table public.kozy_state from anon;
grant select, insert, update, delete on table public.kozy_state to authenticated;

drop policy if exists "Users can read their own Kozy state" on public.kozy_state;
drop policy if exists "Users can create their own Kozy state" on public.kozy_state;
drop policy if exists "Users can update their own Kozy state" on public.kozy_state;
drop policy if exists "Users can delete their own Kozy state" on public.kozy_state;

create policy "Users can read their own Kozy state"
on public.kozy_state for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "Users can create their own Kozy state"
on public.kozy_state for insert
to authenticated
with check ((select auth.uid()) = user_id);

create policy "Users can update their own Kozy state"
on public.kozy_state for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

create policy "Users can delete their own Kozy state"
on public.kozy_state for delete
to authenticated
using ((select auth.uid()) = user_id);

create index if not exists kozy_state_user_id_idx on public.kozy_state(user_id);

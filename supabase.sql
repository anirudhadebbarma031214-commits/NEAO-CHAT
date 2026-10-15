-- NEAO CHAT database schema. Run in Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.rooms (
 id uuid primary key default gen_random_uuid(),
 code text not null unique check (code ~ '^[A-Z2-9]{6}$'),
 created_by uuid not null,
 created_at timestamptz not null default now()
);
create table if not exists public.messages (
 id uuid primary key default gen_random_uuid(),
 room_id uuid not null references public.rooms(id) on delete cascade,
 sender_id uuid not null,
 sender_name text not null check (char_length(sender_name) between 1 and 24),
 content text not null check (char_length(content) between 1 and 2000),
 created_at timestamptz not null default now()
);
create index if not exists messages_room_created_idx on public.messages(room_id,created_at);
alter table public.rooms enable row level security;
alter table public.messages enable row level security;
drop policy if exists "Read rooms" on public.rooms;
create policy "Read rooms" on public.rooms for select to authenticated using (true);
drop policy if exists "Create rooms" on public.rooms;
create policy "Create rooms" on public.rooms for insert to authenticated with check (created_by=auth.uid());
drop policy if exists "Read messages" on public.messages;
create policy "Read messages" on public.messages for select to authenticated using (exists(select 1 from public.rooms r where r.id=room_id));
drop policy if exists "Send messages" on public.messages;
create policy "Send messages" on public.messages for insert to authenticated with check (sender_id=auth.uid() and exists(select 1 from public.rooms r where r.id=room_id));
do $$ begin alter publication supabase_realtime add table public.messages; exception when duplicate_object then null; when others then if sqlstate <> '42710' then raise; end if; end $$;
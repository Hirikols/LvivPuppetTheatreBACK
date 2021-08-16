set statement_timeout = 0;
set lock_timeout = 0;
set idle_in_transaction_session_timeout = 0;
set client_encoding = 'UTF8';
set standard_conforming_strings = on;
select pg_catalog.set_config('search_path', '', false);
set check_function_bodies = false;
set xmloption = content;
set client_min_messages = warning;
set row_security = off;

set default_tablespace = '';

set default_table_access_method = heap;

create table public."Audio" (
    "Id" integer NOT NULL,
    "FileName" text NOT NULL,
    "OriginalText" text not null,
    "Duration" integer not null,
    "SpeechId" integer not null,
    "LanguageId" integer not null,
);

alter table public."Audio" owner to dubbing;

create sequence public."Audio_Id_seq"
    as integer
    start with 1
    increment by 1
    no minvalue
    no maxvalue
    cache 1;

alter table public."Audio_Id_seq" owner to dubbing;

alter sequence public."Audio_Id_seq" owned by public."Audio"."Id";

create table public."Languages" (
    "Id" integer not null,
    "Name" text not null
);

alter table public."Languages" owner to dubbing;

create sequence public."Languages_Id_seq"
    as integer
    start with 1
    increment by 1
    no minvalue
    no maxvalue
    cache 1;

alter table public."Languages_Id_seq" owner to dubbing;

alter sequence public."Languages_Id_seq" owned by public."Languages"."Id"

create table public."Performances" (
    "Id" integer not null,
    "Title" text not null,
    "Description" text not null
);

alter table public."Performances" owner to dubbing;

create sequence public."Performances_Id_seq" 
    as integer
    start with 1
    increment by 1
    no minvalue
    no maxvalue
    cache 1;

alter table public."Performances_Id_seq" owner to dubbing;

alter sequence public."Performances_Id_seq" owned by public."Performances"."Id"

create table public."Speeches" (
    "Id" integer not null,
    "Order" integer not null,
    "Text" text not null,
    "Duration" integer not null,
    "PerformanceId" integer not null
);

alter table public."Speeches" owner to dubbing;

create sequence public."Speeches_Id_seq"
    as integer
    start with 1
    increment by 1
    no minvalue
    no maxvalue
    cache 1;

alter table public."Speeches_Id_seq" owner to dubbing;

alter sequence public."Speeches_Id_seq" owned by public."Speeches"."Id";

create table public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) not null,
    "ProductVersion" character varying(32) not null 
);

alter table public."__EFMigrationsHistory" owner to dubbing;

alter table only public."Audio" alter column "Id" set default nextval('public."Audio_Id_seq"'::regclass);

alter table only public."Languages" alter column "Id" set default nextval('public."Languages_Id_seq"'::regclass);

alter table only public."Performances" alter column "Id" set default nextval('public."Performances_Id_seq"'::regclass);

alter table only public."Speeches" alter column "Id" set default nextval('public."Speeches_Id_seq"'::regclass);

alter table only public."Audio"
    add constraint "PK_Audio" primary key ("Id");

alter table only public."Languages"
    add constraint "PK_Languages" primary key ("Id");

alter table only public."Performances"
    add constraint "PK_Performances" primary key ("Id");

alter table only public."Speeches"
    add constraint "PK_Speeches" primary key ("Id");

alter table only public."__EFMigrationsHistory"
    add constraint "PK___EFMigrationsHistory" primary key ("MigrationId"); 

create index "IX_Audio_LanguageId" on public."Audio" using btree ("LanguageId");

create index "IX_Audio_SpeechId" on public."Audio" using btree ("SpeechId");

create index "IX_Speeches_PerformanceId" on public."Speeches" using btree ("PerformanceId");

alter table only public."Audio"
    add constraint "FK_Audio_Languages_LanguageId" foreign key ("LanguageId") references public."Languages"("Id") on delete  cascade;

alter table only public."Audio"
    add constraint "FK_Audio_Speeches_SpeechId" foreign key ("SpeechId") references public."Speeches"("Id") on delete  cascade;
    
alter table only public."Speeches"
    add constraint "FK_Speeches_Performances_PerformanceId" foreign key ("PerformanceId") references public."Performances"("Id") on delete  cascade;
    

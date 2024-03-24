CREATE TABLE "users" (
  "user_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "username" varchar(30) UNIQUE NOT NULL,
  "email" varchar(30) UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "name" varchar NOT NULL,
  "role" varchar(10) NOT NULL,
  "gender" varchar(10) NOT NULL,
  "avatar" varchar,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "posts" (
  "post_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" varchar(100) DEFAULT '',
  "body" text DEFAULT '',
  "og_image" varchar,
  "slug" varchar UNIQUE NOT NULL,
  "published" boolean NOT NULL DEFAULT false,
  "created_by" integer,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "claps" (
  "clap_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "counter" integer DEFAULT 0,
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "comments" (
  "comment_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "content" text,
  "created_at" timestamp DEFAULT 'now()',
  "visible" boolean,
  "comment_parent_id" integer
);

CREATE TABLE "users_lists" (
  "user_list_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" integer,
  "title" varchar(100)
);

CREATE TABLE "user_list_entry" (
  "user_list_entry_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_list_id" integer,
  "post_id" integer
);

CREATE UNIQUE INDEX ON "claps" ("post_id", "user_id");

CREATE INDEX ON "claps" ("post_id");

CREATE INDEX ON "comments" ("post_id");

CREATE INDEX ON "comments" ("visible");

CREATE UNIQUE INDEX ON "users_lists" ("user_id", "title");

CREATE INDEX ON "users_lists" ("user_id");

ALTER TABLE "posts" ADD FOREIGN KEY ("created_by") REFERENCES "users" ("user_id");

ALTER TABLE "claps" ADD FOREIGN KEY ("clap_id") REFERENCES "posts" ("post_id");

ALTER TABLE "claps" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("comment_id") REFERENCES "posts" ("post_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "comments" ADD FOREIGN KEY ("comment_parent_id") REFERENCES "comments" ("comment_id");

ALTER TABLE "users_lists" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "user_list_entry" ADD FOREIGN KEY ("user_list_id") REFERENCES "users_lists" ("user_list_id");

ALTER TABLE "user_list_entry" ADD FOREIGN KEY ("post_id") REFERENCES "posts" ("post_id");


----------------------------------------------------
-- This SQL creates 3 separate schemas(SQL folders), for 3 separate apps.
-- Each app schema has it's own set of tables --
-- This limits which PostgreSQL user has can access each app's schema and data. --
-- For Fair Share (Tip App) use 'user1' to access it's schema and tables -- 
-- Why? Cause It's cheaper to host 1 database instead of 3 separate databases (using Heroku) --
----------------------------------------------------


------------- FAIR SHARE APP SQL CODE ----------------

CREATE TABLE "fairshare_sch"."employees" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100)
);


CREATE TABLE "fairshare_sch"."user" (
    "id" SERIAL PRIMARY KEY,
    "emp_id" INT REFERENCES "fairshare_sch"."employees"("id"),
    "username" VARCHAR (80) UNIQUE NOT NULL,
    "password" VARCHAR (1000) NOT NULL
);


CREATE TABLE "fairshare_sch"."date" (
    "id" SERIAL PRIMARY KEY,
    "date" DATE NOT NULL DEFAULT CURRENT_DATE,
    "hours_total" NUMERIC,
    "tip_total" NUMERIC,
    "cash_tips" NUMERIC,
    "cc_tips" NUMERIC
);

CREATE TABLE "fairshare_sch"."tips" (
    "id" SERIAL PRIMARY KEY,
    "date_id" INT REFERENCES "fairshare_sch"."date"("id"),
    "emp_id" INT REFERENCES "fairshare_sch"."employees"("id"),
    "hours" NUMERIC,
    "share_total" NUMERIC,
    "share_cash" NUMERIC,
    "share_cc" NUMERIC
);


-- test data

INSERT INTO "fairshare_sch"."date" ("date", "tip_total", "cash_tips", "cc_tips") 
VALUES ('1999-01-01', 400, 200, 200);

INSERT INTO "fairshare_sch"."employees" ("name")
VALUES ('Dave'), ('Joshua'), ('Mike'), ('Brendan');

INSERT INTO "fairshare_sch"."tips" ("date_id", "emp_id", "share_total", "share_cash", "share_cc")
VALUES (1, 1, 100, 50, 50), (1, 2, 100, 50, 50), (1, 3, 100, 50, 50), (1, 4, 100, 50, 50); 

SELECT "name", "date", "share_total", "share_cash", "share_cc"
FROM "fairshare_sch"."tips" 
JOIN "fairshare_sch"."date" on "fairshare_sch"."tips"."date_id" = "fairshare_sch"."date"."id"
JOIN "fairshare_sch"."employees" ON "fairshare_sch"."tips"."emp_id" = "fairshare_sch"."employees"."id";

SELECT "name", "date", "share_total", "share_cash", "share_cc"
FROM "tips" 
JOIN "date" on "tips"."date_id" = "date"."id"
JOIN "employees" ON "tips"."emp_id" = "employees"."id"
WHERE "employees"."id" = 1;



-- NATE ADDED BELLOW --

ALTER TABLE "user"
ADD COLUMN "email" varchar(255);

CREATE SCHEMA fairshare_app;
CREATE SCHEMA wikhehepedia_app;
CREATE SCHEMA RCI_app;


SELECT rolname, rolsuper
FROM pg_roles;

SELECT * 
FROM pg_roles;

 SELECT pg_authid.rolname,
    pg_authid.rolsuper;

CREATE SCHEMA wikhehepedia_app AUTHORIZATION nate;

CREATE SCHEMA fairshare_sch AUTHORIZATION user1;

CREATE SCHEMA rci_app AUTHORIZATION nate;


---- Wik-hehe-pedia Schema code --
-- CREATE USER TABLE --
CREATE TABLE "wikhehepedia_app"."user" (
	"id" SERIAL PRIMARY KEY,
	"username" varchar(25) NOT NULL UNIQUE,
	"password" varchar(200) NOT NULL,
	"name" varchar(25),
	"access_level" int NOT NULL DEFAULT 3
);


-- CREATE COMEDIANS TABLE --
CREATE TABLE "wikhehepedia_app"."comedians" (
"id" SERIAL PRIMARY KEY,
"first_name" VARCHAR (50),
"last_name" VARCHAR (50),
"icon" VARCHAR (50),
"genre" VARCHAR (50),
"instagram_link" VARCHAR (255),
"youtube_link" VARCHAR (255),
"twitter_link" VARCHAR (255),
"website_link" VARCHAR (255),
"city" VARCHAR (50),
"description" TEXT
);

-- CREATE FAVORITES TABLE --
CREATE TABLE "wikhehepedia_app"."favorites" (
"id" SERIAL PRIMARY KEY,
"user_id" INT REFERENCES "wikhehepedia_app"."user" ON DELETE CASCADE NOT NULL,
"comedian_id" INT REFERENCES "wikhehepedia_app"."comedians" ON DELETE CASCADE NOT NULL
);

-- ADD Admin and USER 1 -- 
INSERT INTO "wikhehepedia_app"."user" ( "username", "password", "name", "access_level" ) VALUES 
( 'admin', '$2a$10$cdwGyp.FbNfJczpdYd2s5O0aH5IGiCh0kvHCSmcCSKK25bRFuBLGa', 'Admin', 1),  --admin, password is: "admin"
( 'user1', '$2a$10$kztK6AtXpJ2dNyegvTyOQeDfh./6TnL8.SrB6SNAzQaahG/BLdIdO', 'user1', 3); -- user 1, password is: "user1"

------ COMEDIAN DATA ------
INSERT INTO "wikhehepedia_app"."comedians" ("first_name", "last_name", "icon", "genre", "instagram_link", "twitter_link","youtube_link", "website_link", "city" )
VALUES
('Nate','Bargatze','images/Icons/IconsNate.jpg','Clean','https://www.instagram.com/natebargatze/','https://www.youtube.com/watch?v=pGUhBzSgOxw&ab_channel=NetflixIsAJoke','https://twitter.com/natebargatze?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor','https://natebargatze.com/','Nashville'),
('Ronny','Chieng','images/Icons/icons_0000_rony2.jpg','Cool','https://www.instagram.com/ronnychieng/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','Los Angeles'),
('Whitteny','Cummings','images/Icons/icons_0006_whitney_cummings.jpg','Adult','https://www.instagram.com/whitneycummings/','https://www.youtube.com/user/MonicaNevi','https://twitter.com/monicanevi?lang=en','https://monicanevi.com/','Los Angeles'),
('Kaitlyn','DaleMore','images/Icons/iconDale.jpg','Dale','https://www.instagram.com/seguratom/?hl=en','https://www.instagram.com/seguratom/?hl=en','https://www.instagram.com/seguratom/?hl=en', 'https://www.instagram.com/seguratom/?hl=en','Minneapolis'),
('Francesca','Fiorentini','images/Icons/IconsFrancesca.jpg','Political','https://www.instagram.com/franifio/?hl=en','https://www.youtube.com/c/franifio','https://twitter.com/franifio?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor','https://www.francescafiorentini.com/','Los Angeles'),
('Jena','Friedman','images/Icons/IconsJena.jpg','Political','https://www.instagram.com/jenafriedman/','https://www.youtube.com/user/JenaFriedman2/featured','https://twitter.com/JenaFriedman','http://www.jenafriedman.com/','Los Angeles'),
('Tiffany','Haddish','images/Icons/icons_0008_tiffany.jpg','Adult','https://www.instagram.com/tiffanyhaddish/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','Los Angeles'),
('Hari','Kondabolu','images/Icons/IconsHari.jpg','Political','https://www.instagram.com/harikondabolu/','link','https://twitter.com/harikondabolu','https://harikondabolu.com/','New York'),
('Matteo','Lane','images/Icons/IconsMatteo.jpg','LGBTQ','https://www.instagram.com/matteolane/','link','link','link','New York'),
('Becky','Lucas','images/Icons/IconsBecky.jpg','Silly','https://www.instagram.com/beckylucas__/','link','link','link','Sydney, Australia'),
('Carmen','Lynch','images/Icons/IconsCarmen.jpg','Goofy & Spanish','https://www.instagram.com/carmencomedian/?hl=en','link','link','link','New York'),
('Liz','Miele','images/comedians/liz_miele_icon.jpg','Mental Health','https://www.instagram.com/lizmiele/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','New York'),
('Hasan','Minhaj','images/Icons/IconsHassan.jpg','Political','https://www.instagram.com/hasanminhaj/?hl=en','link','link','link','New York'),
('Sam','Morril','images/Icons/icons_0011_sam.jpg','Short Jokes','https://www.instagram.com/lizmiele/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','New York'),
('Monica','Nevi','images/comedians/monica_nevi_icon.jpg','Positive','https://www.instagram.com/monicanevi/','https://www.youtube.com/channel/UCQB3H0dKK-U0T0nueFX7mjg/joinFull','https://twitter.com/monicanevi?lang=en','https://monicanevi.com/','Seatle'),
('Trevor','Noah','images/Icons/IconsTrevor.jpg','Political','https://www.instagram.com/trevornoah/?hl=en','link','link','link','New York'),
('Mark','Normand','images/Icons/icons_0013_MarkNormand_800x800.jpg','Short Jokes','https://www.instagram.com/monicanevi/','https://www.youtube.com/user/MonicaNevi','https://twitter.com/monicanevi?lang=en','https://monicanevi.com/','New York'),
('Christina','P','images/Icons/iconsChristina.jpg','Mom Stories','https://www.instagram.com/seguratom/?hl=en','https://www.youtube.com/user/tomsegura','https://twitter.com/tomsegura?','https://tomsegura.com/','Austin'),
('Mrs','Pats','images/Icons/iconpats.jpg','NSFW','https://www.instagram.com/lizmiele/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','Los Angeles'),
('Joe','Rogan','images/Icons/IconJoeRogan.jpg','Basic','https://www.instagram.com/lizmiele/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','Austin'),
('Amy','Schumer','images/Icons/iconsAmy.jpg','Ruanchy','https://www.instagram.com/fan.amy.schumer/','https://www.youtube.com/user/MonicaNevi','https://twitter.com/monicanevi?lang=en','https://monicanevi.com/','Los Angeles'),
('Tom','Segura','images/comedians/tom_segura_icon.jpg','Dad Stories & Spanish','https://www.instagram.com/seguratom/?hl=en','https://www.youtube.com/user/tomsegura','https://twitter.com/tomsegura?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor','https://tomsegura.com/','Austin'),
('Maria','Shehata','images/Icons/IconsMaria.jpg','Fun','https://www.instagram.com/mariashehata/','https://www.youtube.com/c/MariaShehata','https://twitter.com/mariashehata','https://www.mariashehata.com/','London'),
('Ali','Sultan','images/Icons/IconsAliSultan.jpg','Cats','https://www.instagram.com/alisultancomedy/','https://www.youtube.com/channel/UCrV9G1mNWJysDssVGGlX07A','https://twitter.com/Ali_Sultan','https://alisultancomedy.com/','Minneapolis'),
('Wanda','Sykes','images/Icons/icons_0007_wanda.jpg','Ruanchy','https://www.instagram.com/iamwandasykes/','https://www.youtube.com/user/tomsegura','https://twitter.com/tomsegura?','https://tomsegura.com/','Los Angeles'),
('Sarah','Tollemache','images/Icons/icons_0004_sarah.jpg','Dry','https://www.instagram.com/stollemache/','https://www.youtube.com/user/tomsegura','https://twitter.com/tomsegura?','https://tomsegura.com/','New York'),
('Taylor','Tomlinson','images/Icons/icons_0009_taylor.jpg','Mental Health','https://www.instagram.com/taylortomlinson/','https://www.youtube.com/watch?v=oagNYHB3Kzk&ab_channel=NetflixIsAJoke','https://twitter.com/monicanevi?lang=en','https://ttomcomedy.com/','Los Angeles'),
('Irene','Tu','images/Icons/IconsIrene.jpg','LGBTQ','link','link','link','link','Los Angeles'),
('Michelle','Wolf','images/Icons/icons_0005_michelle.jpg','Political','https://www.instagram.com/michelleisawolf/','https://www.youtube.com/watch?v=F9m1jPu7afw&ab_channel=NetflixIsAJoke','https://twitter.com/michelleisawolf','https://www.michelleisawolf.com/about','New York'),
('Ali','Wong','images/Icons/icons_0001_ali_wong.jpg','Mom Stories','https://www.instagram.com/aliwong/','https://www.youtube.com/user/LizMiele','https://twitter.com/lizmiele','https://lizmiele.com/','Los Angeles'),
('Ramy','Youssef','images/Icons/IconsRamy.jpg','Millennial','https://www.instagram.com/ramy/','link','link','link','New York')
;


---------- RCI DATABASE CODE -------------

---- USER TABLE  --
CREATE TABLE "rci_app"."user" (
	"id" SERIAL PRIMARY KEY,
	"username" varchar(25) NOT NULL UNIQUE,
	"password" varchar(500) NOT NULL,
	"access_level" int NOT NULL
);

---- GROUP TABLE ---- 
CREATE TABLE "rci_app"."group" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" int REFERENCES "rci_app"."user"("id") ON DELETE CASCADE NOT NULL UNIQUE,
	"name" varchar(1000) NOT NULL DEFAULT 'My Name',
	"bio" varchar(1000) DEFAULT 'My Bio',
	"picture" varchar(1000) DEFAULT 
	'https://static.vecteezy.com/system/resources/thumbnails/007/319/936/small/user-profile-icon-vector.jpg',
	"website" varchar(1000) DEFAULT 'My Website',
	"email" varchar(1000) DEFAULT 'My email',
	"phone" varchar(50) DEFAULT 'My phone',
	"street" varchar(1000) DEFAULT 'My street',
	"city" varchar(1000) DEFAULT 'My city',
	"state" varchar(1000) DEFAULT 'My state',
	"zipcode" varchar(1000) DEFAULT 'My zipcode'
);


---- PROVIDER TABLE ----

CREATE TABLE "rci_app"."provider" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" int REFERENCES "rci_app"."user"("id") ON DELETE CASCADE NOT NULL UNIQUE,
	"name" varchar(100) DEFAULT 'My Name',
	"bio" varchar(1000) DEFAULT 'My Bio',
	"picture" varchar(1000) DEFAULT 
	'https://static.vecteezy.com/system/resources/thumbnails/007/319/936/small/user-profile-icon-vector.jpg',
	"phone" varchar(50) DEFAULT 'My phone',
	"email" varchar(100) DEFAULT 'My email',
	"availability" varchar(1000) DEFAULT 'My Availability',
	"group_id" int 
);

---- specializations TABLE ----
CREATE TABLE "rci_app"."specializations" (
	"id" serial PRIMARY KEY  NOT NULL,
	"specialization" varchar(100)
);

---- insurance_plan TABLE ----
CREATE TABLE "rci_app"."insurance_plan" (
	"id" serial PRIMARY KEY NOT NULL,
	"insurance" varchar(100)
);

---- service_type TABLE ----
CREATE TABLE "rci_app"."service_type" (
	"id" serial PRIMARY KEY NOT NULL,
	"service" varchar(255) 
);
---- occupations TABLE ----
CREATE TABLE "rci_app"."occupations" (
	"id" serial PRIMARY KEY NOT NULL,
	"occupation" varchar(255) 
);

---- INSERT specializations TABLE ----
INSERT INTO "rci_app"."specializations" ("specialization") VALUES
('LGBTQ Specific'),
('POC Specific'),
('Disability Specific'),
('Addiction'),
('Anxiety'),
('ADHD'),
('Autism'),
('Bipolar'),
('Child Psychiatry'),
('Cognitive-behavioral therapy'),
('COVID-related'),
('HOH'),
('Depression'),
('Crisis Response'),
('Eating Disorders'),
('Grief'),
('Group Therapy'),
('Family Counseling'),
('Medication Management'),
('OCD'),
('PTSD'),
('Diagnosis');

---- INSERT insurance_plan TABLE ----
INSERT INTO "rci_app"."insurance_plan" ("insurance") VALUES
('Blue Cross and Blue Shield of Minnesota'),
('HealthPartners'),
('Medica of Minnesota'),
('Quartz'),
('PreferredOne Insurance Company'),
('Golden Rule Insurance Company'),
('Independence American Insurance Company'),
('Ucare'),
('Humana'),
('Cigna'),
('Silverscript'),
('Medicare Insurance Providers in Minnesota');

---- INSERT service_type TABLE ----
INSERT INTO "rci_app"."service_type" ("service") VALUES
('Online'),
('In-Person'),
('Over the Phone'),
('Inpatient'),
('Outpatient');

---- INSERT occupation TABLE ----
INSERT INTO "rci_app"."occupations" ("occupation") VALUES
('Psychologist'),
('Counselor'),
('Certified Alcohol and Drug Abuse Counselor'),
('Clinician'),
('Clinical Social Worker'),
('Psychiatrist'),
('Mental Health Nurse Practitioner'),
('Family Nurse Practitioner'),
('Peer Specialist');


--  USER Dummy Data --
INSERT INTO "rci_app"."user" ( "username", "password", "access_level") VALUES 
( 'admin', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 1),  --user 1
( 'group1', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 2
( 'group2', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 3
( 'group3', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 4
( 'group4', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 5
( 'group5', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 6
( 'group6', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 7
( 'group7', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 8
( 'group8', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 9
( 'group9', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 10
( 'group10', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 3), --user 11
( 'provider1', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2),  --user 12
( 'provider2', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 13
( 'provider3', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 14
( 'provider4', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 15
( 'provider5', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 16
( 'provider6', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 17
( 'provider7', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 18
( 'provider8', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 19
( 'provider9', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2), --user 20
( 'provider10', '$2a$10$OsPuAKcp4ip.sb2zZUM9vuJwhoRdGdJVcbIlWobbX4XbFPcg8Zjey', 2)	 --user 21
;

--- stopped at line 207 --
-- 1. INSERT 100 ADDRESSES in Visoko
-- Using a predefined list of 20 streets and adding house numbers.
INSERT INTO addresses (street_address, city, state, zip_code, latitude, longitude)
SELECT
    CASE ((i - 1) % 20)
        WHEN 0 THEN 'Ulica 9. oktobra'
        WHEN 1 THEN 'Ulica Mehmeda Fejza'
        WHEN 2 THEN 'Ulica Kralja Tvrtka'
        WHEN 3 THEN 'Ulica Budčića'
        WHEN 4 THEN 'Ulica Halima'
        WHEN 5 THEN 'Ulica Fadilpaše'
        WHEN 6 THEN 'Trg Zajednice'
        WHEN 7 THEN 'Ulica Prilaz'
        WHEN 8 THEN 'Ulica Mula Mustafe'
        WHEN 9 THEN 'Ulica Branka Radičevića'
        WHEN 10 THEN 'Ulica Avdole'
        WHEN 11 THEN 'Ulica Mostarska'
        WHEN 12 THEN 'Ulica Visoka'
        WHEN 13 THEN 'Ulica Drage'
        WHEN 14 THEN 'Ulica Kapetan Josipa'
        WHEN 15 THEN 'Ulica Alije Đorđevića'
        WHEN 16 THEN 'Ulica Omerbaše'
        WHEN 17 THEN 'Ulica Smajlije'
        WHEN 18 THEN 'Ulica Seada'
        WHEN 19 THEN 'Ulica Zelica'
    END || ' ' || ((i % 10) + 1)::varchar AS street_address,
    'Visoko' AS city,
    'Zenica-Doboj Kanton' AS state,
    '75230' AS zip_code,
    43.990 + random() * 0.02 AS latitude,
    18.220 + random() * 0.02 AS longitude
FROM generate_series(1, 100) AS s(i);
-- Removed ON CONFLICT: Assumes address_id is auto-incrementing and no duplicates are expected.

-- 2. INSERT 150 HOUSEHOLDS
-- Each household is linked to one address (multiple households can share an address).
INSERT INTO households (household_name, address_id)
SELECT
    'Kućanstvo ' || s.i,
    (SELECT address_id FROM addresses ORDER BY address_id LIMIT 1 OFFSET ((s.i - 1) % (SELECT COUNT(*) FROM addresses)))
FROM generate_series(1, 150) AS s(i);
-- Removed ON CONFLICT: household_name is likely unique, or household_id is auto-incrementing.

-- 3. INSERT 200 CITIZENS
-- Randomly select names and surnames from arrays and generate birth dates.
INSERT INTO citizens (first_name, last_name, date_of_birth, email, phone, household_id)
SELECT
    (ARRAY['Adis','Aida','Ajdin','Ajla','Aldin','Alma','Am过去','Amila','Anel','Anisa','Armin','Asima','Azra','Belma','Benjamin','Berina','Besim','Biljana','Bojan','Boris','Branko','Damir','Danijela','Dario','Davor','Denis','Dženan','Dženita','Edin','Elma','Elmin','Elvira','Emir','Emina','Enis','Esma','Faris','Fatima','Ferid','Fikret','Goran','Hana','Harun','Hasna','Husein','Ibrahim','Ilda','Ilhana','Irfan','Irma','Ivan','Ivana','Jasmin','Jasmina','Jelena','Josip','Kenan','Lamija','Lejla','Luka','Mahir','Maja','Marija','Marko','Matej','Melisa','Merima','Milan','Milena','Mirnes','Mirsad','Muhamed','Munira','Mustafa','Nada','Nadir','Nela','Nemanja','Neven','Nihada','Nikola','Nina','Omar','Petra','Ramiz','Sabina','Safet','Samira','Sanja','Sara','Senad','Sanela','Stefan','Suad','Tarik','Vedrana','Vildana','Zoran','Zuhra','Željko'])
        [floor(random() * 100 + 1)::int] AS first_name,
    (ARRAY['Adžić','Alagić','Alić','Avdić','Babić','Bajić','Bajramović','Balić','Bašić','Bećirović','Begić','Bešić','Bilić','Bjelić','Bogić','Bojić','Bošnjak','Brkić','Budimir','Bulić','Čaušević','Čengić','Čolak','Ćosić','Ćurić','Delić','Dizdarević','Djurić','Dedić','Dolić','Dragić','Džaferović','Džafić','Džidić','Efendić','Fetahović','Filipović','Galić','Gazić','Grbić','Hadžić','Halilović','Hasić','Herceg','Hodžić','Hrustić','Hukić','Huskić','Ibišević','Ilić','Imamović','Isaković','Ivanović','Jakić','Jelić','Jovanović','Jusić','Kadić','Kahrimanović','Kalajdžić','Kamberović','Kapić','Karahasanović','Karić','Kovačević','Kovačić','Krasnić','Kukić','Lukić','Makić','Malić','Marić','Marković','Martinović','Memić','Mešić','Milić','Mujagić','Mujić','Muratović','Musić','Nikić','Novaković','Omerović','Osmanović','Pavić','Perić','Petrović','Popović','Ramić','Redžić','Rizvić','Salihović','Selimović','Sinanović','Spahić','Stanić','Tadić','Topić','Zukić'])
        [floor(random() * 100 + 1)::int] AS last_name,
    (date '1970-01-01' + (floor(random() * 10957)) * interval '1 day')::date AS date_of_birth,
    lower(
        (ARRAY['Adis','Aida','Ajdin','Ajla','Aldin','Alma','Amar','Amila','Anel','Anisa','Armin','Asima','Azra','Belma','Benjamin','Berina','Besim','Biljana','Bojan','Boris','Branko','Damir','Danijela','Dario','Davor','Denis','Dženan','Dženita','Edin','Elma','Elmin','Elvira','Emir','Emina','Enis','Esma','Faris','Fatima','Ferid','Fikret','Goran','Hana','Harun','Hasna','Husein','Ibrahim','Ilda','Ilhana','Irfan','Irma','Ivan','Ivana','Jasmin','Jasmina','Jelena','Josip','Kenan','Lamija','Lejla','Luka','Mahir','Maja','Marija','Marko','Matej','Melisa','Merima','Milan','Milena','Mirnes','Mirsad','Muhamed','Munira','Mustafa','Nada','Nadir','Nela','Nemanja','Neven','Nihada','Nikola','Nina','Omar','Petra','Ramiz','Sabina','Safet','Samira','Sanja','Sara','Senad','Sanela','Stefan','Suad','Tarik','Vedrana','Vildana','Zoran','Zuhra','Željko'])
            [floor(random() * 100 + 1)::int]
        || '.' ||
        (ARRAY['Adžić','Alagić','Alić','Avdić','Babić','Bajić','Bajramović','Balić','Bašić','Bećirović','Begić','Bešić','Bilić','Bjelić','Bogić','Bojić','Bošnjak','Brkić','Budimir','Bulić','Čaušević','Čengić','Čolak','Ćosić','Ćurić','Delić','Dizdarević','Djurić','Dedić','Dolić','Dragić','Džaferović','Džafić','Džidić','Efendić','Fetahović','Filipović','Galić','Gazić','Grbić','Hadžić','Halilović','Hasić','Herceg','Hodžić','Hrustić','Hukić','Huskić','Ibišević','Ilić','Imamović','Isaković','Ivanović','Jakić','Jelić','Jovanović','Jusić','Kadić','Kahrimanović','Kalajdžić','Kamberović','Kapić','Karahasanović','Karić','Kovačević','Kovačić','Krasnić','Kukić','Lukić','Makić','Malić','Marić','Marković','Martinović','Memić','Mešić','Milić','Mujagić','Mujić','Muratović','Musić','Nikić','Novaković','Omerović','Osmanović','Pavić','Perić','Petrović','Popović','Ramić','Redžić','Rizvić','Salihović','Selimović','Sinanović','Spahić','Stanić','Tadić','Topić','Zukić'])
            [floor(random() * 100 + 1)::int]
    ) || '@primjer.com' AS email,
    '00387' || lpad((floor(random() * 9000000 + 1000000)::text), 7, '0') AS phone,
    (SELECT household_id FROM households ORDER BY household_id LIMIT 1 OFFSET ((s.i - 1) % (SELECT COUNT(*) FROM households)))
FROM generate_series(1, 200) AS s(i);
-- Removed ON CONFLICT: Assumes citizen_id is auto-incrementing, and email uniqueness isn’t enforced.

-- 4. INSERT 10 CITY SERVICES
INSERT INTO city_services (service_name, description)
VALUES
    ('Odvoz otpada', 'Redovan odvoz kućnog otpada'),
    ('Ulična rasvjeta', 'Održavanje i popravak ulične rasvjete'),
    ('Održavanje puteva', 'Popravke i održavanje puteva i mostova'),
    ('Opskrba vodom', 'Osiguranje i održavanje vodovodne mreže'),
    ('Kanalizacija', 'Upravljanje otpadnim vodama i kanalizacijski sistemi'),
    ('Javni prevoz', 'Upravljanje autobusima i ostalim oblicima javnog prevoza'),
    ('Održavanje parkova', 'Održavanje parkova i zelenih površina'),
    ('Bibliotečke usluge', 'Upravljanje javnim bibliotekama i usluge posudbe'),
    ('Hitne službe', 'Pružanje vatrogasnih, policijskih i hitnih medicinskih usluga'),
    ('Komunitarna policija', 'Suradnja između policije i zajednice');
-- Removed ON CONFLICT: service_name is likely unique, or service_id is auto-incrementing.

-- 5. INSERT 200 SERVICE REQUESTS (one per citizen)

-- Fixed syntax errors (200e_id, LIMIT ), removed ON CONFLICT due to missing constraint.

INSERT INTO service_requests (citizen_id, service_id, request_date, description, status)
SELECT
    c.citizen_id,
    cs.service_id,
    CURRENT_DATE - (interval '1 day' * floor(random() * 60)),
    'Zahtjev od građanina ' || c.citizen_id || ' za uslugu ' || cs.service_name,
    (ARRAY['open', 'in_progress', 'closed'])[floor(random() * 3 + 1)::int]
FROM citizens c
CROSS JOIN (SELECT service_id, service_name FROM city_services ORDER BY random() LIMIT 1) cs
WHERE c.citizen_id <= 200;
-- Removed ON CONFLICT: No unique constraint on (citizen_id, service_id) assumed.

-- 6. INSERT 200 CITIZEN FEEDBACK ENTRIES
-- Each feedback references a city service.
INSERT INTO citizen_feedback (citizen_id, service_id, subject, description, rating, feedback_date)
SELECT
    c.citizen_id,
    cs.service_id,
    'Povratna informacija za uslugu ' || cs.service_name,
    'Povratna informacija od građanina ' || c.citizen_id,
    floor(random() * 5 + 1)::int,
    CURRENT_DATE - (interval '1 day' * floor(random() * 30))
FROM citizens c
CROSS JOIN (SELECT service_id, service_name FROM city_services ORDER BY random() LIMIT 1) cs
WHERE c.citizen_id <= 200;
-- Removed ON CONFLICT: No unique constraint assumed.

-- 7. INSERT 30 CITIZEN CLUBS
INSERT INTO citizen_clubs (name, description)
SELECT
    'Klub ' || s.i,
    'Opis Kluba ' || s.i
FROM generate_series(1, 30) AS s(i);
-- Removed ON CONFLICT: Assumes club_id is auto-incrementing.

-- 8. INSERT CLUB MEMBERSHIPS
-- Each citizen is randomly assigned to one club.
INSERT INTO citizen_club_members (club_id, citizen_id, join_date)
SELECT
    (SELECT club_id FROM citizen_clubs ORDER BY random() LIMIT 1),
    c.citizen_id,
    CURRENT_DATE - (interval '1 day' * floor(random() * 365))
FROM citizens c
WHERE c.citizen_id <= 200;
-- Removed ON CONFLICT: No unique constraint on (citizen_id, club_id) assumed.

-- 9. INSERT 30 VENUES, each linked to an address
INSERT INTO venues (name, address_id, capacity)
SELECT
    'Lokacija ' || s.i,
    (SELECT address_id FROM addresses ORDER BY random() LIMIT 1),
    floor(random() * 300 + 100)::int AS capacity
FROM generate_series(1, 30) AS s(i);
-- Removed ON CONFLICT: Assumes venue_id is auto-incrementing.

-- 10. INSERT 30 COMMUNITY EVENTS (one per venue)
INSERT INTO community_events (event_name, description, event_date, venue_id)
SELECT
    'Događaj na lokaciji ' || v.venue_id,
    'Zajednički događaj na lokaciji ' || v.venue_id,
    CURRENT_DATE + (interval '1 day' * floor(random() * 60)),
    v.venue_id
FROM venues v
WHERE v.venue_id <= 30;
-- Removed ON CONFLICT: Assumes event_id is auto-incrementing.
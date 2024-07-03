CREATE TABLE parents (
    id_parent BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL, 
    surname VARCHAR(50) NOT NULL,
    email_adress VARCHAR(50) NOT NULL
);

CREATE TABLE students(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    id_parent BIGINT REFERENCES parents(id_parent),
    name VARCHAR(50) NOT NULL, 
    surname VARCHAR(50) NOT NULL,
    email_adress VARCHAR(50) NOT NULL
);


CREATE TABLE refill_balances (
    student_id BIGINT REFERENCES students(id),
    balance integer DEFAULT 0,
    time_change  timestamp NOT NULL
);
CREATE TABLE subjects (
    subject_name VARCHAR(50) NOT NULL PRIMARY KEY
);

CREATE TABLE tutors (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    email_adress VARCHAR(50) NOT NULL
);

CREATE TABLE cost (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    id_tutor INTEGER REFERENCES tutors(id),
    subject VARCHAR(50) REFERENCES subjects(subject_name),
    cost integer NOT NULL
);
CREATE TABLE lessons (
   id SERIAL PRIMARY KEY, 
   fk_student BIGINT REFERENCES students(id), 
   fk_tutor BIGINT REFERENCES tutors(id), 
   start_time  timestamp check(end_time > start_time) NOT NULL, 
   end_time  timestamp check(end_time > start_time) NOT NULL, 
   subject VARCHAR(50) REFERENCES subjects(subject_name),
   homework TEXT
);
CREATE TABLE transactions (
    fk_lesson INTEGER REFERENCES lessons(id),
    paid_status BOOLEAN
);
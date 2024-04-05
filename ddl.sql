CREATE TABLE parents (
    id_parent BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL, 
    surname VARCHAR(50) NOT NULL,
    email_adress VARCHAR(50) NOT NULL
);

CREATE TABLE students(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    id_parent INTEGER REFERENCES parents(id_parent),
    name VARCHAR(50) NOT NULL, 
    surname VARCHAR(50) NOT NULL,
    email_adress VARCHAR(50) NOT NULL
);


CREATE TABLE refill_balances (
    student_id INTEGER REFERENCES students(id),
    balance integer DEFAULT 0,
    time_change  timestamp NOT NULL
);
CREATE TABLE subjects (
    id SERIAL NOT NULL PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL
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
    subject_id INTEGER REFERENCES subjects(id),
    cost integer NOT NULL
);
CREATE TABLE lessons (
   id SERIAL PRIMARY KEY, 
   fk_student INTEGER REFERENCES students(id), 
   fk_tutor INTEGER REFERENCES tutors(id), 
   start_time  timestamp NOT NULL, 
   end_time  timestamp NOT NULL, 
   homework TEXT
);
CREATE TABLE transactions (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    fk_lesson INTEGER REFERENCES lessons(id),
    paid_status BOOLEAN
);
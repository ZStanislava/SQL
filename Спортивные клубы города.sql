-- Создаем базу данных
CREATE DATABASE sport_club_db;
-- Создаем таблицу "Владельцы Клубов"
CREATE TABLE ClubOwners (
    owner_id SERIAL PRIMARY KEY,
    owner_surname VARCHAR(50) NOT NULL,
    owner_name VARCHAR(50) NOT NULL,
    owner_patronymic VARCHAR(50) NOT NULL,
    owner_birthday DATE CHECK (owner_birthday >= '1900-01-01'),
    owner_gender CHAR(1) NOT NULL,
    owner_phonenumber CHAR(11),
    owner_email VARCHAR(50)
);


-- Создаем таблицу "Спортивные Клубы"
CREATE TABLE SportsClubs (
    club_id SERIAL PRIMARY KEY,
    club_name VARCHAR(255) NOT NULL,
    club_foundationyear INTEGER,
    club_type VARCHAR(50),
    club_website TEXT,
    club_address VARCHAR(255),
    club_phonenumber CHAR(11),
    club_owner_id INTEGER,
    FOREIGN KEY (club_owner_id) REFERENCES ClubOwners(owner_id)
);


-- Создаем таблицу "Тренеры"
CREATE TABLE Coaches (
    coach_id SERIAL PRIMARY KEY,
    coach_surname VARCHAR(50),
    coach_name VARCHAR(50),
    coach_patronymic VARCHAR(50),
    coach_birthday DATE CHECK (coach_birthday >= '1900-01-01'),
    coach_gender CHAR(1),
    coach_phonenumber CHAR(11),
    coach_email VARCHAR(50),
    coach_club_id INTEGER NULL,
    FOREIGN KEY (coach_club_id) REFERENCES SportsClubs(club_id)
);

-- Создаем таблицу "Участники"
CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    member_surname VARCHAR(50),
    member_name VARCHAR(50),
    member_patronymic VARCHAR(50),
    member_birthday DATE CHECK (member_birthday >= '1900-01-01'),
    member_gender CHAR(1),
    member_phonenumber CHAR(11),
    member_email VARCHAR(50),
    member_owner BOOLEAN
);
-- Создаем таблицу "Тренировки"
CREATE TABLE Trainings (
    training_id SERIAL PRIMARY KEY,
    coach_id INTEGER,
    training_date DATE,
    training_time TIME,
    training_location VARCHAR(255),
    training_type VARCHAR(50)
);


-- Создаем таблицу "Записи на Тренировки"
CREATE TABLE TrainingRegistrations (
    member_id INTEGER,
    training_id INTEGER,
    date_id SERIAL,
    training_date DATE,
    training_time TIME,
    PRIMARY KEY (member_id, training_id),  -- Составной первичный ключ
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (training_id) REFERENCES Trainings(training_id)
);
-- Создаем таблицу "Типы тренировок"

CREATE TABLE TrainingTypes (
    training_type_id INT PRIMARY KEY,
    training_type_name VARCHAR(50),
    description TEXT,
    FOREIGN KEY (training_type_id) REFERENCES Trainings(training_id)
);


-- Заполняем таблицу "Владельцы Клубов"
INSERT INTO ClubOwners (owner_surname, owner_name, owner_patronymic, owner_birthday, owner_gender, owner_phonenumber, owner_email)
VALUES
    ('Иванов', 'Иван', 'Иванович', '1990-03-15', 'М', '89123456789', 'ivanov@mail.ru'),
    ('Петров', 'Петр', 'Петрович', '1985-06-20', 'М', '89234567890', 'petrov@mail.ru'),
    ('Сидорова', 'Анна', 'Алексеевна', '1980-10-05', 'Ж', '89345678901', 'sidorova@mail.ru');
-- Заполняем таблицу "Спортивные Клубы"
INSERT INTO SportsClubs (club_name, club_foundationyear, club_type, club_website, club_address, club_phonenumber, club_owner_id)
VALUES
    ('Клуб "СпортПро"', 2000, 'Фитнес', 'www.sportproclub.com', 'ул. Ленина, 123', '89123456789', 1),
    ('Клуб "ФитнесЛайф"', 1995, 'Фитнес', 'www.fitnesslifeclub.com', 'пр. Спортивный, 45', '89234567890', 2),
    ('Клуб "ПауэрХаус"', 1998, 'Бодибилдинг', 'www.powerhouseclub.com', 'ул. Тренировочная, 67', '89345678901', 1),
    ('Клуб "СпортМастер"', 2005, 'Фитнес', 'www.sportmasterclub.com', 'пр. Физкультурный, 32', '89456789012', 3);
-- Заполняем таблицу "Участники"
INSERT INTO Members (member_surname, member_name, member_patronymic, member_birthday, member_gender, member_phonenumber, member_email)
VALUES
    ('Смирнов', 'Иван', 'Александрович', '1995-01-22', 'М', '89123456789', 'smirnov@mail.ru'),
    ('Петрова', 'Мария', 'Ивановна', '1998-06-15', 'Ж', '89234567890', 'petrova@mail.ru'),
    ('Козлов', 'Андрей', 'Сергеевич', '2000-11-02', 'М', '89345678901', 'kozlov@mail.ru');


-- Заполняем таблицу "Тренировки"
INSERT INTO Trainings (coach_id, training_date, training_time, training_location, training_type)
VALUES
    (1, '2023-10-23', '15:00:00', 'ул. Спортивная, 123', 'Фитнес'),
    (2, '2023-10-24', '16:30:00', 'пр. Мощи, 45', 'Бодибилдинг'),
    (1, '2023-10-25', '14:00:00', 'ул. Спортивная, 123', 'Фитнес'),
    (2, '2023-10-26', '18:00:00', 'пр. Мощи, 45', 'Бодибилдинг');

-- Заполняем таблицу "Тренеры"
INSERT INTO Coaches (coach_surname, coach_name, coach_patronymic, coach_birthday, coach_gender, coach_phonenumber, coach_email, coach_club_id)
VALUES
    ('Тренеров', 'Тренер', 'Тренерович', '1975-08-12', 'М', '89123456789', 'coach1@mail.ru', 1),
    ('Спортов', 'Спорт', 'Спортович', '1982-05-25', 'М', '89234567890', 'coach2@mail.ru', 2),
    ('Фитнесова', 'Фитнес', 'Фитнесовна', '1990-12-10', 'Ж', '89345678901', 'coach3@mail.ru',1);

-- Обновляем таблицу "Записи на Тренировки"(нужно для следующего заполнения -см ниже)
ALTER TABLE TrainingRegistrations
ADD COLUMN coach_id INTEGER,
ADD CONSTRAINT fk_coach_id
    FOREIGN KEY (coach_id) REFERENCES Coaches(coach_id);
-- Заполняем таблицу "Записи на Тренировки"
INSERT INTO TrainingRegistrations (member_id, coach_id, training_date, training_time, training_id)
VALUES
    (1, 1, '2023-10-23', '15:00:00', 1),
    (2, 2, '2023-10-24', '16:30:00', 2),
    (1, 2, '2023-10-25', '14:00:00', 3),
    (2, 1, '2023-10-26', '18:00:00', 4);
-- Заполняем таблицу " Типы тренировок "
INSERT INTO TrainingTypes (training_type_id, training_type_name, description)
VALUES
    (1, 'Аэробика', 'Групповая тренировка с акцентом на аэробных упражнениях.'),
    (2, 'Силовые тренировки', 'Тренировки для укрепления мышц и развития силы.'),
    (3, 'Йога', 'Уроки йоги для улучшения физического и психического здоровья.'),
    -- Добавьте другие типы тренировок
    (4, 'Танцы', 'Уроки танцевальной аэробики и хореографии.');

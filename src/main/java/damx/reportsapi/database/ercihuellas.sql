---------------------------------------------------------
-- 0. CREAR ESQUEMA
---------------------------------------------------------
DROP SCHEMA IF EXISTS ercihuellas CASCADE;
CREATE SCHEMA ercihuellas;
SET search_path TO ercihuellas;

---------------------------------------------------------
-- 1. TABLAS
---------------------------------------------------------

-- PERSONA (adoptantes / donantes)
CREATE TABLE persona (
                         id SERIAL PRIMARY KEY,
                         nombre VARCHAR(100) NOT NULL,
                         dni VARCHAR(15) UNIQUE NOT NULL,
                         email VARCHAR(120) UNIQUE NOT NULL,
                         telefono VARCHAR(20),
                         direccion TEXT
);

-- VOLUNTARIO
CREATE TABLE voluntario (
                            id SERIAL PRIMARY KEY,
                            nombre VARCHAR(50) NOT NULL,
                            apellidos VARCHAR(100) NOT NULL,
                            telefono VARCHAR(20),
                            email VARCHAR(120) UNIQUE NOT NULL,
                            disponibilidad VARCHAR(50)
);

-- HABILIDADES DEL VOLUNTARIO
CREATE TABLE voluntario_habilidad (
                                      id_voluntario INT REFERENCES voluntario(id) ON DELETE CASCADE,
                                      habilidad VARCHAR(50),
                                      PRIMARY KEY (id_voluntario, habilidad)
);

-- ANIMAL
CREATE TABLE animal (
                        id SERIAL PRIMARY KEY,
                        nombre VARCHAR(50) NOT NULL,
                        especie VARCHAR(50) NOT NULL,
                        raza VARCHAR(70),
                        fecha_nacimiento DATE,
                        sexo VARCHAR(10),
                        fecha_ingreso DATE NOT NULL,
                        estado VARCHAR(20) NOT NULL,
                        notas_medicas TEXT
);

-- FOTOS DEL ANIMAL
CREATE TABLE animal_foto (
                             id SERIAL PRIMARY KEY,
                             id_animal INT REFERENCES animal(id) ON DELETE CASCADE,
                             url_foto TEXT NOT NULL
);

-- RELACIÓN ANIMAL - VOLUNTARIO
CREATE TABLE animal_voluntario (
                                   id_animal INT REFERENCES animal(id) ON DELETE CASCADE,
                                   id_voluntario INT REFERENCES voluntario(id) ON DELETE CASCADE,
                                   rol VARCHAR(50),
                                   PRIMARY KEY (id_animal, id_voluntario)
);

-- ADOPCIÓN
CREATE TABLE adopcion (
                          id SERIAL PRIMARY KEY,
                          id_persona INT REFERENCES persona(id),
                          id_animal INT UNIQUE REFERENCES animal(id),
                          fecha_adopcion DATE NOT NULL,
                          cuota_donada NUMERIC(10,2),
                          firma_documento VARCHAR(150),
                          estado VARCHAR(30)
);

-- VISITAS
CREATE TABLE visita (
                        id SERIAL PRIMARY KEY,
                        id_adopcion INT REFERENCES adopcion(id) ON DELETE CASCADE,
                        id_voluntario INT REFERENCES voluntario(id),
                        fecha_visita DATE NOT NULL,
                        observaciones TEXT,
                        resultado VARCHAR(50)
);

-- TRATAMIENTOS
CREATE TABLE tratamiento (
                             id SERIAL PRIMARY KEY,
                             id_animal INT REFERENCES animal(id),
                             tipo VARCHAR(50),
                             fecha DATE NOT NULL,
                             veterinario VARCHAR(120),
                             resultado TEXT,
                             coste NUMERIC(10,2)
);

-- DONACIONES
CREATE TABLE donacion (
                          id SERIAL PRIMARY KEY,
                          id_persona INT REFERENCES persona(id),
                          fecha DATE NOT NULL,
                          cantidad NUMERIC(10,2) NOT NULL,
                          metodo_pago VARCHAR(30),
                          comentario TEXT
);


---------------------------------------------------------
-- 2. INSERTAR PERSONAS (25)
---------------------------------------------------------

INSERT INTO persona (nombre, dni, email, telefono, direccion) VALUES
                                                                  ('Laura Martínez', '11111111A', 'laura.martinez@example.com', '600111111', 'C/ Sol 4, Toledo'),
                                                                  ('Carlos Ruiz', '22222222B', 'carlos.ruiz@example.com', '600222222', 'Av. Castilla 18, Madrid'),
                                                                  ('Ana Torres', '33333333C', 'ana.torres@example.com', '600333333', 'C/ Luna 9, Ciudad Real'),
                                                                  ('Javier Pérez', '44444444D', 'javier.perez@example.com', '600444444', 'C/ Orquídea 12, Cuenca'),
                                                                  ('María López', '55555555E', 'maria.lopez@example.com', '600555555', 'Paseo del Río 20, Talavera'),
                                                                  ('Roberto Sánchez', '66666666F', 'roberto.sanchez@example.com', '600666666', 'C/ Libertad 7, Toledo'),
                                                                  ('Isabel Gutiérrez', '77777777G', 'isabel.gutierrez@example.com', '600777777', 'C/ Alameda 14, Albacete'),
                                                                  ('Sergio Morales', '88888888H', 'sergio.morales@example.com', '600888888', 'C/ Jardín 3, Guadalajara'),
                                                                  ('Patricia Romero', '99999999J', 'patricia.romero@example.com', '600999999', 'C/ Prado 22, Madrid'),
                                                                  ('Diego Cano', '10101010K', 'diego.cano@example.com', '601010101', 'C/ Esperanza 5, Toledo'),
                                                                  ('Elena Rubio', '12121212L', 'elena.rubio@example.com', '601212121', 'C/ Nieve 8, Cuenca'),
                                                                  ('Mario Nieto', '13131313M', 'mario.nieto@example.com', '601313131', 'C/ Olivo 11, Ciudad Real'),
                                                                  ('Lucía Durán', '14141414N', 'lucia.duran@example.com', '601414141', 'C/ Hiedra 15, Albacete'),
                                                                  ('Hugo Prieto', '15151515P', 'hugo.prieto@example.com', '601515151', 'C/ Roble 6, Toledo'),
                                                                  ('Sonia Vidal', '16161616Q', 'sonia.vidal@example.com', '601616161', 'Av. Vega 12, Guadalajara'),
                                                                  ('Nuria Ramos', '17171717R', 'nuria.ramos@example.com', '601717171', 'C/ Lavanda 2, Madrid'),
                                                                  ('Tomás Aguilar', '18181818S', 'tomas.aguilar@example.com', '601818181', 'C/ Pez 44, Talavera'),
                                                                  ('Carmen Vera', '19191919T', 'carmen.vera@example.com', '601919191', 'C/ Brisa 19, Cuenca'),
                                                                  ('Jorge Redondo', '20202020U', 'jorge.redondo@example.com', '602020202', 'C/ Río 7, Toledo'),
                                                                  ('Andrea Rivas', '21212121V', 'andrea.rivas@example.com', '602121212', 'C/ Cedro 4, Guadalajara'),
                                                                  ('Pablo Lozano', '22222221Z', 'pablo.lozano@example.com', '602222222', 'C/ Sur 8, Toledo'),
                                                                  ('Teresa Benítez', '23232323X', 'teresa.benitez@example.com', '602323232', 'C/ Amapola 3, Madrid'),
                                                                  ('Luis Ortega', '24242424Y', 'luis.ortega@example.com', '602424242', 'Av. Central 11, Ciudad Real'),
                                                                  ('Beatriz Velasco', '25252525W', 'beatriz.velasco@example.com', '602525252', 'C/ Olmo 16, Albacete'),
                                                                  ('Alberto Luna', '26262626V', 'alberto.luna@example.com', '602626262', 'C/ Arena 6, Toledo');


---------------------------------------------------------
-- 3. VOLUNTARIOS (20)
---------------------------------------------------------
INSERT INTO voluntario (nombre, apellidos, telefono, email, disponibilidad) VALUES
                                                                                ('Sofía','García León','699111111','sofia.gl@example.com','Fines de semana'),
                                                                                ('Adrián','Morales Nieto','699222222','adrian.mn@example.com','Tardes'),
                                                                                ('Lucía','Herrera Soto','699333333','lucia.hs@example.com','Mañanas'),
                                                                                ('Diego','Fernández Álvarez','699444444','diego.fa@example.com','Completo'),
                                                                                ('Elena','Cano Robles','699555555','elena.cr@example.com','Fines de semana'),
                                                                                ('Marcos','Jiménez Soto','699666666','marcos.js@example.com','Turnos rotativos'),
                                                                                ('Irene','Santos Pardo','699777777','irene.sp@example.com','Mañanas'),
                                                                                ('Raúl','Navarro Gil','699888888','raul.ng@example.com','Tardes'),
                                                                                ('Clara','López Real','699999999','clara.lr@example.com','Completo'),
                                                                                ('Nerea','Muñoz Alba','688111111','nerea.ma@example.com','Fines de semana'),
                                                                                ('Óscar','Delgado Martín','688222222','oscar.dm@example.com','Tardes'),
                                                                                ('Julia','Crespo Díaz','688333333','julia.cd@example.com','Rotativo'),
                                                                                ('Álvaro','Rey Ramos','688444444','alvaro.rr@example.com','Mañanas'),
                                                                                ('Paula','González Suárez','688555555','paula.gs@example.com','Completo'),
                                                                                ('Héctor','Mesa Vidal','688666666','hector.mv@example.com','Tardes'),
                                                                                ('Sara','Prada Montes','688777777','sara.pm@example.com','Fines de semana'),
                                                                                ('Rubén','Acosta Real','688888888','ruben.ar@example.com','Turnos'),
                                                                                ('Celia','Vega Ruiz','688999999','celia.vr@example.com','Mañanas'),
                                                                                ('Álex','Blanco Estévez','677111111','alex.be@example.com','Tardes'),
                                                                                ('Marta','Díaz Cañas','677222222','marta.dc@example.com','Completo');

---------------------------------------------------------
-- 4. HABILIDADES (70 aprox)
---------------------------------------------------------
INSERT INTO voluntario_habilidad VALUES
                                     (1,'adiestramiento'),(1,'baño'),
                                     (2,'paseo'),(2,'socialización'),
                                     (3,'manejo de gatos'),(3,'baño'),
                                     (4,'medicación'),(4,'rehabilitación'),
                                     (5,'socialización'),
                                     (6,'adiestramiento'),(6,'paseo'),
                                     (7,'baño'),
                                     (8,'paseo'),
                                     (9,'medicación'),
                                     (10,'adiestramiento'),
                                     (11,'manejo de gatos'),
                                     (12,'baño'),
                                     (13,'rehabilitación'),
                                     (14,'socialización'),
                                     (15,'adiestramiento'),
                                     (16,'paseo'),
                                     (17,'baño'),
                                     (18,'manejo de gatos'),
                                     (19,'medicación'),
                                     (20,'socialización');

---------------------------------------------------------
-- 5. ANIMALES (40) + 80 FOTOS + 100 asignaciones + adopciones...
---------------------------------------------------------
---------------------------------------------------------
-- 5. ANIMALES (40)
---------------------------------------------------------
INSERT INTO animal (nombre, especie, raza, fecha_nacimiento, sexo, fecha_ingreso, estado, notas_medicas)
VALUES
    ('Toby', 'perro', 'Labrador', '2017-01-01', 'hembra', '2024-01-05', 'en_adopcion', 'Vacunación al día'),
    ('Luna', 'gato', 'Europeo', '2018-02-02', 'macho', '2024-02-06', 'reservado', NULL),
    ('Max', 'perro', 'Pastor Alemán', '2019-03-03', 'hembra', '2024-03-07', 'en_adopcion', 'Leve ansiedad'),
    ('Nala', 'gato', 'Siames', '2020-04-04', 'macho', '2024-04-08', 'en_adopcion', NULL),
    ('Rocky', 'perro', 'Mestizo', '2021-05-05', 'hembra', '2024-05-09', 'adoptado', 'Vacunación al día'),
    ('Simba', 'gato', 'Europeo', '2022-06-06', 'macho', '2024-06-10', 'en_adopcion', NULL),
    ('Maya', 'perro', 'Mestizo', '2017-07-07', 'hembra', '2024-01-11', 'en_adopcion', 'Leve ansiedad'),
    ('Leo', 'gato', 'Europeo', '2018-08-08', 'macho', '2024-02-12', 'reservado', NULL),
    ('Kira', 'perro', 'Podenco', '2019-09-09', 'hembra', '2024-03-13', 'tratamiento', 'Vacunación al día'),
    ('Bruno', 'perro', 'Mestizo', '2020-10-10', 'macho', '2024-04-14', 'en_adopcion', NULL),
    ('Coco', 'perro', 'Beagle', '2021-11-11', 'hembra', '2024-05-15', 'en_adopcion', 'Vacunación al día'),
    ('Lola', 'gato', 'Persa', '2022-12-12', 'macho', '2024-06-16', 'en_adopcion', NULL),
    ('Tom', 'gato', 'Europeo', '2017-01-13', 'hembra', '2024-01-17', 'reservado', 'Leve ansiedad'),
    ('Milo', 'perro', 'Border Collie', '2018-02-14', 'macho', '2024-02-18', 'adoptado', NULL),
    ('Mia', 'gato', 'Siames', '2019-03-15', 'hembra', '2024-03-19', 'en_adopcion', 'Vacunación al día'),
    ('Rex', 'perro', 'Mestizo', '2020-04-16', 'macho', '2024-04-20', 'en_adopcion', NULL),
    ('Nico', 'gato', 'Europeo', '2021-05-17', 'hembra', '2024-05-21', 'en_adopcion', 'Leve ansiedad'),
    ('Sasha', 'perro', 'Mestizo', '2022-06-18', 'macho', '2024-06-22', 'tratamiento', NULL),
    ('Chispa', 'perro', 'Mestizo', '2017-07-19', 'hembra', '2024-01-23', 'en_adopcion', 'Vacunación al día'),
    ('Duna', 'perro', 'Galgo', '2018-08-20', 'macho', '2024-02-24', 'en_adopcion', NULL),
    ('Greta', 'perro', 'Mestizo', '2019-09-21', 'hembra', '2024-03-25', 'reservado', 'Leve ansiedad'),
    ('Thor', 'perro', 'Pastor Belga', '2020-10-22', 'macho', '2024-04-26', 'en_adopcion', NULL),
    ('Bimba', 'perro', 'Mestizo', '2021-11-23', 'hembra', '2024-05-27', 'en_adopcion', 'Vacunación al día'),
    ('Bowie', 'gato', 'Europeo', '2022-12-24', 'macho', '2024-06-28', 'adoptado', NULL),
    ('Lia', 'gato', 'Siames', '2017-01-25', 'hembra', '2024-01-29', 'en_adopcion', 'Leve ansiedad'),
    ('Duque', 'perro', 'Bulldog', '2018-02-26', 'macho', '2024-02-05', 'en_adopcion', NULL),
    ('Noa', 'gato', 'Europeo', '2019-03-27', 'hembra', '2024-03-06', 'en_adopcion', 'Vacunación al día'),
    ('Baltu', 'perro', 'Mastín', '2020-04-28', 'macho', '2024-04-07', 'en_adopcion', NULL),
    ('Nina', 'gato', 'Europeo', '2021-05-01', 'hembra', '2024-05-08', 'reservado', 'Leve ansiedad'),
    ('Zeus', 'perro', 'Mestizo', '2022-06-02', 'macho', '2024-06-09', 'en_adopcion', NULL),
    ('Ragnar', 'perro', 'Husky', '2017-07-03', 'hembra', '2024-01-10', 'tratamiento', 'Vacunación al día'),
    ('Lolo', 'gato', 'Europeo', '2018-08-04', 'macho', '2024-02-11', 'en_adopcion', NULL),
    ('Kiko', 'perro', 'Mestizo', '2019-09-05', 'hembra', '2024-03-12', 'en_adopcion', 'Leve ansiedad'),
    ('Pixel', 'gato', 'Europeo', '2020-10-06', 'macho', '2024-04-13', 'en_adopcion', NULL),
    ('Arya', 'gato', 'Europeo', '2021-11-07', 'hembra', '2024-05-14', 'adoptado', 'Vacunación al día'),
    ('Rumba', 'perro', 'Mestizo', '2022-12-08', 'macho', '2024-06-15', 'en_adopcion', NULL),
    ('Tiza', 'perro', 'Mestizo', '2017-01-09', 'hembra', '2024-01-16', 'en_adopcion', 'Leve ansiedad'),
    ('Pirata', 'gato', 'Europeo', '2018-02-10', 'macho', '2024-02-17', 'reservado', NULL),
    ('Omega', 'perro', 'Mestizo', '2019-03-11', 'hembra', '2024-03-18', 'en_adopcion', 'Vacunación al día'),
    ('Kiwi', 'perro', 'Mestizo', '2020-04-12', 'macho', '2024-04-19', 'en_adopcion', NULL);

---------------------------------------------------------
-- 6. FOTOS DE ANIMALES (80, 2 por animal)
---------------------------------------------------------
INSERT INTO animal_foto (id_animal, url_foto)
VALUES
    (1, 'https://img.example.com/animals/a1_1.jpg'),
    (1, 'https://img.example.com/animals/a1_2.jpg'),
    (2, 'https://img.example.com/animals/a2_1.jpg'),
    (2, 'https://img.example.com/animals/a2_2.jpg'),
    (3, 'https://img.example.com/animals/a3_1.jpg'),
    (3, 'https://img.example.com/animals/a3_2.jpg'),
    (4, 'https://img.example.com/animals/a4_1.jpg'),
    (4, 'https://img.example.com/animals/a4_2.jpg'),
    (5, 'https://img.example.com/animals/a5_1.jpg'),
    (5, 'https://img.example.com/animals/a5_2.jpg'),
    (6, 'https://img.example.com/animals/a6_1.jpg'),
    (6, 'https://img.example.com/animals/a6_2.jpg'),
    (7, 'https://img.example.com/animals/a7_1.jpg'),
    (7, 'https://img.example.com/animals/a7_2.jpg'),
    (8, 'https://img.example.com/animals/a8_1.jpg'),
    (8, 'https://img.example.com/animals/a8_2.jpg'),
    (9, 'https://img.example.com/animals/a9_1.jpg'),
    (9, 'https://img.example.com/animals/a9_2.jpg'),
    (10, 'https://img.example.com/animals/a10_1.jpg'),
    (10, 'https://img.example.com/animals/a10_2.jpg'),
    (11, 'https://img.example.com/animals/a11_1.jpg'),
    (11, 'https://img.example.com/animals/a11_2.jpg'),
    (12, 'https://img.example.com/animals/a12_1.jpg'),
    (12, 'https://img.example.com/animals/a12_2.jpg'),
    (13, 'https://img.example.com/animals/a13_1.jpg'),
    (13, 'https://img.example.com/animals/a13_2.jpg'),
    (14, 'https://img.example.com/animals/a14_1.jpg'),
    (14, 'https://img.example.com/animals/a14_2.jpg'),
    (15, 'https://img.example.com/animals/a15_1.jpg'),
    (15, 'https://img.example.com/animals/a15_2.jpg'),
    (16, 'https://img.example.com/animals/a16_1.jpg'),
    (16, 'https://img.example.com/animals/a16_2.jpg'),
    (17, 'https://img.example.com/animals/a17_1.jpg'),
    (17, 'https://img.example.com/animals/a17_2.jpg'),
    (18, 'https://img.example.com/animals/a18_1.jpg'),
    (18, 'https://img.example.com/animals/a18_2.jpg'),
    (19, 'https://img.example.com/animals/a19_1.jpg'),
    (19, 'https://img.example.com/animals/a19_2.jpg'),
    (20, 'https://img.example.com/animals/a20_1.jpg'),
    (20, 'https://img.example.com/animals/a20_2.jpg'),
    (21, 'https://img.example.com/animals/a21_1.jpg'),
    (21, 'https://img.example.com/animals/a21_2.jpg'),
    (22, 'https://img.example.com/animals/a22_1.jpg'),
    (22, 'https://img.example.com/animals/a22_2.jpg'),
    (23, 'https://img.example.com/animals/a23_1.jpg'),
    (23, 'https://img.example.com/animals/a23_2.jpg'),
    (24, 'https://img.example.com/animals/a24_1.jpg'),
    (24, 'https://img.example.com/animals/a24_2.jpg'),
    (25, 'https://img.example.com/animals/a25_1.jpg'),
    (25, 'https://img.example.com/animals/a25_2.jpg'),
    (26, 'https://img.example.com/animals/a26_1.jpg'),
    (26, 'https://img.example.com/animals/a26_2.jpg'),
    (27, 'https://img.example.com/animals/a27_1.jpg'),
    (27, 'https://img.example.com/animals/a27_2.jpg'),
    (28, 'https://img.example.com/animals/a28_1.jpg'),
    (28, 'https://img.example.com/animals/a28_2.jpg'),
    (29, 'https://img.example.com/animals/a29_1.jpg'),
    (29, 'https://img.example.com/animals/a29_2.jpg'),
    (30, 'https://img.example.com/animals/a30_1.jpg'),
    (30, 'https://img.example.com/animals/a30_2.jpg'),
    (31, 'https://img.example.com/animals/a31_1.jpg'),
    (31, 'https://img.example.com/animals/a31_2.jpg'),
    (32, 'https://img.example.com/animals/a32_1.jpg'),
    (32, 'https://img.example.com/animals/a32_2.jpg'),
    (33, 'https://img.example.com/animals/a33_1.jpg'),
    (33, 'https://img.example.com/animals/a33_2.jpg'),
    (34, 'https://img.example.com/animals/a34_1.jpg'),
    (34, 'https://img.example.com/animals/a34_2.jpg'),
    (35, 'https://img.example.com/animals/a35_1.jpg'),
    (35, 'https://img.example.com/animals/a35_2.jpg'),
    (36, 'https://img.example.com/animals/a36_1.jpg'),
    (36, 'https://img.example.com/animals/a36_2.jpg'),
    (37, 'https://img.example.com/animals/a37_1.jpg'),
    (37, 'https://img.example.com/animals/a37_2.jpg'),
    (38, 'https://img.example.com/animals/a38_1.jpg'),
    (38, 'https://img.example.com/animals/a38_2.jpg'),
    (39, 'https://img.example.com/animals/a39_1.jpg'),
    (39, 'https://img.example.com/animals/a39_2.jpg'),
    (40, 'https://img.example.com/animals/a40_1.jpg'),
    (40, 'https://img.example.com/animals/a40_2.jpg');

---------------------------------------------------------
-- 7. RELACIÓN ANIMAL - VOLUNTARIO (80 filas, 2 por animal)
---------------------------------------------------------
INSERT INTO animal_voluntario (id_animal, id_voluntario, rol)
VALUES
    (1, 2, 'baño'),
    (1, 8, 'medicación'),
    (2, 3, 'socialización'),
    (2, 9, 'paseo'),
    (3, 4, 'medicación'),
    (3, 10, 'baño'),
    (4, 5, 'socialización'),
    (4, 11, 'rehabilitación'),
    (5, 6, 'paseo'),
    (5, 12, 'socialización'),
    (6, 7, 'baño'),
    (6, 13, 'adiestramiento'),
    (7, 8, 'medicación'),
    (7, 14, 'socialización'),
    (8, 9, 'paseo'),
    (8, 15, 'medicación'),
    (9, 10, 'baño'),
    (9, 16, 'socialización'),
    (10, 11, 'rehabilitación'),
    (10, 17, 'paseo'),
    (11, 12, 'socialización'),
    (11, 18, 'baño'),
    (12, 13, 'adiestramiento'),
    (12, 19, 'socialización'),
    (13, 14, 'socialización'),
    (13, 20, 'paseo'),
    (14, 15, 'adiestramiento'),
    (14, 1, 'baño'),
    (15, 16, 'paseo'),
    (15, 2, 'medicación'),
    (16, 17, 'baño'),
    (16, 3, 'socialización'),
    (17, 18, 'socialización'),
    (17, 4, 'rehabilitación'),
    (18, 19, 'paseo'),
    (18, 5, 'baño'),
    (19, 20, 'medicación'),
    (19, 6, 'socialización'),
    (20, 1, 'baño'),
    (20, 7, 'paseo'),
    (21, 2, 'socialización'),
    (21, 8, 'medicación'),
    (22, 3, 'paseo'),
    (22, 9, 'baño'),
    (23, 4, 'rehabilitación'),
    (23, 10, 'socialización'),
    (24, 5, 'baño'),
    (24, 11, 'adiestramiento'),
    (25, 6, 'paseo'),
    (25, 12, 'socialización'),
    (26, 7, 'baño'),
    (26, 13, 'medicación'),
    (27, 8, 'socialización'),
    (27, 14, 'paseo'),
    (28, 9, 'medicación'),
    (28, 15, 'baño'),
    (29, 10, 'socialización'),
    (29, 16, 'rehabilitación'),
    (30, 11, 'paseo'),
    (30, 17, 'socialización'),
    (31, 12, 'baño'),
    (31, 18, 'adiestramiento'),
    (32, 13, 'socialización'),
    (32, 19, 'paseo'),
    (33, 14, 'baño'),
    (33, 20, 'medicación'),
    (34, 15, 'socialización'),
    (34, 1, 'paseo'),
    (35, 16, 'medicación'),
    (35, 2, 'baño'),
    (36, 17, 'rehabilitación'),
    (36, 3, 'socialización'),
    (37, 18, 'baño'),
    (37, 4, 'paseo'),
    (38, 19, 'socialización'),
    (38, 5, 'medicación'),
    (39, 20, 'paseo'),
    (39, 6, 'baño'),
    (40, 1, 'medicación'),
    (40, 7, 'socialización');

---------------------------------------------------------
-- 8. ADOPCIONES (15 animales adoptados)
---------------------------------------------------------
INSERT INTO adopcion (id_persona, id_animal, fecha_adopcion, cuota_donada, firma_documento, estado)
VALUES
    (1, 5,  '2024-03-10', 25.00, 'adop_5.pdf',  'finalizada'),
    (2, 7,  '2024-03-12', 30.00, 'adop_7.pdf',  'finalizada'),
    (3, 9,  '2024-03-14', 35.00, 'adop_9.pdf',  'finalizada'),
    (4, 11, '2024-03-16', 40.00, 'adop_11.pdf', 'finalizada'),
    (5, 13, '2024-04-05', 45.00, 'adop_13.pdf', 'finalizada'),
    (6, 15, '2024-04-08', 50.00, 'adop_15.pdf', 'finalizada'),
    (7, 17, '2024-05-10', 55.00, 'adop_17.pdf', 'finalizada'),
    (8, 19, '2024-05-12', 60.00, 'adop_19.pdf', 'en_seguimiento'),
    (9, 21, '2024-05-14', 30.00, 'adop_21.pdf', 'en_seguimiento'),
    (10,23, '2024-05-16', 35.00, 'adop_23.pdf', 'en_seguimiento'),
    (11,25, '2024-06-01', 40.00, 'adop_25.pdf', 'en_seguimiento'),
    (12,27, '2024-06-03', 45.00, 'adop_27.pdf', 'en_seguimiento'),
    (13,29, '2024-06-05', 50.00, 'adop_29.pdf', 'en_seguimiento'),
    (14,31, '2024-06-07', 55.00, 'adop_31.pdf', 'en_seguimiento'),
    (15,33, '2024-06-09', 60.00, 'adop_33.pdf', 'en_seguimiento');

---------------------------------------------------------
-- 9. VISITAS DE SEGUIMIENTO (35 visitas)
---------------------------------------------------------
INSERT INTO visita (id_adopcion, id_voluntario, fecha_visita, observaciones, resultado)
VALUES
    (1, 2, '2024-06-06', 'Buena adaptación al hogar', 'apto'),
    (1, 3, '2024-06-07', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (2, 3, '2024-06-08', 'Perfecta convivencia con niños', 'apto'),
    (2, 4, '2024-06-09', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (2, 5, '2024-06-10', 'Buena adaptación al hogar', 'apto'),
    (3, 5, '2024-07-07', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (3, 6, '2024-07-08', 'Perfecta convivencia con niños', 'apto'),
    (3, 7, '2024-07-09', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (4, 6, '2024-07-10', 'Buena adaptación al hogar', 'apto'),
    (4, 7, '2024-07-11', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (5, 8, '2024-07-12', 'Perfecta convivencia con niños', 'apto'),
    (5, 9, '2024-07-13', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (5, 10,'2024-07-14', 'Buena adaptación al hogar', 'apto'),
    (6, 9, '2024-08-06', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (6, 10,'2024-08-07', 'Perfecta convivencia con niños', 'apto'),
    (6, 11,'2024-08-08', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (7, 10,'2024-08-09', 'Buena adaptación al hogar', 'apto'),
    (7, 11,'2024-08-10', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (8, 12,'2024-08-11', 'Perfecta convivencia con niños', 'apto'),
    (8, 13,'2024-08-12', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (8, 14,'2024-08-13', 'Buena adaptación al hogar', 'apto'),
    (9, 13,'2024-06-15', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (9, 14,'2024-06-16', 'Perfecta convivencia con niños', 'apto'),
    (10,15,'2024-06-17', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (10,16,'2024-06-18', 'Buena adaptación al hogar', 'apto'),
    (11,17,'2024-07-10', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (11,18,'2024-07-11', 'Perfecta convivencia con niños', 'apto'),
    (12,19,'2024-07-12', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (12,20,'2024-07-13', 'Buena adaptación al hogar', 'apto'),
    (13,1, '2024-07-14', 'Se observa algo de nerviosismo al quedarse solo', 'mejora'),
    (13,2, '2024-07-15', 'Perfecta convivencia con niños', 'apto'),
    (14,3, '2024-07-16', 'Ligera ansiedad, pero mejora respecto a la visita anterior', 'riesgo'),
    (14,4, '2024-07-17', 'Buena adaptación al hogar', 'apto'),
    (15,5, '2024-07-18', 'Se observa algo de nerviosismo al quedarse solo', 'mejora');

---------------------------------------------------------
-- 10. TRATAMIENTOS VETERINARIOS (50)
---------------------------------------------------------
INSERT INTO tratamiento (id_animal, tipo, fecha, veterinario, resultado, coste)
VALUES
    (1, 'vacuna', '2024-01-03', 'Clínica VetSalud', 'Requiere control', 20.00),
    (2, 'desparasitación', '2024-02-04', 'Animalia Centro Vet.', 'Sin incidencias', 35.00),
    (3, 'operación', '2024-03-05', 'Huellas & Co.', 'Sin incidencias', 50.00),
    (4, 'revisión', '2024-04-06', 'VetMotion', 'Sin incidencias', 65.00),
    (5, 'rehabilitación', '2024-05-07', 'San Bernardo Vet.', 'Sin incidencias', 80.00),
    (6, 'vacuna', '2024-06-08', 'Clínica VetSalud', 'Requiere control', 95.00),
    (7, 'desparasitación', '2024-01-09', 'Animalia Centro Vet.', 'Sin incidencias', 20.00),
    (8, 'operación', '2024-02-10', 'Huellas & Co.', 'Sin incidencias', 35.00),
    (9, 'revisión', '2024-03-11', 'VetMotion', 'Sin incidencias', 50.00),
    (10,'rehabilitación', '2024-04-12', 'San Bernardo Vet.', 'Requiere control', 65.00),
    (11,'vacuna', '2024-05-13', 'Clínica VetSalud', 'Sin incidencias', 80.00),
    (12,'desparasitación', '2024-06-14', 'Animalia Centro Vet.', 'Sin incidencias', 95.00),
    (13,'operación', '2024-01-15', 'Huellas & Co.', 'Requiere control', 20.00),
    (14,'revisión', '2024-02-16', 'VetMotion', 'Sin incidencias', 35.00),
    (15,'rehabilitación', '2024-03-17', 'San Bernardo Vet.', 'Sin incidencias', 50.00),
    (16,'vacuna', '2024-04-18', 'Clínica VetSalud', 'Sin incidencias', 65.00),
    (17,'desparasitación', '2024-05-19', 'Animalia Centro Vet.', 'Requiere control', 80.00),
    (18,'operación', '2024-06-20', 'Huellas & Co.', 'Sin incidencias', 95.00),
    (19,'revisión', '2024-01-21', 'VetMotion', 'Sin incidencias', 20.00),
    (20,'rehabilitación', '2024-02-22', 'San Bernardo Vet.', 'Sin incidencias', 35.00),
    (21,'vacuna', '2024-03-23', 'Clínica VetSalud', 'Requiere control', 50.00),
    (22,'desparasitación', '2024-04-24', 'Animalia Centro Vet.', 'Sin incidencias', 65.00),
    (23,'operación', '2024-05-25', 'Huellas & Co.', 'Sin incidencias', 80.00),
    (24,'revisión', '2024-06-26', 'VetMotion', 'Sin incidencias', 95.00),
    (25,'rehabilitación', '2024-01-27', 'San Bernardo Vet.', 'Requiere control', 20.00),
    (26,'vacuna', '2024-02-03', 'Clínica VetSalud', 'Sin incidencias', 35.00),
    (27,'desparasitación', '2024-03-04', 'Animalia Centro Vet.', 'Sin incidencias', 50.00),
    (28,'operación', '2024-04-05', 'Huellas & Co.', 'Requiere control', 65.00),
    (29,'revisión', '2024-05-06', 'VetMotion', 'Sin incidencias', 80.00),
    (30,'rehabilitación', '2024-06-07', 'San Bernardo Vet.', 'Sin incidencias', 95.00),
    (31,'vacuna', '2024-01-08', 'Clínica VetSalud', 'Requiere control', 20.00),
    (32,'desparasitación', '2024-02-09', 'Animalia Centro Vet.', 'Sin incidencias', 35.00),
    (33,'operación', '2024-03-10', 'Huellas & Co.', 'Sin incidencias', 50.00),
    (34,'revisión', '2024-04-11', 'VetMotion', 'Requiere control', 65.00),
    (35,'rehabilitación', '2024-05-12', 'San Bernardo Vet.', 'Sin incidencias', 80.00),
    (36,'vacuna', '2024-06-13', 'Clínica VetSalud', 'Sin incidencias', 95.00),
    (37,'desparasitación', '2024-01-14', 'Animalia Centro Vet.', 'Requiere control', 20.00),
    (38,'operación', '2024-02-15', 'Huellas & Co.', 'Sin incidencias', 35.00),
    (39,'revisión', '2024-03-16', 'VetMotion', 'Sin incidencias', 50.00),
    (40,'rehabilitación', '2024-04-17', 'San Bernardo Vet.', 'Requiere control', 65.00),
    (1, 'vacuna', '2024-05-18', 'Clínica VetSalud', 'Sin incidencias', 80.00),
    (2, 'desparasitación', '2024-06-19', 'Animalia Centro Vet.', 'Sin incidencias', 95.00),
    (3, 'operación', '2024-01-20', 'Huellas & Co.', 'Requiere control', 20.00),
    (4, 'revisión', '2024-02-21', 'VetMotion', 'Sin incidencias', 35.00),
    (5, 'rehabilitación', '2024-03-22', 'San Bernardo Vet.', 'Sin incidencias', 50.00),
    (6, 'vacuna', '2024-04-23', 'Clínica VetSalud', 'Requiere control', 65.00),
    (7, 'desparasitación', '2024-05-24', 'Animalia Centro Vet.', 'Sin incidencias', 80.00),
    (8, 'operación', '2024-06-25', 'Huellas & Co.', 'Sin incidencias', 95.00);

---------------------------------------------------------
-- 11. DONACIONES (40)
---------------------------------------------------------
INSERT INTO donacion (id_persona, fecha, cantidad, metodo_pago, comentario)
VALUES
    (1, '2024-01-05', 10.00, 'bizum', 'Gracias por vuestra labor'),
    (2, '2024-02-06', 15.00, 'tarjeta', 'Donación mensual'),
    (3, '2024-03-07', 20.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (4, '2024-04-08', 25.00, 'efectivo', NULL),
    (5, '2024-05-09', 30.00, 'bizum', 'Gracias por vuestra labor'),
    (6, '2024-06-10', 35.00, 'tarjeta', 'Donación mensual'),
    (7, '2024-07-11', 40.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (8, '2024-08-12', 45.00, 'efectivo', NULL),
    (9, '2024-09-13', 50.00, 'bizum', 'Gracias por vuestra labor'),
    (10,'2024-10-14', 55.00, 'tarjeta', 'Donación mensual'),
    (11,'2024-01-15', 60.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (12,'2024-02-16', 15.00, 'efectivo', NULL),
    (13,'2024-03-17', 20.00, 'bizum', 'Gracias por vuestra labor'),
    (14,'2024-04-18', 25.00, 'tarjeta', 'Donación mensual'),
    (15,'2024-05-19', 30.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (16,'2024-06-20', 35.00, 'efectivo', NULL),
    (17,'2024-07-21', 40.00, 'bizum', 'Gracias por vuestra labor'),
    (18,'2024-08-22', 45.00, 'tarjeta', 'Donación mensual'),
    (19,'2024-09-23', 50.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (20,'2024-10-24', 55.00, 'efectivo', NULL),
    (21,'2024-01-06', 60.00, 'bizum', 'Gracias por vuestra labor'),
    (22,'2024-02-07', 15.00, 'tarjeta', 'Donación mensual'),
    (23,'2024-03-08', 20.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (24,'2024-04-09', 25.00, 'efectivo', NULL),
    (25,'2024-05-10', 30.00, 'bizum', 'Gracias por vuestra labor'),
    (1, '2024-06-11', 35.00, 'tarjeta', 'Donación mensual'),
    (2, '2024-07-12', 40.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (3, '2024-08-13', 45.00, 'efectivo', NULL),
    (4, '2024-09-14', 50.00, 'bizum', 'Gracias por vuestra labor'),
    (5, '2024-10-15', 55.00, 'tarjeta', 'Donación mensual'),
    (6, '2024-01-16', 60.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (7, '2024-02-17', 15.00, 'efectivo', NULL),
    (8, '2024-03-18', 20.00, 'bizum', 'Gracias por vuestra labor'),
    (9, '2024-04-19', 25.00, 'tarjeta', 'Donación mensual'),
    (10,'2024-05-20', 30.00, 'transferencia', 'Para ayudar con tratamientos caros'),
    (11,'2024-06-21', 35.00, 'efectivo', NULL),
    (12,'2024-07-22', 40.00, 'bizum', 'Gracias por vuestra labor'),
    (13,'2024-08-23', 45.00, 'tarjeta', 'Donación mensual'),
    (14,'2024-09-24', 50.00, 'transferencia', 'Para ayudar con tratamientos caros');


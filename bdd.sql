-- CREACIÓN DE TABLAS
CREATE TABLE especializacion(
		esp_codigo VARCHAR(20) PRIMARY KEY,
		esp_descripcion VARCHAR(100)
);
CREATE TABLE sede(
		sed_codigo VARCHAR(20) PRIMARY KEY,
		sed_descripcion VARCHAR(100)
);
CREATE TABLE consejo(
		cons_codigo VARCHAR(20) PRIMARY KEY,
		cons_descripcion VARCHAR(100)
);
CREATE TABLE estamento(
		esta_codigo VARCHAR(20) PRIMARY KEY,
		esta_descripcion VARCHAR(100)
);
CREATE TABLE comision(
		com_codigo VARCHAR(20) PRIMARY KEY,
		com_descripcion VARCHAR(100)
);
CREATE TABLE vehiculo(
		veh_patente VARCHAR(10) PRIMARY KEY,
		veh_modelo VARCHAR (20),
		veh_capacidad INT
);
CREATE TABLE chofer(
		cho_rut VARCHAR(12) PRIMARY KEY,
		cho_nombre VARCHAR(50),
		cho_telefono VARCHAR(20)
);
CREATE TABLE lugar_sesion(
		lug_codigo VARCHAR(20) PRIMARY KEY,
		lug_descripcion VARCHAR(100),
		lug_edificio VARCHAR(50)
);
CREATE TABLE unidad_administrativa(
		ua_codigo VARCHAR(20) PRIMARY KEY,
		ua_descripcion VARCHAR(100),
		sed_codigo VARCHAR(20),
		FOREIGN KEY (sed_codigo) REFERENCES sede(sed_codigo)
);
CREATE TABLE consejero(
		con_rut VARCHAR(12) PRIMARY KEY,
		con_nombre VARCHAR(50),
		con_apellido VARCHAR(50),
		con_telefono VARCHAR(20),
		con_sexo VARCHAR(50),
		esta_codigo VARCHAR(20),
		FOREIGN KEY (esta_codigo) REFERENCES estamento(esta_codigo)
);
CREATE TABLE programa_academico(
		pa_codigo VARCHAR(20) PRIMARY KEY,
		pa_descripcion VARCHAR(100),
		pa_tipo VARCHAR(50),
		sed_codigo VARCHAR(20),
		FOREIGN KEY (sed_codigo) REFERENCES sede(sed_codigo)
);
CREATE TABLE facultad(
		fac_codigo VARCHAR(20) PRIMARY KEY,
		fac_descripcion VARCHAR(100),
		sed_codigo VARCHAR(20),
		FOREIGN KEY (sed_codigo) REFERENCES sede(sed_codigo)
);
CREATE TABLE autoridad(
		aut_rut VARCHAR(12) PRIMARY KEY,
		aut_nombre VARCHAR (50),
		aut_cargo VARCHAR(50),
		ua_codigo VARCHAR(20),
		FOREIGN KEY (ua_codigo) REFERENCES unidad_administrativa(ua_codigo)
);
CREATE TABLE departamento(
		dep_codigo VARCHAR(20) PRIMARY KEY,
		dep_descripcion VARCHAR (100),
		fac_codigo VARCHAR(20),
		FOREIGN KEY (fac_codigo) REFERENCES facultad(fac_codigo)
);
CREATE TABLE participa(
		com_codigo VARCHAR(20),
		con_rut VARCHAR(12),
		fecha_inicio DATE,
		fecha_fin DATE,
		PRIMARY KEY (com_codigo,con_rut),
		FOREIGN KEY (com_codigo) REFERENCES comision(com_codigo),
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut)
);
CREATE TABLE academico(
		con_rut VARCHAR(12) PRIMARY KEY,
		dep_codigo VARCHAR(20),
		esp_codigo VARCHAR(20),
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut),
		FOREIGN KEY (dep_codigo) REFERENCES departamento(dep_codigo),
		FOREIGN KEY (esp_codigo) REFERENCES especializacion(esp_codigo)
);
CREATE TABLE profesional_externo(
		con_rut VARCHAR(12) PRIMARY KEY,
		lugar_trabajo VARCHAR(100),
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut)
);
CREATE TABLE estudiante(
		con_rut VARCHAR(12) PRIMARY KEY,
		estu_tipo VARCHAR(100),
		pa_codigo VARCHAR(20) ,
		estu_anio_ingreso INT,
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut),
		FOREIGN KEY (pa_codigo) REFERENCES programa_academico(pa_codigo)
		
);
CREATE TABLE pertenece_consejo(
		cons_codigo VARCHAR(20),
		con_rut VARCHAR(12),
		fecha_ingreso DATE,
		fecha_termino DATE,
		PRIMARY KEY(cons_codigo,con_rut),
		FOREIGN KEY (cons_codigo) REFERENCES consejo(cons_codigo),
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut)
);
CREATE TABLE usa(
		con_rut VARCHAR(12),
		veh_patente VARCHAR(10),
		fecha DATE,
		PRIMARY KEY(con_rut,veh_patente,fecha),
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut),
		FOREIGN KEY (veh_patente) REFERENCES vehiculo(veh_patente)
);
CREATE TABLE funcionario (
		con_rut VARCHAR (12) PRIMARY KEY,
		FOREIGN KEY (con_rut) REFERENCES consejero(con_rut)
);
CREATE TABLE vinculado_ua (
		con_rut VARCHAR(12),
		ua_codigo VARCHAR(20),
		PRIMARY KEY(con_rut,ua_codigo),
		FOREIGN KEY(con_rut) REFERENCES consejero(con_rut),
		FOREIGN KEY(ua_codigo) REFERENCES unidad_administrativa(ua_codigo)
);
CREATE TABLE vinculado_f(
		con_rut VARCHAR(12),
		fac_codigo VARCHAR(20),
		PRIMARY KEY(con_rut,fac_codigo),
		FOREIGN KEY(con_rut) REFERENCES consejero(con_rut),
		FOREIGN KEY(fac_codigo) REFERENCES facultad(fac_codigo)
);
CREATE TABLE sesion(
		ses_codigo VARCHAR(20) PRIMARY KEY,
		ses_fecha DATE,
		ses_hora TIME,
		lug_codigo VARCHAR(20),
		sed_codigo VARCHAR(20),
		FOREIGN KEY (lug_codigo) REFERENCES lugar_sesion(lug_codigo),
		FOREIGN KEY (sed_codigo) REFERENCES sede(sed_codigo)
);
CREATE TABLE acta(
		act_codigo VARCHAR(20) PRIMARY KEY,
		act_fecha DATE,
		act_texto VARCHAR(100),
		ses_codigo VARCHAR(20),
		FOREIGN KEY (ses_codigo) REFERENCES sesion(ses_codigo)
);
CREATE TABLE asiste_c(
		con_rut VARCHAR(12),
		ses_codigo VARCHAR(20),
		PRIMARY KEY(con_rut,ses_codigo),
		FOREIGN KEY(con_rut) REFERENCES consejero(con_rut),
		FOREIGN KEY (ses_codigo) REFERENCES sesion(ses_codigo)
);
CREATE TABLE asiste_a(
		aut_rut VARCHAR(12),
		ses_codigo VARCHAR(20),
		PRIMARY KEY(aut_rut,ses_codigo),
		FOREIGN KEY(aut_rut) REFERENCES autoridad(aut_rut),
		FOREIGN KEY (ses_codigo) REFERENCES sesion(ses_codigo)
);
CREATE TABLE requiere(
		ses_codigo VARCHAR(20),
		veh_patente VARCHAR(10),
		cho_rut VARCHAR(12),
		hora_salida TIME,
		hora_retorno TIME,
		PRIMARY KEY(ses_codigo,veh_patente,cho_rut),
		FOREIGN KEY (ses_codigo) REFERENCES sesion(ses_codigo),
		FOREIGN KEY (veh_patente) REFERENCES vehiculo(veh_patente),
		FOREIGN KEY (cho_rut) REFERENCES chofer(cho_rut)
);
CREATE TABLE tema(
		tem_codigo VARCHAR(20) PRIMARY KEY,
		tem_descripcion VARCHAR(100),
		tem_tipo VARCHAR(50),
		ses_codigo VARCHAR(20),
		FOREIGN KEY (ses_codigo) REFERENCES sesion(ses_codigo)
);
CREATE TABLE propone(
		aut_rut VARCHAR(12),
		tem_codigo VARCHAR(20),
		PRIMARY KEY(aut_rut,tem_codigo),
		FOREIGN KEY(aut_rut) REFERENCES autoridad(aut_rut),
		FOREIGN KEY(tem_codigo) REFERENCES tema(tem_codigo)
);
CREATE TABLE propone_c(
		com_codigo VARCHAR(20),
		tem_codigo VARCHAR(20),
		PRIMARY KEY(com_codigo,tem_codigo),
		FOREIGN KEY(com_codigo) REFERENCES comision(com_codigo),
		FOREIGN KEY(tem_codigo) REFERENCES tema(tem_codigo)
);
CREATE TABLE acuerdo(
		acu_codigo VARCHAR(20) PRIMARY KEY,
		acu_descripcion VARCHAR(100),
		acu_fecha_votacion DATE,
		Acu_resultado VARCHAR(50),
		tem_codigo VARCHAR(20),
		FOREIGN KEY(tem_codigo) REFERENCES tema(tem_codigo)
);
CREATE TABLE vota(
		acu_codigo VARCHAR(20),
		con_rut VARCHAR(12),
		opcion VARCHAR(20),
		PRIMARY KEY(acu_codigo,con_rut),
		FOREIGN KEY(acu_codigo) REFERENCES acuerdo(acu_codigo),
		FOREIGN KEY(con_rut) REFERENCES consejero(con_rut)
);
-- FIN CREACIÓN DE TABLAS

-- INSERT DE DATOS
INSERT INTO especializacion VALUES
('ESP01', 'Ingeniería de Software'),
('ESP02', 'Inteligencia Artificial'),
('ESP03', 'Redes y Seguridad'),
('ESP04', 'Ciencias de Datos');

INSERT INTO sede VALUES
('SED01', 'Sede Central'),
('SED02', 'Campus Norte');

INSERT INTO consejo VALUES
('CON01', 'Consejo Universitario'),
('CON02', 'Consejo Estudiantil'),
('CON03', 'Consejo de Administración');

INSERT INTO estamento VALUES
('EST01', 'Académico'),
('EST02', 'Estudiante'),
('EST03', 'Externo');

INSERT INTO comision VALUES
('COM01', 'Comisión de Docencia'),
('COM02', 'Comisión de Infraestructura'),
('COM03', 'Comisión de Vinculación');

INSERT INTO vehiculo VALUES
('ABCD10', 'Toyota Van', 12),
('QWER22', 'Hyundai Bus', 20),
('ZXCV33', 'Mercedes Sprinter', 15);

INSERT INTO chofer VALUES
('11111111-1', 'Juan Pérez', '912345678'),
('22222222-2', 'Mario López', '987654321'),
('33333333-5', 'Diego Castro', '915263748');

INSERT INTO lugar_sesion VALUES
('LUG01', 'Sala Magna', 'Edificio Central'),
('LUG02', 'Sala 201', 'Edificio B');

INSERT INTO unidad_administrativa VALUES
('UA01', 'Dirección Académica', 'SED01'),
('UA02', 'Dirección Estudiantil', 'SED02');

INSERT INTO consejero VALUES
('33333333-3', 'Pedro', 'González', '945612378', 'M', 'EST01'),
('44444444-4', 'Ana', 'Muñoz', '987451236', 'F', 'EST02'),
('55555555-6', 'Luis', 'Hernández', '912345987', 'M', 'EST01'),
('99999999-9', 'Roberto', 'Fuentes', '956781234', 'M', 'EST01'),
('88888888-9', 'Carla', 'Vidal', '945612789', 'F', 'EST01'),
('66666666-6', 'Carlos', 'Soto', '956123456', 'M', 'EST03'),
('77777777-7', 'María', 'Silva', '945678912', 'F', 'EST03');

INSERT INTO programa_academico VALUES
('PA01', 'Ingeniería Informática', 'Pregrado', 'SED01'),
('PA02', 'Ingeniería Comercial', 'Pregrado', 'SED02');

INSERT INTO facultad VALUES
('FAC01', 'Fac. Ingeniería', 'SED01'),
('FAC02', 'Fac. Economía', 'SED02'),
('FAC03', 'Fac. Ciencias Empresariales', 'SED01'),
('FAC04', 'Fac. Ingeniería', 'SED01');

INSERT INTO autoridad VALUES
('66666666-6', 'Carlos Soto', 'Decano', 'UA01'),
('77777777-7', 'María Silva', 'Directora', 'UA02'),
('88888888-8', 'Rodrigo Díaz', 'Jefe Vinculación', 'UA01');

INSERT INTO departamento VALUES
('DEP01', 'Informática', 'FAC01'),
('DEP02', 'Administración', 'FAC02'),
('DEP03', 'Ciencias Datos', 'FAC03'),
('DEP04', 'Ingeniería Civil', 'FAC04');

INSERT INTO participa VALUES
('COM01', '33333333-3', '2024-01-01', NULL),
('COM02', '44444444-4', '2024-03-01', NULL),
('COM03', '55555555-6', '2024-02-10', NULL);

INSERT INTO academico VALUES
('33333333-3', 'DEP01', 'ESP01'),
('44444444-4', 'DEP02', 'ESP02'),
('55555555-6', 'DEP01', 'ESP03'),
('99999999-9', 'DEP03', 'ESP04'),
('88888888-9', 'DEP04', 'ESP04');

INSERT INTO profesional_externo VALUES
('66666666-6', 'Empresa Privada'),
('77777777-7', 'Consultora Z');

INSERT INTO estudiante VALUES
('44444444-4', 'Regular', 'PA02', 2023),
('55555555-6', 'Regular', 'PA01', 2024);

INSERT INTO pertenece_consejo VALUES
('CON01', '33333333-3', '2024-01-10', NULL),
('CON02', '44444444-4', '2024-02-01', NULL),
('CON03', '55555555-6', '2024-04-08', NULL),
('CON01', '99999999-9', '2025-01-15', NULL),
('CON01', '88888888-9', '2025-02-01', NULL);

INSERT INTO usa VALUES
('33333333-3', 'ABCD10', '2024-04-10'),
('44444444-4', 'QWER22', '2024-04-12'),
('33333333-3', 'ABCD10', '2025-03-20'),
('44444444-4', 'QWER22', '2025-05-15');

INSERT INTO funcionario VALUES
('33333333-3'),
('55555555-6');

INSERT INTO vinculado_ua VALUES
('33333333-3', 'UA01'),
('44444444-4', 'UA02'),
('55555555-6', 'UA01');

INSERT INTO vinculado_f VALUES
('33333333-3', 'FAC01'),
('44444444-4', 'FAC02'),
('55555555-6', 'FAC01'),
('99999999-9', 'FAC03'),
('88888888-9', 'FAC04');

INSERT INTO sesion VALUES
('SES01', '2024-06-01', '10:00', 'LUG01', 'SED01'),
('SES02', '2024-06-05', '15:00', 'LUG02', 'SED02'),
('SES03', '2024-06-10', '09:00', 'LUG01', 'SED01'),
('SES04', '2025-09-15', '10:00', 'LUG01', 'SED01'),
('SES05', '2025-10-10', '14:00', 'LUG02', 'SED02'),
('SES06', '2025-03-20', '09:00', 'LUG01', 'SED01'),
('SES07', '2025-05-15', '11:00', 'LUG02', 'SED02'),
('SES08', '2025-07-22', '10:00', 'LUG01', 'SED01');

INSERT INTO acta VALUES
('ACT01', '2024-06-01', 'Acta Sesión 1', 'SES01'),
('ACT02', '2024-06-05', 'Acta Sesión 2', 'SES02');

INSERT INTO asiste_c VALUES
('33333333-3', 'SES01'),
('44444444-4', 'SES02'),
('55555555-6', 'SES03'),
('33333333-3', 'SES04'),
('88888888-9', 'SES05'),
('33333333-3', 'SES06'),
('44444444-4', 'SES07'),
('55555555-6', 'SES08'),
('99999999-9', 'SES06'),
('88888888-9', 'SES07');

INSERT INTO asiste_a VALUES
('66666666-6', 'SES01'),
('77777777-7', 'SES02'),
('88888888-8', 'SES03');

INSERT INTO requiere VALUES
('SES01', 'ABCD10', '11111111-1', '09:30', '12:00'),
('SES02', 'QWER22', '22222222-2', '14:00', '18:00'),
('SES03', 'ZXCV33', '33333333-5', '08:30', '11:30'),
('SES06', 'ABCD10', '11111111-1', '08:30', '12:00'),
('SES07', 'QWER22', '22222222-2', '10:00', '15:00'),
('SES08', 'ZXCV33', '33333333-5', '09:00', '13:00');

INSERT INTO tema VALUES
('TEM01', 'Infraestructura TI', 'Académico', 'SES01'),
('TEM02', 'Presupuesto 2025', 'Administrativo', 'SES02'),
('TEM03', 'Acreditación', 'Académico', 'SES03'),
('TEM04', 'Informe Académico', 'Informativo', 'SES04'),
('TEM05', 'Actualización Normativa', 'Informativo', 'SES05'),
('TEM06', 'Mejora Docencia', 'Académico', 'SES06'),
('TEM07', 'Plan Infraestructura', 'Administrativo', 'SES07'),
('TEM08', 'Convenios Externos', 'Administrativo', 'SES08');

INSERT INTO propone VALUES
('66666666-6', 'TEM01'),
('77777777-7', 'TEM02'),
('88888888-8', 'TEM03');

INSERT INTO propone_c VALUES
('COM01', 'TEM01'),
('COM02', 'TEM02'),
('COM03', 'TEM03'),
('COM01', 'TEM06'),
('COM02', 'TEM07'),
('COM03', 'TEM08');

INSERT INTO acuerdo VALUES
('ACU01', 'Mejora en red de datos', '2024-06-01', 'A Favor', 'TEM01'),
('ACU02', 'Nuevo edificio', '2024-06-05', 'Pendiente', 'TEM02'),
('ACU03', 'Evaluar malla curricular', '2024-06-10', 'A Favor', 'TEM03');

INSERT INTO vota VALUES
('ACU01', '33333333-3', 'A Favor'),
('ACU02', '44444444-4', 'En Contra'),
('ACU03', '55555555-6', 'A Favor');
-- FIN INSERT DE DATOS

-- CONSULTAS
-- Q1: Consejeros Académicos en Facultades Específicas

SELECT 
    c.con_nombre, 
    c.con_apellido, 
    e.esta_descripcion, 
    d.dep_descripcion, 
    cons.cons_descripcion
FROM consejero c
JOIN estamento e ON c.esta_codigo = e.esta_codigo
JOIN academico a ON c.con_rut = a.con_rut
JOIN departamento d ON a.dep_codigo = d.dep_codigo
JOIN facultad f ON d.fac_codigo = f.fac_codigo
JOIN especializacion esp ON a.esp_codigo = esp.esp_codigo
JOIN pertenece_consejo pc ON c.con_rut = pc.con_rut
JOIN consejo cons ON pc.cons_codigo = cons.cons_codigo
WHERE pc.fecha_termino IS NULL
  AND esp.esp_descripcion = 'Ciencias de Datos'
  AND f.fac_descripcion IN ('Fac. Ciencias Empresariales', 'Fac. Ingeniería');

-- Q2: Consejeros del Consejo Universitario sin asistencia en Septiembre y Octubre 2025 a sesiones sin temas resolutivos

SELECT DISTINCT c.con_nombre, c.con_apellido
FROM consejero c
INNER JOIN pertenece_consejo pc ON c.con_rut = pc.con_rut
INNER JOIN consejo co ON pc.cons_codigo = co.cons_codigo
WHERE co.cons_descripcion = 'Consejo Universitario'
  AND (pc.fecha_termino IS NULL OR pc.fecha_termino >= CURRENT_DATE)
  AND c.con_rut NOT IN (
      SELECT ac.con_rut
      FROM asiste_c ac
      INNER JOIN sesion s ON ac.ses_codigo = s.ses_codigo
      WHERE EXTRACT(YEAR FROM s.ses_fecha) = 2025
        AND EXTRACT(MONTH FROM s.ses_fecha) IN (9, 10)
        AND s.ses_codigo NOT IN (
            SELECT t.ses_codigo
            FROM tema t
            INNER JOIN propone p ON t.tem_codigo = p.tem_codigo
            WHERE t.tem_tipo = 'Resolutivo'
        )
  );

-- Q3: Resumen Sesiones 2025

SELECT 
    co.cons_descripcion AS Consejo,
    s.ses_codigo AS Codigo_Sesion,
    COUNT(DISTINCT t.tem_codigo) AS Numero_Temas,
    COUNT(DISTINCT CASE 
        WHEN u.con_rut IS NOT NULL AND DATE(u.fecha) = DATE(s.ses_fecha) 
        THEN ac.con_rut 
    END) AS Consejeros_Con_Vehiculo,
    COUNT(DISTINCT CASE 
        WHEN u.con_rut IS NULL OR DATE(u.fecha) != DATE(s.ses_fecha)
        THEN ac.con_rut 
    END) AS Consejeros_Sin_Vehiculo
FROM sesion s
JOIN tema t ON s.ses_codigo = t.ses_codigo
JOIN propone_c pc ON t.tem_codigo = pc.tem_codigo
JOIN asiste_c ac ON s.ses_codigo = ac.ses_codigo
JOIN pertenece_consejo pcon ON ac.con_rut = pcon.con_rut
JOIN consejo co ON pcon.cons_codigo = co.cons_codigo
LEFT JOIN usa u ON ac.con_rut = u.con_rut AND DATE(u.fecha) = DATE(s.ses_fecha)
WHERE EXTRACT(YEAR FROM s.ses_fecha) = 2025
  AND EXTRACT(MONTH FROM s.ses_fecha) BETWEEN 1 AND 11
  AND (pcon.fecha_termino IS NULL OR pcon.fecha_termino >= s.ses_fecha)
GROUP BY co.cons_descripcion, s.ses_codigo
ORDER BY s.ses_codigo;

-- Q4: Vista y Consejero con Mayor Asistencia 2025

CREATE OR REPLACE VIEW vista_asistencia_2025 AS
SELECT 
    c.con_rut,
    c.con_nombre,
    c.con_apellido,
    e.esta_descripcion AS estamento,
    co.cons_descripcion AS consejo,
    COUNT(DISTINCT s.ses_codigo) AS sesiones_totales,
    COUNT(DISTINCT ac.ses_codigo) AS sesiones_asistidas,
    ROUND(
        (COUNT(DISTINCT ac.ses_codigo)::NUMERIC / 
         NULLIF(COUNT(DISTINCT s.ses_codigo), 0)) * 100, 
        2
    ) AS porcentaje_asistencia
FROM consejero c
JOIN pertenece_consejo pc ON c.con_rut = pc.con_rut
JOIN consejo co ON pc.cons_codigo = co.cons_codigo
JOIN estamento e ON c.esta_codigo = e.esta_codigo
CROSS JOIN sesion s
LEFT JOIN asiste_c ac ON c.con_rut = ac.con_rut AND s.ses_codigo = ac.ses_codigo
WHERE pc.fecha_termino IS NULL
  AND EXTRACT(YEAR FROM s.ses_fecha) = 2025
  AND EXTRACT(MONTH FROM s.ses_fecha) BETWEEN 1 AND 11
GROUP BY c.con_rut, c.con_nombre, c.con_apellido, e.esta_descripcion, co.cons_descripcion;

-- Consulta del consejero con mayor asistencia
SELECT 
    con_nombre,
    con_apellido,
    estamento,
    porcentaje_asistencia
FROM vista_asistencia_2025
WHERE porcentaje_asistencia = (
    SELECT MAX(porcentaje_asistencia)
    FROM vista_asistencia_2025
);
-- FIN CONSULTAS
-- Integrantes: Guillermo Villar, Victor Flores, Arline Mitchel.
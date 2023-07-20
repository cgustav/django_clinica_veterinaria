USE clinica_vet_db;

INSERT INTO Usuarios (nombre_completo, email, contrasena, rol, esRestringido) VALUES
('Juan Pérez', 'jperez@yopmail.com', '123456', 'Administrador', false),
('María Sánchez', 'msanz@yopmail.com', '123456', 'Asistente', false),
('Pedro González', 'pgonz@yopmail.com', '123456', 'Veterinario', false);


INSERT INTO Clientes (rut, nombres, apellidos, fono_contacto1, email, fono_contacto2) VALUES
('11.111.111-1', 'Denzel', 'Washington', '+56911111111', 'dwashington@yopmail.com', '+56911111111'),
('22.222.222-2', 'Tom', 'Hanks', '+56922222222', 'tom.hanks1@yopmail.com', '+56922222222'),
('33.333.333-3', 'Morgan', 'Freeman', '+56933333333', 'm.freeman@yopmail.com', '+56933333333');
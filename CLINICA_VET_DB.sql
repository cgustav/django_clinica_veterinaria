CREATE DATABASE clinica_vet_db;

USE clinica_vet_db;

CREATE TABLE Usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_completo VARCHAR(180) NOT NULL,
  email VARCHAR(180) NOT NULL,
  contrasena VARCHAR(200) NOT NULL,
  rol ENUM('Administrador', 'Asistente', 'Veterinario') NOT NULL,
  esRestringido BOOLEAN NOT NULL DEFAULT false 
);

CREATE TABLE Clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  rut VARCHAR(20) NOT NULL,
  nombres VARCHAR(120) NOT NULL,
  apellidos VARCHAR(200) NOT NULL,
  fono_contacto1 VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fono_contacto2 VARCHAR(20)
);

CREATE TABLE Mascotas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  sexo ENUM('Macho', 'Hembra') NOT NULL,
  especie VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  numero_chip VARCHAR(20),
  raza VARCHAR(100) NOT NULL,
  propietario_id INT NOT NULL,
  FOREIGN KEY (propietario_id) REFERENCES Clientes(id)
);

CREATE TABLE FichasVeterinarias (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mascota_id INT NOT NULL,
  veterinario_id INT NOT NULL,
  fecha_creacion DATE NOT NULL,
  INDEX fk_ficha_veterinaria_mascota_idx (mascota_id),
  INDEX fk_ficha_veterinaria_veterinario_idx (veterinario_id),
  FOREIGN KEY (mascota_id) REFERENCES Mascotas(id),
  FOREIGN KEY (veterinario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Atenciones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ficha_id INT NOT NULL,
  fecha_creacion DATE NOT NULL,
  fecha_modificacion DATE NULL,
  diagnostico VARCHAR(400) NOT NULL,
  tratamiento VARCHAR(400) NOT NULL,
  observaciones VARCHAR(500),
  -- fecha_control DATE NOT NULL,
  veterinario_id INT NOT NULL,
  requiere_seguimiento BOOLEAN NOT NULL DEFAULT false,
  INDEX fk_atenciones_veterinario_idx (veterinario_id),
  FOREIGN KEY (ficha_id) REFERENCES FichasVeterinarias(id),
  FOREIGN KEY (veterinario_id) REFERENCES Usuarios(id)
);

-- ALTER TABLE Atenciones ADD COLUMN fecha_creacion DATE NOT NULL AFTER ficha_id;
-- ALTER TABLE Atenciones ADD COLUMN fecha_modificacion DATE NULL AFTER fecha_creacion;
-- ALTER TABLE Atenciones ADD COLUMN requiere_seguimiento BOOLEAN NOT NULL DEFAULT false AFTER veterinario_id;

-- delete fecha_control from Atenciones;
-- ALTER TABLE Atenciones DROP COLUMN fecha_control;
CREATE TABLE Recetas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mascota_id INT NOT NULL,
  descripcion_medicamentos VARCHAR(500) NOT NULL,
  fecha_emision DATE NOT NULL,
  fecha_vencimiento DATE,
  INDEX fk_recetas_mascota_idx (mascota_id),
  FOREIGN KEY (mascota_id) REFERENCES Mascotas(id)
);

CREATE TABLE AccesosVeterinarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  veterinario_id INT NOT NULL,
  dispositivo ENUM('Computadora', 'Tableta') NOT NULL,
  FOREIGN KEY (veterinario_id) REFERENCES Usuarios(id)
);


-- INCREMENTAL SETTINGS
-- CREATE TABLE Roles (
--   id INT PRIMARY KEY AUTO_INCREMENT,
--   nombre VARCHAR(100) NOT NULL,
--   permisos TEXT NOT NULL
-- );

-- CREATE TABLE UsuariosRoles (
--   usuario_id INT NOT NULL,
--   rol_id INT NOT NULL,
--   PRIMARY KEY (usuario_id, rol_id),
--   INDEX fk_usuarios_roles_usuario_idx (usuario_id),
--   INDEX fk_usuarios_roles_rol_idx (rol_id),
--   FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
--   FOREIGN KEY (rol_id) REFERENCES Roles(id)
--   );

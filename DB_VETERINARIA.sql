CREATE TABLE Usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_completo VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  contrasena VARCHAR(100) NOT NULL,
  rol ENUM('Administrador', 'Asistente', 'Veterinario') NOT NULL,
  estado ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo'
);

CREATE TABLE Mascotas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  sexo ENUM('Macho', 'Hembra') NOT NULL,
  edad INT NOT NULL,
  numero_chip VARCHAR(20),
  raza VARCHAR(100) NOT NULL,
  propietario_id INT NOT NULL,
  FOREIGN KEY (propietario_id) REFERENCES Clientes(id)
);

CREATE TABLE Clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  rut VARCHAR(20) NOT NULL,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  fono_contacto1 VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fono_contacto2 VARCHAR(20)
);

CREATE TABLE FichasVeterinarias (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mascota_id INT NOT NULL,
  veterinario_id INT NOT NULL,
  FOREIGN KEY (mascota_id) REFERENCES Mascotas(id),
  FOREIGN KEY (veterinario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Atenciones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ficha_id INT NOT NULL,
  diagnostico VARCHAR(100) NOT NULL,
  tratamiento VARCHAR(100) NOT NULL,
  observaciones VARCHAR(100),
  fecha_control DATE NOT NULL,
  veterinario_id INT NOT NULL,
  FOREIGN KEY (ficha_id) REFERENCES FichasVeterinarias(id),
  FOREIGN KEY (veterinario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Recetas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  mascota_id INT NOT NULL,
  descripcion_medicamentos VARCHAR(100) NOT NULL,
  FOREIGN KEY (mascota_id) REFERENCES Mascotas(id)
);

CREATE TABLE AccesosVeterinarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  veterinario_id INT NOT NULL,
  dispositivo ENUM('Computadora', 'Tableta') NOT NULL,
  FOREIGN KEY (veterinario_id) REFERENCES Usuarios(id)
);

CREATE TABLE Roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  permisos TEXT NOT NULL
);

CREATE TABLE UsuariosRoles (
  usuario_id INT NOT NULL,
  rol_id INT NOT NULL,
  PRIMARY KEY (usuario_id, rol_id),
  FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
  FOREIGN KEY (rol_id) REFERENCES Roles(id)
  );
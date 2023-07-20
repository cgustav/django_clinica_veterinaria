from django.db import models


# Entidad de cliente
# Se considera cliente a quien sea propietario de una mascota
# Y quien costea el servicio de atención veterinaria
class Cliente(models.Model):
    id = models.AutoField(primary_key=True)
    rut = models.CharField(max_length=20)
    nombres = models.CharField(max_length=120)
    apellidos = models.CharField(max_length=200)
    email = models.CharField(max_length=100)
    fono_contacto1 = models.CharField(max_length=20)
    fono_contacto2 = models.CharField(max_length=20)

    class Meta:
        db_table = 'Clientes'


# Entidad de usuario
# Se considera usuario a quien sea personal de la clínica
# o a quien atiende a las mascotas
class Usuario(models.Model):
    id = models.AutoField(primary_key=True)
    nombre_completo = models.CharField(max_length=180)
    email = models.CharField(max_length=180)
    contrasena = models.CharField(max_length=200)
    rol = models.CharField(max_length=20)
    esRestringido = models.BooleanField()

    class Meta:
        db_table = 'Usuarios'


# Entidad de mascota
# Se considera mascota a cualquier animal que sea atendido
# en la clínica.
class Mascota(models.Model):
    SEXO_CHOICES = [
        ('Macho', 'Macho'),
        ('Hembra', 'Hembra'),
    ]
    
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    sexo = models.CharField(max_length=6, choices=SEXO_CHOICES)
    especie = models.CharField(max_length=50)
    edad = models.IntegerField()
    numero_chip = models.CharField(max_length=20)
    raza = models.CharField(max_length=100)
    propietario = models.ForeignKey(Cliente, on_delete=models.CASCADE)

    class Meta:
        db_table = 'Mascotas'


# Entidad de ficha veterinaria
# Se considera ficha veterinaria a la ficha que se le asigna
# a cada mascota que es atendida en la clínica
class FichaVeterinaria(models.Model):
    id = models.AutoField(primary_key=True)
    veterinario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    mascota = models.ForeignKey(Mascota, on_delete=models.CASCADE)
    fecha_creacion = models.DateField()

    class Meta:
        db_table = 'FichasVeterinarias'


# Entidad de atención
# Se considera atención a cada atención que se le realiza
# a una mascota en la clínica. Esta incluye información sensible
# sobre la evoluciónd de salud de la mascota.
class Atencion(models.Model):
    id = models.AutoField(primary_key=True)
    diagnostico = models.CharField(max_length=400)
    tratamiento = models.CharField(max_length=400)
    observaciones = models.CharField(max_length=500)
    ficha = models.ForeignKey(FichaVeterinaria, on_delete=models.CASCADE)
    veterinario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    fecha_creacion = models.DateField()
    fecha_modificacion = models.DateField()
    requiere_seguimiento = models.BooleanField()


    class Meta:
        db_table = 'Atenciones'
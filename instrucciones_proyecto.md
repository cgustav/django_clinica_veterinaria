
# Requisitos

## Requisitos

Python 3.x o superior
pip 23.x o superior


## Configuración MySQL

1. Editar el archivo ubicado en clinica_veterinaria/settings.py 
2. Reemplace los valores (Dict) de la propiedad DATABASES.default

```python
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'NOMBRE_BASE_DATOS',
        'USER': 'USER_BASE_DATOS',
        'PASSWORD': 'PASSWORD_BASE_DATOS',
        'HOST': 'localhost',
        'PORT': '3306',
    }
```

## Preparación de proyecto

1. pip install mysqlclient
2. python3 manage.py makemigrations. 
3. python3 python manage.py migrate


## Servir proyecto de manera local

python3 manage.py runserver 8080
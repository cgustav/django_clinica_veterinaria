"""
URL configuration for clinica_veterinaria project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from .views import index, ingresar_mascota, listar_mascotas, ingresar_atencion, ficha_atencion, ficha_mascota


urlpatterns = [
    path('', index, name='index'),
    path('admin/', admin.site.urls),
    path('index.html', index, name='index'),
    path('ingresar_mascota.html', ingresar_mascota, name='ingresar_mascota'),
    path('listar_mascotas.html', listar_mascotas, name='listar_mascotas'),
    path('ingresar_atencion/<int:mascota_id>/', ingresar_atencion, name='ingresar_atencion'),
    path('ficha_atencion/<int:atencion_id>/', ficha_atencion, name='ficha_atencion'),
    path('ficha_mascota/<int:mascota_id>/', ficha_mascota, name='ficha_mascota'),

    # path('ficha_atencion.html', ficha_atencion, name='ficha_atencion'),
    # path('listar_atenciones.html', listar_atenciones, name='listar_mascotas'),
]

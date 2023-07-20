from django.shortcuts import render, redirect
from .models import Mascota, Atencion, Usuario, Cliente, FichaVeterinaria
import random
import string
from datetime import datetime

def index(request):
    atenciones = Atencion.objects.all()
    return render(request, 'index.html', {'atenciones': atenciones})

#  Modulo Ficha de mascotas
#  --------------------------------------------

def ingresar_mascota(request):
    if request.method == 'POST':
        nombre = request.POST['nombre']
        sexo = request.POST['sexo']
        especie = request.POST['especie']
        edad = request.POST['edad']
        numero_chip = request.POST['numero_chip']
        raza = request.POST['raza']
        veterinario = request.POST['veterinario']
        propietario = request.POST['propietario']

        # Print propietario value 
        # print(propietario)
        
        propietario_match = Cliente.objects.get(id=propietario)

        # Ingresar mascota
        mascota = Mascota(nombre=nombre, sexo=sexo, especie=especie, edad=edad,
                          numero_chip=numero_chip, raza=raza, propietario=propietario_match)
        mascota.save()

        veterinario_match = Usuario.objects.get(id=veterinario)

        # Ingresar ficha veterinaria de la mascota
        ficha_veterinaria = FichaVeterinaria(mascota=mascota, veterinario=veterinario_match, fecha_creacion=datetime.now().date())

        ficha_veterinaria.save()

        return redirect('listar_mascotas')  # Redireccionar a la lista de mascotas
    
    veterinarios = Usuario.objects.filter(rol='Veterinario')
    propietarios = Cliente.objects.all()
    especies = [
        'Perro',
        'Gato',
        'Conejo',
        'Pájaro',
        'Hamster',
        'Tortuga',
        'Iguana',
        'Pez',
        'Serpiente',
        'Otros'
    ]

    return render(request, 'ingresar_mascota.html', {'veterinarios': veterinarios, 'propietarios': propietarios, 'especies': especies})


def listar_mascotas(request):
    mascotas = Mascota.objects.all()
    return render(request, 'listar_mascotas.html', {'mascotas': mascotas})


#  Modulo Atenciones
#  --------------------------------------------

def ingresar_atencion(request, mascota_id):
    mascota= Mascota.objects.get(id=mascota_id)

    if request.method == 'POST':
        diagnostico = request.POST['diagnostico']
        tratamiento = request.POST['tratamiento']
        observaciones = request.POST['observaciones']
        requiere_seguimiento = request.POST.get('requiere_seguimiento', False)
        veterinario = request.POST['veterinario']

        veterinario_match = Usuario.objects.get(id=veterinario)
        ficha_match = FichaVeterinaria.objects.get(mascota=mascota)

        # Ensure that requiere_seguimiento is a boolean
        requiere_seguimiento = True if requiere_seguimiento == 'on' else False

        atencion = Atencion(ficha=ficha_match,
                            diagnostico=diagnostico,
                            tratamiento=tratamiento,
                            observaciones=observaciones,
                            veterinario=veterinario_match,
                            requiere_seguimiento=requiere_seguimiento,
                            fecha_creacion=datetime.now().date())
        atencion.save()

        return redirect('/listar_mascotas.html')  # Redireccionar a la lista de mascotas
    
    fichas = FichaVeterinaria.objects.all()
    veterinarios = Usuario.objects.filter(rol='Veterinario')

    return render(request, 'ingresar_atencion.html', {'fichas': fichas, 'veterinarios': veterinarios, 'mascota_id': mascota_id})


def ficha_atencion(request, atencion_id):
    atencion = Atencion.objects.get(id=atencion_id)
    return render(request, 'ficha_atencion.html', {'atencion': atencion})

def ficha_mascota(request, mascota_id):
    mascota = Mascota.objects.get(id=mascota_id)
    ficha = FichaVeterinaria.objects.get(mascota=mascota)
    atenciones = Atencion.objects.filter(ficha__mascota=mascota)
    return render(request, 'ficha_mascota.html', {'mascota':mascota, 'ficha': ficha, 'atenciones': atenciones})

# def listar_atenciones(request):
#     atenciones = Atencion.objects.all()
#     return render(request, 'index.html', {'atenciones': atenciones})
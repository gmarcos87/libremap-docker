# Imagen de Docker para Libremap-api
![docker-lime-geo](https://user-images.githubusercontent.com/10773838/31246570-2add60c0-a9e4-11e7-82b1-8024c6868fd0.png)


La instalación de una base de datos cocuch/geocouch resulta un poco engorrosa o cuesta arriba. Por eso surge la idea de generar un proceso simplificado, que permita el rapido despliege de una api libremap.

## Imágenes
Esta imagen está construida sobre la siguiente pirámide
libremap-api
    -> elecnix/geocouch
        -> klaemo/couchdb-base
            ->  ubuntu:14.04

## Dockerfile
En el archivo dockerfile se detalla todos los pasos realizados, el resultado es una imagen con geococuh, node, npm y un clon del repositorio de libremap-api con las dependencias instaladas.

## Generar la imagen
Para hacer el build solo es necesario tener instalado docker.

1)  Clonar este repositorio
```
$ git clone https://github.com/gmarcos87/libremap-docker.git libremeap-docker
```
2) Ingresar al directorio
```
$ cd libremap-docker
```
3) Realizar el build de la imagen
```
$ docker build -t 'libremesh/libremap-api:0.0.1' .
```

## Crear y ejecutar un container
Solo es necesario crear un container en base a la imagen de libremap-api y luego ejecutarla
```
    $ docker create --name libremap-api -ti -p 5984:5984 libremesh/libremap-api:0.0.1
    $ docker start libremap-api
```

Con esto lograras que geocouch/libremap responda desde http://localhost:5984 en tu computadora.

Por defecto solo hay un usuario creado que es "couchdb" y la contraseña está en blanco. Seguramente vas a querer hacer cambios a esa configuración antes de publicar el servicio.
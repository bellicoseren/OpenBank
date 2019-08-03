

![N|Solid](https://static.openbankproject.com/images/OBP_full_web.png)

## Ejecutar el comando a nivel de raiz del proyecto

```sh
$ docker-compose up --build --remove-orphans -d
```

## Ejecutar el comando a nivel para destruir el contenedor.

```sh
$ docker-compose down
```

## Contruccion del contenedor con la imagen
```sh
$ docker run -dti -p 8080-8082:8080-8082 --name obpmodif obpmodif
```

# NOTA
## Hasta el momento se ejecuta de la siguiente manera

#run servers
## WORKDIR /opt/OBP/API-Explorer
## CMD sh run.sh
## WORKDIR /opt/OBP/Social-Finance
## CMD sh run.sh
## WORKDIR /opt/OBP/OBP-API
## CMD sh run.sh

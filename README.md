

![N|Solid](https://static.openbankproject.com/images/OBP_full_web.png)

## Ejecutar el comando a nivel de raiz del proyecto

```sh
$ docker-compose up --build --remove-orphans -d
```

## Ejecutar el comando a nivel para destruir el contenedor.

```sh
$ docker-compose down
```

## Servicio en puerto 8080

```sh
cd /opt/OBP/OBP-API

./mvn.sh install -pl .,obp-commons && ./mvn.sh jetty:run -pl obp-api

```

## Servicio en puerto 8081

```sh
cd /opt/OBP/Social-Finance

mvn jetty:run -Djetty.port=8082 -DskipTests

```

## Servicio en puerto 8082

```sh
cd /opt/OBP/API-Explorer

mvn jetty:run -Djetty.port=8082 -DskipTests

```

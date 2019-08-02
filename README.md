## SOCIAL FINANCE >

```sh 
$ mvn package
```


## API EXPLORER > 
```sh 
$ mvn package
```

## OBP API

```sh
./mvn.sh install -pl .,obp-commons && ./mvn.sh jetty:run -pl obp-api
```


## Construccion de imagen
```sh
$ docker build --no-cache -t obpmodif .
```

## Contruccion del contenedor con la imagen
```sh
$ docker run -d -p 8080-8082:8080-8082 --name obpmodif obpmodif
```
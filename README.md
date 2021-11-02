# Estoque Backend

API Rest construida com [Dart](https://dart.dev/) e [Shelf](https://pub.dev/packages/shelf),

<!-- configured to enable running with [Docker](https://www.docker.com/). -->

Essa API recebe e processa requisições pelo protocolo HTTP, além de manipular o banco de dados 

## Dependecias:

 - [MariaDB](https://mariadb.org/) devidamente configurado
 - [Dart SDK](https://dart.dev/get-dart) ou [Flutter SDK](https://flutter.dev/docs/get-started/install/linux)
 - [Docker](https://www.docker.com/get-started) (opcional)

## Configuração

Configure a variável settings em `data_base.dart` com os dados do banco de dados. Os comandos SQL para a criação do banco de dados estão em `lib/databa_base.sql`.

## Executando a API

### Com o Dart SDK

Digite o seguinte comando:

```
$ dart run bin/server.dart
Server listening on port 8080
```

Em outro terminal digite:

```
$ curl http://localhost:8080
Hello, World!
```

Para manipular melhor as requisições utilize o [Insomnia](https://insomnia.rest/download)


### Com o Docker (ainda não funciona)

Digite o seguinte comando:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

Em outro terminal digite:
```
$ curl http://0.0.0.0:8080
Hello, World!
```

Para manipular melhor as requisições utilize o [Insomnia](https://insomnia.rest/download)

Você deve ver esse registro impresso no primeiro terminal:
```
2021-11-01T11:34:39.388748  0:00:00.005622 GET     [200] /
```

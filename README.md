# Requirements

Please install the following:

* [docker](https://github.com/docker/docker/releases)
* [docker-compose](https://github.com/docker/compose/releases)

# Usage

```sh
cd example/
docker-compose build
docker-compose up
```

Then go to port 8080 of your docker host.

For example: http://192.168.59.105:8080

Download the fly-cli for your system and upload test pipeline.

`fly -t http://192.168.59.105:8080 c test -c pipeline.yml`

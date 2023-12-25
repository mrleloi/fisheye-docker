# fisheye

## Requirement
- docker-compose: 17.09.0+

## How to run with docker-compose

- start fisheye & mysql

```
git clone https://github.com/mrleloi/fisheye-docker.git \
    && cd fisheye-docker \
    && docker-compose up
```

- start fisheye & mysql daemon

```
docker-compose up -d
```

- default db(mysql8.0) configure:

```bash
driver=mysql
host=mysql-fisheye
port=3306
db=fisheye
user=root
passwd=123456
```

## How to run with docker

- start fisheye

```
docker volume create fisheye_home_data && docker network create fisheye-network && docker run -p 8090:8090 -v fisheye_home_data:/var/fisheye --network fisheye-network --name fisheye-srv -e TZ='Asia/Shanghai' haxqer/fisheye:8.7.1
```

- config your own db:


## How to hack fisheye

```
docker exec fisheye-server java -jar /atlassian-agent.jar \
    -d \
    -p fisheye \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

## How to hack fisheye plugin

- .eg I want to use BigGantt plugin
1. Install BigGantt from fisheye marketplace.
2. Find `App Key` of BigGantt is : `eu.softwareplant.biggantt`
3. Execute :

```
docker exec fisheye-server java -jar /var/agent/atlassian-agent.jar \
    -d \
    -p eu.softwareplant.biggantt \
    -m Hello@world.com \
    -n Hello@world.com \
    -o your-org \
    -s you-server-id-xxxx
```

4. Paste your license


## How to upgrade

```shell
cd fisheye && git pull
docker pull haxqer/fisheye:latest && docker-compose stop
docker-compose rm
```

enter `y`, then start server

```shell
docker-compose up -d
```


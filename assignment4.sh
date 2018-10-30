#!/bin/sh

print() {
  printf "\n%b\n" "$1"
}

print "Clone repository"
git clone https://github.com/ramin0/myapp

cd myapp

rm docker-compose.yml
rm main.go

curl -OL https://raw.githubusercontent.com/AmrMKayid/acml-project/assignments/4/docker-compose.yml
curl -OL https://raw.githubusercontent.com/AmrMKayid/acml-project/assignments/4/main_withredis.go
mv main_withredis.go main.go

print "Make sure it is installed successfully:"
go version

print "Install govendor:"
go get -u github.com/kardianos/govendor

govendor fetch github.com/go-redis/redis
govendor fetch github.com/vmihailenco/msgpack
govendor fetch github.com/go-redis/cache
govendor add +e

print "synchronize external packages using govendor"
govendor sync

docker-compose up
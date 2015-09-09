all: atc garden-linux-worker

atc:
	docker build -t taxiway/atc -f atc.Dockerfile .
	docker push taxiway/atc

garden-linux-worker:
	docker build -t taxiway/garden-linux-worker .
	docker push taxiway/garden-linux-worker

NS = kjbreil

REPO = factorio-server
PORTS = -p 27015:27015/tcp -p 34197:34197/udp

.PHONY: 

default: build

build:
	docker build -t $(NS)/$(REPO) .

clean:
	docker build --no-cache -t $(NS)/$(REPO) .

shell:
	docker run --rm --name lgsm-test -it $(PORTS) $(NS)/$(REPO) shell

run:
	docker run --rm --name lgsm-test $(PORTS) $(NS)/$(REPO)

push:
	docker push $(NS)/$(REPO)


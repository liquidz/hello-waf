IRON = ./hello-iron/target/release/hello-iron
NICKEL = ./hello-nickel/target/release/hello-nickel
ROCKET = ./hello-rocket/target/release/hello-rocket
GIN = ./hello-gin/hello-gin
IRIS = ./hello-iris/hello-iris

TOTAL = 1000
CONCURRENT = 100
BIN = $(IRON) $(NICKEL) $(ROCKET) $(GIN) $(IRIS)

all: $(BIN)

$(IRON):
	cd hello-iron && cargo build --release
$(NICKEL):
	cd hello-nickel && cargo build --release
$(ROCKET):
	cd hello-rocket && cargo build --release
$(GIN):
	cd hello-gin && go build
$(IRIS):
	cd hello-iris && go build

init:
	mkdir -p result

kill:
	ps -ef | grep hello- | grep -v grep | awk '{print $$2}' | xargs kill

iron: init $(IRON)
	$(IRON) > /dev/null 2>&1 &
	sleep 1
	ab -n $(TOTAL) -c $(CONCURRENT) http://localhost:3000/ > result/iron.txt
	sleep 1
	ps -ef | grep hello- | grep -v grep | awk '{print $$2}' | xargs kill

nickel: init $(NICKEL)
	$(NICKEL) > /dev/null 2>&1 &
	sleep 1
	ab -n $(TOTAL) -c $(CONCURRENT) http://localhost:3001/ > result/nickel.txt
	sleep 1
	ps -ef | grep hello- | grep -v grep | awk '{print $$2}' | xargs kill

gin: init $(GIN)
	GIN_MODE=release $(GIN) > /dev/null 2>&1 &
	sleep 1
	ab -n $(TOTAL) -c $(CONCURRENT) http://localhost:3002/ > result/gin.txt
	sleep 1
	ps -ef | grep hello- | grep -v grep | awk '{print $$2}' | xargs kill

iris: init $(IRIS)
	$(IRIS) > /dev/null 2>&1 &
	sleep 1
	ab -n $(TOTAL) -c $(CONCURRENT) http://localhost:3003/ > result/iris.txt
	sleep 1
	ps -ef | grep hello- | grep -v grep | awk '{print $$2}' | xargs kill

rocket: init $(ROCKET)
	ROCKET_ENV=prod $(ROCKET) > /dev/null 2>&1 &
	sleep 1
	ab -n $(TOTAL) -c $(CONCURRENT) http://localhost:3004/ > result/rocket.txt
	sleep 1
	ps -ef | grep hello- | grep -v grep | awk '{print $$2}' | xargs kill

test: iron nickel gin iris rocket

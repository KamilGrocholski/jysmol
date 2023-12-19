BIN=bin

SRC_FILES=src/main.c src/vector.c src/str.c src/jysmol-parser.c
OUT_FILE=$(BIN)/main
 
.PHONY: build run clean dev

dev: clean build run

build:
	mkdir -p $(BIN)
	gcc $(SRC_FILES) -o ./$(OUT_FILE)

run:
	./$(OUT_FILE) -h

clean:
	rm -rf $(BIN)


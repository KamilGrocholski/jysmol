INPUT='[  12 ,34,  { "key1" : "value1", "key2"  :   [ ] , "key3": { }, } , true, false, {"k1": true,} , -234, 134, -18.2 , 28.1 , ]'

BUILD=false

TYPESCRIPT=jysmol_typescript
PYTHON=jysmol_python
LUA=jysmol_lua
GO=jysmol_go

.PHONY: b_typescript typescript b_python python b_lua lua b_go go

b_typescript:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(TYPESCRIPT) -f ./$(TYPESCRIPT)/Dockerfile . && echo "Docker image '$(TYPESCRIPT)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(TYPESCRIPT) > /dev/null 2>&1 && \
			echo "Docker image '$(TYPESCRIPT)' already exists." || \
			docker build -t $(TYPESCRIPT) -f ./$(TYPESCRIPT)/Dockerfile . && echo "Docker image '$(TYPESCRIPT)' built successfully."; \
	fi

typescript: b_typescript
	docker run $(TYPESCRIPT) bun run src/input.ts $(INPUT)

b_python:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(PYTHON) -f ./$(PYTHON)/Dockerfile . && echo "Docker image '$(PYTHON)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(PYTHON) > /dev/null 2>&1 && \
			echo "Docker image '$(PYTHON)' already exists." || \
			docker build -t $(PYTHON) -f ./$(PYTHON)/Dockerfile . && echo "Docker image '$(PYTHON)' built successfully."; \
	fi

python: b_python
	docker run $(PYTHON) python input.py $(INPUT)


b_lua:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(LUA) -f ./$(LUA)/Dockerfile . && echo "Docker image '$(LUA)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(LUA) > /dev/null 2>&1 && \
			echo "Docker image '$(LUA)' already exists." || \
			docker build -t $(LUA) -f ./$(LUA)/Dockerfile . && echo "Docker image '$(LUA)' built successfully."; \
	fi

lua: b_lua
	docker run $(LUA) lua src/input.lua $(INPUT)

b_go:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(GO) -f ./$(GO)/Dockerfile . && echo "Docker image '$(GO)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(GO) > /dev/null 2>&1 && \
			echo "Docker image '$(GO)' already exists." || \
			docker build -t $(GO) -f ./$(GO)/Dockerfile . && echo "Docker image '$(GO)' built successfully."; \
	fi

go: b_go
	docker run $(GO) ./input $(INPUT)

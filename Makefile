INPUT='[{"key1": "value1", "key2": 1234, "key3": [1,2,],},]'

BUILD=false

TYPESCRIPT=jysmol_typescript
PYTHON=jysmol_python
LUA=jysmol_lua

.PHONY: b_typescript typescript b_python python b_lua lua

b_typescript:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(TYPESCRIPT) -f ./$(TYPESCRIPT)/Dockerfile . && echo "Docker image '$(TYPESCRIPT)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(TYPESCRIPT) > /dev/null 2>&1 && \
			echo "Docker image '$(TYPESCRIPT)' already exists." || \
			echo "Use 'make build BUILD=true' to force a build."; \
	fi

typescript: b_typescript
	docker run $(TYPESCRIPT) bun run src/input.ts $(INPUT)

b_python:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(PYTHON) -f ./$(PYTHON)/Dockerfile . && echo "Docker image '$(PYTHON)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(PYTHON) > /dev/null 2>&1 && \
			echo "Docker image '$(PYTHON)' already exists." || \
			echo "Use 'make build BUILD=true' to force a build."; \
	fi

python: b_python
	docker run $(PYTHON) python input.py $(INPUT)


b_lua:
	@if [ "$(BUILD)" = "true" ]; then \
		docker build -t $(LUA) -f ./$(LUA)/Dockerfile . && echo "Docker image '$(LUA)' built successfully."; \
	else \
		docker inspect -f '{{.Id}}' $(LUA) > /dev/null 2>&1 && \
			echo "Docker image '$(LUA)' already exists." || \
			echo "Use 'make build BUILD=true' to force a build."; \
	fi

lua: b_lua
	docker run $(LUA) lua src/input.lua $(INPUT)

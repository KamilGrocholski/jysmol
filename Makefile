FILE=example.jysmol

typescript:
	bun run jysmol-typescript/src/parse-file.py $(FILE)

python:
	python3 jysmol-python/parse-file.py $(FILE)

# JYSMOL

## Like the JSON but not. I've done studies, you know. 60% of the time, it works every time

### Desc

#### numbers
- Floats as well as integers may be both negative and positive
- The decimal separator is '.'

#### strings
- Anything between '"' is a string

#### arrays
- Arrays start on '[' and end with ']'
- Trailing commas are required

#### objects
- Objects start on '{' and end with '}'
- Trailing commas are required
- Keys are treated as strings, that means they must be wrapped using '"'

#### keywords
- null
- false
- true

### How to run in a specific language

#### Command
make [language]

#### Example with the default input
```bash
make typescript 
```

#### To run with a different input, change `INPUT` variable inside `Makefile` in the root dir

### Implemented in
- Typescript
- Python

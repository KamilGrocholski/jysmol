# JYSMOL

## Like the JSON but not, works as good as a przeworszczanin on Domestos Haze

### Desc

#### numbers
<p>Floats as well as integers may be both negative and positive</p>
<p>The decimal separator is '.'</p>

#### strings
<p>Anything between '"' is a string</p>

#### arrays
<p>Arrays start on '[' and end with ']'</p>
<p>Trailing commas are required</p>

#### objects
<p>Objects start on '{' and end with '}'</p>
<p>Trailing commas are required</p>
<p>Keys are treated as strings, that means they must be wrapped using '"'</p>

#### keywords
- null
- false
- true

### How to run in a specific language

#### command
make [language] FILE=[optional/file/path]

#### example with the default file
```bash
make typescript 
```

#### example with your file
```bash
make typescript FILE=path/to/file
```

### Implemented in
- Typescript
- Python

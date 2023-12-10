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
make [language] INPUT=[optional input to parse]

#### example with the default input
```bash
make typescript 
```

#### example with your input
```bash
make typescript INPUT='["key1": "value1",]'
```

### Implemented in
- Typescript
- Python

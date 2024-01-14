# jysmol-python

To parse and stringify:
```bash
python3 input.py '[{"key1": "value1",},]'
```

To test parser:

```bash
python3 parser.test.py
```

To test stringify:

```bash
python3 stringifier.test.py
```

To test performance:

```bash
python3 performance.test.py
```

## blazingly fast, at least (:O :d) times slower

```bash
items:, 1000
stringify:
JYSMOL: 0.0018367767333984375
JSON:   0.0009908676147460938
JYSMOL - JSON: 0.0008459091186523438
JYSMOL / JSON: 1.8537054860442734
parse:
JYSMOL: 0.06421375274658203
JSON:   0.0005056858062744141
JYSMOL - JSON: 0.06370806694030762
JYSMOL / JSON: 126.98349834983499
----------------------------------------------------------
items:, 10000
stringify:
JYSMOL: 0.017697811126708984
JSON:   0.009856939315795898
JYSMOL - JSON: 0.007840871810913086
JYSMOL / JSON: 1.795467189125124
parse:
JYSMOL: 0.6418547630310059
JSON:   0.0056285858154296875
JYSMOL - JSON: 0.6362261772155762
JYSMOL / JSON: 114.03481870552355
----------------------------------------------------------
items:, 100000
stringify:
JYSMOL: 0.1807870864868164
JSON:   0.08766460418701172
JYSMOL - JSON: 0.09312248229980469
JYSMOL / JSON: 2.0622586295051293
parse:
JYSMOL: 6.493629455566406
JSON:   0.06759786605834961
JYSMOL - JSON: 6.426031589508057
JYSMOL / JSON: 96.0626397579058
```

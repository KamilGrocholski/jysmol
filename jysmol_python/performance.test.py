import unittest
import time
import json

from jysmol import Jysmol

cases = [1_000, 10_000, 100_000]

class TestPerformance(unittest.TestCase):

    def test_performance(self):
        for items in cases:
            data = generate_array_data(items, 10)

            stringifyStartJYSMOL = time.time()
            stringifiedJYSMOL = Jysmol.stringify(data)
            stringifyEndJYSMOL = time.time()

            parseStartJYSMOL = time.time()
            parsedJYSMOL = Jysmol.parse(stringifiedJYSMOL)
            parseEndJYSMOL = time.time()

            self.assertEqual(parsedJYSMOL, data)

            stringifyStartJSON = time.time()
            stringifiedJSON = json.dumps(data)
            stringifyEndJSON = time.time()

            parseStartJSON = time.time()
            json.loads(stringifiedJSON)
            parseEndJSON = time.time()

            stringifyPerfJYSMOL = stringifyEndJYSMOL - stringifyStartJYSMOL
            parsePerfJYSMOL = parseEndJYSMOL - parseStartJYSMOL

            stringifyPerfJSON = stringifyEndJSON - stringifyStartJSON
            parsePerfJSON = parseEndJSON - parseStartJSON

            print('----------------------------------------------------------')
            print(f'items:, {items}')

            print(f'stringify: ')
            print(f'JYSMOL: {stringifyPerfJYSMOL}')
            print(f'JSON:   {stringifyPerfJSON}')
            print(f'JYSMOL - JSON: {stringifyPerfJYSMOL - stringifyPerfJSON}')
            print(f'JYSMOL / JSON: {stringifyPerfJYSMOL / stringifyPerfJSON}')

            print(f'parse: ')
            print(f'JYSMOL: {parsePerfJYSMOL}')
            print(f'JSON:   {parsePerfJSON}')
            print(f'JYSMOL - JSON: {parsePerfJYSMOL - parsePerfJSON}')
            print(f'JYSMOL / JSON: {parsePerfJYSMOL / parsePerfJSON}')

def generate_item_data(n):
    return {
            "aaaa": n,
            "fasdfsdaf": f'fadsfsai {n}',
            "number": n,
            "name": "nazwasdfsafdsaf" * n
    }

def generate_array_data(n, inner):
    return [generate_item_data(inner) for _ in range(n)]

if __name__ == '__main__':
    unittest.main()


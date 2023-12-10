import sys

from jysmol import Jysmol

def run():
    input = sys.argv[1]
    print('input: ', input)
    parsed = Jysmol.parse(input)
    print('parsed: ', parsed)
    stringified = Jysmol.stringify(parsed)
    print('stringified: ', stringified)
run()

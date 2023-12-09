import sys

from jysmol import Jysmol

def run():
    filepath = sys.argv[1]
    f = open(filepath, "r") 
    content = f.read()
    print(Jysmol.parse(content))

run()

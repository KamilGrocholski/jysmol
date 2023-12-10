from parser import JysmolParser
from stringifier import stringify_value

class Jysmol: 
    @staticmethod
    def parse(input): return JysmolParser.parse(input)

    @staticmethod
    def stringify(value): return stringify_value(value, {})

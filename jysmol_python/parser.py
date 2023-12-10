class JysmolParser:
    ch = ''
    position = -1

    def __init__(self, input):
        self.input = input
        self.input_len = len(input)
        self.__advance()

    @staticmethod
    def parse(input):
        return JysmolParser(input).__parse_value()

    def __advance(self):
        self.position += 1
        if (self.position < self.input_len):
            self.ch = self.input[self.position]
        else:
            self.ch = '\0'

    def __parse_value(self):
        self.__skip_whitespace()

        match (self.ch):
            case '"': return self.__parse_string()
            case '[': return self.__parse_array()
            case '{': return self.__parse_object()

        if (self.ch.isdigit()): return self.__parse_number()
        elif (self.ch == '-'):  
            self.__advance()
            return -self.__parse_number()

        elif (is_aplha(self.ch)):
            return self.__parse_keyword_value()

        raise Exception(f'Unexpected token "{self.ch}", at {self.position}')

    def __parse_keyword_value(self):
        keyword = self.ch
        self.__advance()

        while (is_aplha(self.ch) and self.position < self.input_len):
            keyword += self.ch
            self.__advance()

        match keyword:
            case 'null': return None
            case 'false': return False
            case 'true': return True

        raise Exception(f'invalid keyword: {keyword}, at position {self.position}')

    def __parse_array(self):
        arr = []
        self.__advance()
        self.__skip_whitespace()

        while (self.ch != ']' and self.position < self.input_len):
            arr.append(self.__parse_value())
            self.__skip_whitespace()
            self.__eat(',')
            self.__skip_whitespace()

        self.__eat(']')

        return arr

    def __parse_object(self):
        obj = {}
        self.__advance()
        self.__skip_whitespace()

        while (self.ch != '}' and self.position < self.input_len):
            key = self.__parse_string()
            self.__skip_whitespace()
            self.__eat(':')
            value = self.__parse_value()
            obj[key] = value
            self.__skip_whitespace()
            self.__eat(',')
            self.__skip_whitespace()

        self.__eat('}')

        return obj

    def __parse_string(self):
        lit = ''
        self.__advance()

        while (self.ch != '"' and self.position < self.input_len):
            lit += self.ch
            self.__advance()

        self.__eat('"')

        return lit

    def __parse_number(self):
        lit = self.__parse_integer_literal()
        has_dot = False

        while (self.ch == '.' and self.position < self.input_len):
            has_dot = True
            self.__advance()
            lit += '.'
            lit += self.__parse_integer_literal()

        if (has_dot): return float(lit)
        return int(lit)

    def __parse_integer_literal(self):
        lit = self.ch
        self.__advance()

        while (self.ch.isdigit() and self.position < self.input_len):
            lit += self.ch
            self.__advance()

        return lit

    def __eat(self, ch):
        if (self.ch != ch):
            raise Exception(f'Expected: "{ch}", got: "{self.ch}", at {self.position}')
        self.__advance()

    def __skip_whitespace(self):
        while (is_whitespace(self.ch)):
            self.__advance()
    
def is_whitespace(ch):
    return ch == ' ' or ch == '\n' or ch == '\r' or ch == '\t'

def is_aplha(ch):
    return ch >= 'a' and ch <= 'z' or ch >= 'A' and ch <= 'Z'

package jysmol

import (
	"fmt"
	"strconv"
)

type JysmolParser struct {
	position int
	ch       rune
	input    string
	inputLen int
}

type (
	JysmolValue     interface{}
	JysmolPrimitive interface{}
	JysmolArray     []JysmolValue
	JysmolObject    map[string]JysmolValue
)

func Parse(input string) (JysmolValue, error) {
	p := JysmolParserNew(input)

	p.skipWhitespace()

	return p.parseValue()
}

func JysmolParserNew(input string) *JysmolParser {
	p := &JysmolParser{
		position: -1,
		input:    input,
		inputLen: len(input),
	}

	p.advance()

	return p
}

func (p *JysmolParser) parseValue() (JysmolValue, error) {
	p.skipWhitespace()

	switch p.ch {
	case '"':
		return p.parseString()
	case '[':
		return p.parseArray()
	case '{':
		return p.parseObject()
	}

	if isAlpha(p.ch) {
		return p.parseKeyword()
	}

	if isDigit(p.ch) {
		return p.parseNumber()
	}

	if p.ch == '-' {
		p.advance()
		if isDigit(p.ch) {
			float, err := p.parseNumber()
			if err != nil {
				return 0, err
			}
			return -(float), nil
		}
	}

	return nil, fmt.Errorf("unexpected token: '%s' at position %d", string(p.ch), p.position)
}

func (p *JysmolParser) parseArray() (JysmolArray, error) {
	var arr JysmolArray
	p.advance()
	p.skipWhitespace()

	for p.ch != ']' && p.position < p.inputLen {
		value, err := p.parseValue()
		if err != nil {
			return nil, err
		}
		arr = append(arr, value)
		p.skipWhitespace()
		if err := p.eat(','); err != nil {
			return nil, err
		}
		p.skipWhitespace()
	}

	if err := p.eat(']'); err != nil {
		return nil, err
	}

	return arr, nil
}

func (p *JysmolParser) parseObject() (JysmolObject, error) {
	obj := JysmolObject{}
	p.advance()
	p.skipWhitespace()

	for p.ch != '}' && p.position < p.inputLen {
		key, err := p.parseString()
		if err != nil {
			return nil, err
		}
		p.skipWhitespace()
		p.eat(':')
		value, err := p.parseValue()
		if err != nil {
			return nil, err
		}
		if err := p.eat(','); err != nil {
			return nil, err
		}
		p.skipWhitespace()
		obj[key] = value
	}

	if err := p.eat('}'); err != nil {
		return nil, err
	}

	return obj, nil
}

func (p *JysmolParser) parseNumber() (float64, error) {
	lit := ""
	l, err := p.parseIntLiteral()
	if err != nil {
		return 0, err
	}
	lit += l

	if p.ch == '.' {
		if err := p.eat('.'); err != nil {
			return 0, err
		}
		lit += "."
		l, err := p.parseIntLiteral()
		if err != nil {
			return 0, err
		}
		lit += l
	}

	return strconv.ParseFloat(lit, 64)
}

func (p *JysmolParser) parseIntLiteral() (string, error) {
	lit := string(p.ch)
	p.advance()

	for isDigit(p.ch) && p.position < p.inputLen {
		lit += string(p.ch)
		p.advance()
	}

	return lit, nil
}

func (p *JysmolParser) parseKeyword() (JysmolPrimitive, error) {
	lit := string(p.ch)
	p.advance()

	for isAlpha(p.ch) && p.position < p.inputLen {
		lit += string(p.ch)
		p.advance()
	}

	switch lit {
	case "null":
		return nil, nil
	case "true":
		return true, nil
	case "false":
		return false, nil
	}

	return nil, fmt.Errorf("invalid keyword: %s", lit)
}

func (p *JysmolParser) parseString() (string, error) {
	lit := ""
	p.advance()

	for p.ch != '"' && p.position < p.inputLen {
		lit += string(p.ch)
		p.advance()
	}

	if err := p.eat('"'); err != nil {
		return "", err
	}

	return lit, nil
}

func (p *JysmolParser) advance() {
	p.position++
	if p.position < p.inputLen {
		p.ch = rune(p.input[p.position])
	} else {
		p.ch = '\000'
	}
}

func (p *JysmolParser) skipWhitespace() {
	for p.ch == ' ' || p.ch == '\n' || p.ch == '\r' || p.ch == '\t' {
		p.advance()
	}
}

func (p *JysmolParser) eat(ch rune) error {
	if p.ch != ch {
		return fmt.Errorf("expected: '%s', got: '%s' at position %d", string(ch), string(p.ch), p.position)
	}
	p.advance()

	return nil
}

func isAlpha(ch rune) bool {
	return ch >= 'a' && ch <= 'z' || ch >= 'A' && ch <= 'Z'
}

func isDigit(ch rune) bool {
	return ch >= '0' && ch <= '9'
}

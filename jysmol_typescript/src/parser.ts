export type JysmolType = JysmolObject | JysmolArray | JysmolPrimitive
export type JysmolPrimitive = number | string | null | boolean
export type JysmolObject = {[key: string]: JysmolType}
export type JysmolArray = JysmolType[]

export class JysmolParser {
    private position: number
    private ch!: string

    constructor(private input: string) {
        this.position = -1

        this.advance()
    }

    static parse(input: string): JysmolType {
        const p = new JysmolParser(input)

        return p.parseValue()
    }

    private parseValue(): JysmolType {
        this.skipWhitespace()

        switch (this.ch) {
            case '"':
                return this.parseString()
            case '{':
                return this.parseObject()
            case '[':
                return this.parseArray()
        }

        if (isDigit(this.ch)) return this.parseNumber()
        if (this.ch === '-') {
            this.advance()
            return -this.parseNumber()
        }

        if (isAlpha(this.ch)) return this.parseKeywordValue()

        throw new Error(`unexpected token: '${this.ch}', at position ${this.position}`)
    }

    private parseKeywordValue(): null | boolean {
        const start = this.position
        let end = this.position

        while (isAlpha(this.ch) && this.position < this.input.length) {
            end++
            this.advance()
        }

        const keyword = this.input.slice(start, end)
        switch (keyword) {
            case 'null': return null
            case 'true': return true
            case 'false': return false
        }

        throw new Error(`not allowed keyword: ${keyword}`)
    }

    private parseObject(): JysmolObject {
        const obj: JysmolObject = {}
        this.advance()
        this.skipWhitespace()

        while(this.ch !== '}' && this.position < this.input.length) {
            const key = this.parseString()
            this.skipWhitespace()
            this.eat(':')
            const value = this.parseValue()

            obj[key] = value

            this.skipWhitespace()
            this.eat(',')
            this.skipWhitespace()
        }

        this.skipWhitespace()

        this.eat('}')

        return obj
    }

    private parseArray(): JysmolArray {
        const arr: JysmolArray = []
        this.advance()
        this.skipWhitespace()

        while(this.ch !== ']' && this.position < this.input.length) {
            const value = this.parseValue()
            arr.push(value)

            this.skipWhitespace()
            this.eat(',')
            this.skipWhitespace()
        }

        this.eat(']')

        return arr
    }

    private parseNumber(): number {
        let numberComponents = this.parseIntegerLiteral()

        if (this.ch === '.' ) {
            this.advance()
            numberComponents += '.'
            const newIntegerLiteral = this.parseIntegerLiteral()
            if (!newIntegerLiteral) throw new Error(`. without digit`)
            numberComponents += newIntegerLiteral
        }

        return Number(numberComponents)
    }

    private parseIntegerLiteral(): string {
        const start = this.position
        let end = this.position

        while(isDigit(this.ch) && this.position < this.input.length) {
            end++
            this.advance()
        }

        return this.input.slice(start, end)
    }

    private parseString(): string {
        this.advance()
        const start = this.position
        let end = this.position

        while(this.ch !== '"' && this.position < this.input.length) {
            end++
            this.advance()
        }

        this.eat('"')

        return this.input.slice(start, end)
    }

    private eat(ch: string): void {
        if (this.ch !== ch) throw new Error(
            `expected: '${ch}', got: '${this.ch}', at position ${this.position}`
        )
        this.advance()
    }

    private advance(): void {
        this.position++
        if (this.position < this.input.length) {
            this.ch = this.input[this.position]
        } else {
            this.ch = '\0'
        }
    }

    private skipWhitespace(): void {
        while (isWhitespace(this.ch)) {
            this.advance()
        }
    }
}

function isWhitespace(ch: string): boolean {
    return ch === ' ' || ch === '\n' || ch === '\t' || ch === '\r'
}

function isDigit(ch: string): boolean {
    return ch >= '0' && ch <= '9'
}

function isAlpha(ch: string): boolean {
    return ch >= 'a' && ch <= 'z' || ch >= 'A' && ch <= 'Z'
}

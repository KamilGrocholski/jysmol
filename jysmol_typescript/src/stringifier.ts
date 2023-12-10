export class JysmolStringifier {
    static stringify(input: unknown): string {
        return JysmolStringifier.stringifyByValue(input)
    }

    static stringifyByValue(value: unknown): string {
        if (value === undefined) throw new Error('unsupported type')

        const type = typeof(value)

        switch (type) {
            case 'string': return `"${value}"`
            case 'number': 
            case 'boolean': return `${value}`
        }

        if (value === null) return 'null'
        if (Array.isArray(value)) return this.stringifyArray(value)
        if (type === 'object') return this.stringifyObject(value)

        throw new Error('unsupported type')
    }

    static stringifyObject(obj: object): string {
        let out = '{'

        for (const [key, value] of Object.entries(obj)) {
            const stringifiedKey = `"${key}"`
            const stringifiedValue = JysmolStringifier.stringifyByValue(value)

            out += stringifiedKey
            out += ":"
            out += stringifiedValue
            out += ','
        }

        out += '}'

        return out
    }

    static stringifyArray(arr: unknown[]): string {
        let out = "["

        for (const el of arr) {
            out += JysmolStringifier.stringifyByValue(el)
            out += ','
        }

        out += ']'

        return out
    }
}

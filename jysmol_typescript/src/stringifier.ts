export class JysmolStringifier {
    static stringify(input: unknown): string {
        return JysmolStringifier.stringifyByValue(input)
    }

    static stringifyByValue(value: unknown, stack?: Set<unknown>): string {
        if (value === undefined) throw new Error('unsupported type')

        const type = typeof(value)

        switch (type) {
            case 'string': return `"${value}"`
            case 'number': 
            case 'boolean': return `${value}`
        }

        if (value === null) return 'null'
        if (Array.isArray(value)) {
            return this.stringifyArray(value, stack ?? new Set<unknown>())
        }
        if (type === 'object') { 
            return this.stringifyObject(value, stack ?? new Set<unknown>())
        }

        throw new Error('unsupported type')
    }

    static stringifyObject(obj: object, stack: Set<unknown>): string {
        let out = '{'

        if (stack.has(obj)) this.throwCircularReferenceError()
        stack.add(obj)

        for (const [key, value] of Object.entries(obj)) {

            const stringifiedKey = `"${key}"`
            const stringifiedValue = this.stringifyByValue(value, stack)

            out += stringifiedKey
            out += ":"
            out += stringifiedValue
            out += ','
        }

        out += '}'

        stack.delete(obj)

        return out
    }

    static stringifyArray(arr: unknown[], stack: Set<unknown>): string {
        let out = "["

        if (stack.has(arr)) this.throwCircularReferenceError()
        stack.add(arr)

        for (const el of arr) {
            out += JysmolStringifier.stringifyByValue(el, stack)
            out += ','
        }

        out += ']'

        stack.delete(arr)

        return out
    }

    static throwCircularReferenceError(): void {
        throw new Error('circular reference')
    }
}

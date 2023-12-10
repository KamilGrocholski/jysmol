import Jysmol from '.'

;(async () => {
    const content = process.argv[2]

    console.log('input: ', content)
    const parsed = Jysmol.parse(content)
    console.log('parsed: ', parsed)
    const stringified = Jysmol.stringify(parsed)
    console.log('stringified: ', stringified)
})()


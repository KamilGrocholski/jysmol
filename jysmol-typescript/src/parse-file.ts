import Jysmol from '.'

;(async () => {
    const filepath = process.argv[2]
    const file = Bun.file(filepath)
    const content = await file.text()

    console.log(Jysmol.parse(content))
})()


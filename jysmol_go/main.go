package main

import (
	"fmt"
	"os"

	"jysmol/jysmol"
)

func main() {
	input := os.Args[1]

	parsed, err := jysmol.Parse(input)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Print("parsed: ")
	fmt.Print(parsed)
	fmt.Print("\n")

	stringified, err := jysmol.Stringify(parsed)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Printf("stringified: %s", stringified)
}

package jysmol

import (
	"fmt"
	"testing"
)

func TestStringifyJysmol(t *testing.T) {
    input := -24323
    str, err := Stringify(input)
    fmt.Print("input: ")
    fmt.Print(input)
    fmt.Print("\n")

    if err != nil {
        t.Fatal(err.Error())
    }

    fmt.Printf("stringified: %s\n", str)
}

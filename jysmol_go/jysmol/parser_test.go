package jysmol

import (
	"fmt"
	"testing"
)

func TestParseJysmol(t *testing.T) {
    input := "[\"fasdf\",[],-234,{\"a\": 2, \"b\":[-234.2,],},]"
    str, err := Parse(input)
    fmt.Printf("input: %s\n", input)

    if err != nil {
        t.Fatal(err.Error())
    }

    fmt.Print("parsed: ")
    fmt.Print(str)
    fmt.Print("\n")
}

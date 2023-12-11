package jysmol

import (
	"fmt"
	"strconv"
)

func Stringify(value interface{}) (string, error) {
	return stringifyValue(value)
}

func stringifyValue(value interface{}) (string, error) {
	if v, ok := (value).(int); ok {
		return stringifyInt(v)
	}
	if v, ok := (value).(float64); ok {
		return stringifyFloat(v)
	}
	if v, ok := (value).(string); ok {
		return stringifyString(v)
	}
	if v, ok := (value).(bool); ok {
		return strconv.FormatBool(v), nil
	}
	if (value) == nil {
		return "null", nil
	}
	if v, ok := (value).(JysmolArray); ok {
		return stringifyArray(v)
	}
	if v, ok := (value).(JysmolObject); ok {
		return stringifyObject(v)
	}

	return "", nil
}

func stringifyString(value string) (string, error) {
	return fmt.Sprintf("\"%s\"", value), nil
}

func stringifyInt(value int) (string, error) {
	return fmt.Sprintf("\"%d\"", value), nil
}

func stringifyFloat(value float64) (string, error) {
	return fmt.Sprintf("\"%f\"", value), nil
}

func stringifyArray(arr JysmolArray) (string, error) {
	lit := "["

	for el := range arr {
		v, err := stringifyValue(el)
		if err != nil {
			return "", err
		}
		lit += v
		lit += ","
	}

	lit += "]"

	return lit, nil
}

func stringifyObject(obj JysmolObject) (string, error) {
	lit := "{"

	for key, value := range obj {
		k, err := stringifyString(key)
		if err != nil {
			return "", err
		}
		lit += k
		lit += ":"

		v, err := stringifyValue(value)
		if err != nil {
			return "", err
		}
		lit += v
		lit += ","
	}

	lit += "}"

	return lit, nil
}

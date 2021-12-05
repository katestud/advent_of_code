package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println("PART ONE")
	fmt.Println("Test Input Result:")
	fmt.Println(executeOne("test_input.txt"))

	fmt.Println("Real Input Result:")
	fmt.Println(executeOne("input.txt"))

	fmt.Println("PART TWO")
	fmt.Println("Test Input Result:")
	fmt.Println(executeTwo("test_input.txt"))

	fmt.Println("Real Input Result:")
	fmt.Println(executeTwo("input.txt"))
}

func executeOne(filename string) int {
	x := 0
	y := 0
	lines := readFile(filename)
	for _, l := range lines {
		if strings.TrimSpace(l) == "" {
			break
		}
		dir_and_dist := strings.Split(l, " ")
		dist, _ := strconv.Atoi(dir_and_dist[1])
		switch dir_and_dist[0] {
		case "forward":
			x += dist
		case "down":
			y += dist
		case "up":
			y -= dist
		}
	}
	return x * y
}

func executeTwo(filename string) int {
	x := 0
	y := 0
	aim := 0
	lines := readFile(filename)
	for _, l := range lines {
		if strings.TrimSpace(l) == "" {
			break
		}
		dir_and_dist := strings.Split(l, " ")
		dist, _ := strconv.Atoi(dir_and_dist[1])
		switch dir_and_dist[0] {
		case "forward":
			x += dist
			y += aim * dist
		case "down":
			aim += dist
		case "up":
			aim -= dist
		}
	}
	return x * y
}

func readFile(filename string) []string {
	bs, err := ioutil.ReadFile(filename)
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}
	s := strings.Split(string(bs), "\n")
	return s
}

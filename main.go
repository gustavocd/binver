package main

import (
	_ "embed"
	"flag"
	"fmt"
	"os"

	"github.com/morikuni/aec"
)

var (
	buildTime string
	version   string
)

//go:embed figlet.txt
var binverFigletStr string

func printASCIIArt() {
	binverLogo := aec.LightGreenF.Apply(binverFigletStr)
	fmt.Println(binverLogo)
}

func main() {
	displayVersion := flag.Bool("version", false, "Display version and exit")

	flag.Parse()

	if *displayVersion {
		printASCIIArt()
		fmt.Printf("Version:\t%s\n", version)
		fmt.Printf("Build time:\t%s\n", buildTime)
		os.Exit(1)
	}
}

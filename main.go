package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/morikuni/aec"
)

var (
	buildTime string
	version   string
)

const binverFigletStr = `
_     _                     
| |__ (_)_ ____   _____ _ __ 
| '_ \| | '_ \ \ / / _ \ '__|
| |_) | | | | \ V /  __/ |   
|_.__/|_|_| |_|\_/ \___|_|   
                             
`

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
		os.Exit(0)
	}
}

package main

import (
	"flag"
	"fmt"
	"os"
)

var (
	buildTime string
	version   string
)

func main() {
	displayVersion := flag.Bool("version", false, "Display version and exit")

	flag.Parse()

	if *displayVersion {
		fmt.Printf("Version:\t%s\n", version)
		fmt.Printf("Build time:\t%s\n", buildTime)
		os.Exit(0)
	}
}

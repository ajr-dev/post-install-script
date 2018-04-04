#!/bin/bash

# Test your installation
goDir="$HOME/code/go/src/installed"
mkdir -p $goDir
cat << EOF > $goDir/installed.go
package main

import "fmt"

func main() {
    fmt.Printf("Go succesfully installed\n")
}
EOF
cd $goDir
go run installed.go || { echo "Go wasn't properly installed" 1>&2 ; exit 1 ; }
rm -rf "$goDir"

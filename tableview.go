package main

import (
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"

	"gopkg.in/qml.v1"
)

func main() {
	if err := qml.Run(run); err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
}

type GoData struct {
	Name   string
	Age    string
	Gender string
}

type GoModel struct {
	List []GoData
}

func run() error {
	engine := qml.NewEngine()

	goModel := &GoModel{}
	var gender string
	r := rand.New(rand.NewSource(99))

	for i := 0; i < 5; i++ {
		if r.Float32() > 0.5 {
			gender = "GoMale"
		} else {
			gender = "GoFemale"
		}
		fage := math.Floor(r.Float64() * 100)

		goModel.List = append(goModel.List, GoData{Name: "GoModel " + strconv.Itoa(i), Age: strconv.Itoa(int(fage)), Gender: gender})
	}

	engine.Context().SetVar("goModel", goModel)

	controls, err := engine.LoadFile("main.qml")
	if err != nil {
		return err
	}

	window := controls.CreateWindow(nil)

	window.Show()
	window.Wait()
	return nil
}
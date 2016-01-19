package main

import (
	"fmt"
	"math"
	"math/rand"
	"os"
	"strconv"
	"log"
	"gopkg.in/qml.v1"
)

func main() {
	if err := qml.Run(run); err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}
}

type (
	GoData struct {
		Name   string
		Age    string
		Gender string
	}
	GoModel struct {
		List []GoData
	}
	LModel struct {
		items []*GoData
	}
)

func (l *GoModel) Len() int {
	return len(l.List)
}

func (g *GoModel) Get(index int) GoData {
	return g.List[index]
}

func (g *GoModel) OnAccept(rowid int, columnid int, val string) {
	var _ = rowid
	var _ = columnid
	i := val
	var _ = i
}

func run() error {
	engine := qml.NewEngine()

	goModel := &GoModel{}
	var gender string
	r := rand.New(rand.NewSource(99))

	for i := 0; i < 50; i++ {
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
		log.Println("qml.LoadFile",err)
	}

	window := controls.CreateWindow(nil)

	window.Show()
	window.Wait()
	return nil
}

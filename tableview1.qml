import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    width: 640
    height: 480


    ListModel {
        id: tstModel
        ListElement {
            animal: "dog"
            age: "10"
        }
        ListElement {
            animal: "cat"
            age: "12"
        }
        ListElement {
            animal: "bird"
            age: "1"
        }
        ListElement {
            animal: "elephant"
            age: "20"
        }
        ListElement {
            animal: "turtle"
            age: "100"
        }
    }

    TableView {
        id: tableView
        anchors.fill: parent
        anchors.topMargin: 40
        highlightOnFocus: false
        model: tstModel
        property int currentColumn: 0
        rowDelegate: Rectangle {
            color: "#fff"
        }
        itemDelegate: Rectangle {
            //            color: "transparent"
            color: {
                var bgColor = model.index%2 ? "whitesmoke" : "white"
                var activeRow = tableView.currentRow === styleData.row
                var activeColumn = tableView.currentColumn === styleData.column
                 activeRow && activeColumn ? "steelblue" : bgColor
            }
            Text {
                text: styleData.value
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    print("(onClick) index: (" + model.index + "," + tableView.currentColumn+ ")")
                    tableView.currentRow = styleData.row
                    tableView.currentColumn = styleData.column
                    model.currentIndex = styleData.row
                    parent.forceActiveFocus()
                }
            }
            Keys.onRightPressed: {
                console.log("Delegate Right")
                if (tableView.currentColumn < tableView.columnCount - 1)
                    tableView.currentColumn++
                parent.forceActiveFocus()
                print("(Right) index: (" + tableView.currentRow + "," + tableView.currentColumn+ ")")
            }

            Keys.onLeftPressed: {
                console.log("Delegate Left")
                if (tableView.currentColumn > 0)
                    tableView.currentColumn--
                parent.forceActiveFocus()
                print("(Left) index: (" + tableView.currentRow + "," + tableView.currentColumn+ ")")
            }
        }

        Keys.onRightPressed: {
            print("(Right - Table) index: (" + tableView.currentRow + "," + tableView.currentColumn+ ")")
            if (tableView.currentColumn < tableView.columnCount - 1)
                tableView.currentColumn++
        }

        Keys.onLeftPressed: {
            print("(Left - Table) index: (" + tableView.currentRow + "," + tableView.currentColumn+ ")")
            if (tableView.currentColumn > 0)
                tableView.currentColumn--
        }

        Keys.onUpPressed: {
            print("(Up - Table) index: (" + tableView.currentRow + "," + tableView.currentColumn+ ")")
            if (tableView.currentRow > 0)
                tableView.currentRow--
        }

        Keys.onDownPressed: {
            print("(Down - Table) index: (" + tableView.currentRow + "," + tableView.currentColumn+ ")")
            if (tableView.currentRow < tableView.rowCount - 1)
                tableView.currentRow++
        }

        TableViewColumn {
            id: animalColumn
            title: "Animal"
            role: "animal"
            movable: false
            resizable: false
            width: parent.width / 2
        }
        TableViewColumn {
            id: ageColumn
            title: "Age"
            role: "age"
            movable: false
            resizable: false
            width: parent.width / 2
        }
    }
}

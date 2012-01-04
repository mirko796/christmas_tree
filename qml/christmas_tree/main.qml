// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: container
    width: 500
    height: 700
    focus: true
    Keys.onPressed: {
        Qt.quit();
    }

    Clock {
        id: clock
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        shift: 0
        z:2
        opacity: 0.9
        anchors.leftMargin: 30
        anchors.bottomMargin: 30
        transform: [
            Rotation {
            axis.x: 0
            axis.y: 1
            axis.z: 0
            angle: 25
            },
            Rotation {
            axis.x: 0
            axis.y: 0
            axis.z: 1
            origin.x: 200
            origin.y: 200
            angle: 3
            }
        ]

        SequentialAnimation
        {
            loops: Animation.Infinite
            running: true
            NumberAnimation {
                from: 0.07
                to: 0.9
                property: "baseOpacity"
                target: clock
                duration: 3000
                easing.type: Easing.InCubic
            }
            PauseAnimation { duration: 3000 }
            NumberAnimation {
                from: 0.9
                to: 0.07
                property: "baseOpacity"
                target: clock
                duration: 2000
            }
            PauseAnimation { duration: 3000 }
        }

    }
MouseArea{
    z: 12
    anchors.fill: parent
    onClicked: {
        Qt.quit();
    }
}
    Image {
        id: lights_on
        anchors.fill: parent
        source: "qrc:/lights_on.png"
        z:1
        smooth: true
        SequentialAnimation
        {
            loops: Animation.Infinite
            running: true
            NumberAnimation {
                from: 0.01
                to: 1.0
                property: "opacity"
                target: lights_on
                duration: 3000
            }
            PauseAnimation { duration: 3000 }
            NumberAnimation {
                from: 1
                to: 0.01
                property: "opacity"
                target: lights_on
                duration: 2000
            }
            PauseAnimation { duration: 3000 }
        }
    }
    Image {
        id: lights_off
        anchors.fill: parent
        source: "qrc:/lights_off.png"
        z:0
        smooth: true
    }
}

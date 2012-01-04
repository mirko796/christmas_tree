/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0

Item {
    id: clock
    width: 400; height: 400
    property alias baseOpacity: clock_base.opacity
    property alias city: cityLabel.text
    property int hours
    property int minutes
    property int seconds 
    property real shift
    property bool night: false

    function timeChanged() {
        var date = new Date;
        hours = shift ? date.getUTCHours() + Math.floor(clock.shift) : date.getHours()
        night = ( hours < 7 || hours > 19 )
        minutes = shift ? date.getUTCMinutes() + ((clock.shift % 1) * 60) : date.getMinutes()
        seconds = date.getUTCSeconds();
        digital_clock.text= Qt.formatTime(date,"hh:mm");
    }
    Text{
        id: digital_clock
        font.family: "Garamond"
        font.pixelSize: 80
        font.bold: false
        opacity: 0.8
        z:4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 50
    }

    Timer {
        interval: 1000; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }
    Image {
        x: 200-width/2; y: 210-height
        z: 10
        source: "qrc:/hour_hand.png"
        smooth: true
        transform: Rotation {
            id: hourRotation
            origin.x: 11; origin.y: 121;
            angle: (clock.hours * 30) + (clock.minutes * 0.5)
            Behavior on angle {
                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
            }
        }
    }

    Image {
        x: 200-width/2; y: 210-height
        z: 10
        source: "qrc:/minute_hand.png"
        smooth: true
        transform: Rotation {
            id: minuteRotation
            origin.x: 16; origin.y: 170;
            angle: clock.minutes * 6
            Behavior on angle {
                SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
            }
        }
    }

    Image {
        id: clock_base
        anchors.centerIn: parent; source: "qrc:/clock_base.png"
        opacity: 0.8
    }

    Text {
        id: cityLabel
        y: 200; anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        font.bold: true; font.pixelSize: 14
        style: Text.Raised; styleColor: "black"
    }
}

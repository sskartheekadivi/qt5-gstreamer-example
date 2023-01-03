import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Window {
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: root1
        width: parent.width / 2
        height: parent.height
        color: "#77cc44"

        MediaPlayer {
            id: mediaplayer1
            source: "gst-pipeline: v4l2src ! video/x-raw,framerate=30/1 ! decodebin ! videoconvert ! qtvideosink"
            autoPlay: true
        }

        VideoOutput {
            id: camoutput
            width: parent.width
            height: parent.height
            source: mediaplayer1
        }

        Button {
            id: cameraplaypause
            text: "Camera Pause"
            height: parent.height / 10
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            onClicked: (mouse)=> {
                if (mediaplayer1.playbackState===1) {
                    mediaplayer1.pause();
                    root1.change()
                }
                else if (mediaplayer1.playbackState===2) {
                    mediaplayer1.play();
                    root1.change()
                }
            }
        }
        function change() {
            cameraplaypause.text = mediaplayer1.playbackState===2?"Camera Play":"Camera Pause"
        }
    }
    Rectangle {
        id: root2
        anchors.right: parent.right
        width: parent.width / 2
        height: parent.height
        color: "#77cc44"

        MediaPlayer {
            id: mediaplayer2
            source: "gst-pipeline: videotestsrc ! qtvideosink"
            autoPlay: true
        }

        VideoOutput {
            id: videooutput
            width: parent.width
            height: parent.height
            source: mediaplayer2
        }

        Button {
            id: videoplaypause
            text: "Video Pause"
            height: parent.height / 10
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            onClicked: (mouse)=> {
                if (mediaplayer2.playbackState===1) {
                    mediaplayer2.pause();
                    root2.change()
                }
                else if (mediaplayer2.playbackState===2) {
                    mediaplayer2.play();
                    root2.change()
                }
            }
        }
        function change() {
            videoplaypause.text = mediaplayer2.playbackState===2?"Video Play":"Video Pause"
        }
    }
}

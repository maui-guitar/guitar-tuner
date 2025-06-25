import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import org.mauikit.controls as Maui
import QtMultimedia

Maui.ApplicationWindow {

    title: qsTr("Hello World")
    Maui.Style.styleType: Maui.Style.Dark
    Maui.Page
    {
        anchors.fill: parent
        Maui.Controls.showCSD: true

        headBar.leftContent: Maui.ToolButtonMenu
        {
            icon.name: "application-menu"
            MenuItem
            {
                text: i18n("About")
                onTriggered: about()
            }
        }

        ColumnLayout
        {

            anchors.centerIn: parent
            Pane
            {
                Layout.fillWidth: true
                Layout.fillHeight: true

                background: Rectangle
                {
                    color: Maui.Theme.backgroundColor
                    radius: Maui.Style.radiusV
                    border.color: Maui.Theme.alternateBackgroundColor
                }

                MediaPlayer {
                    id: playMusic
                    source: "/home/camilo/Music/record_0011.m4a"
                    audioOutput: AudioOutput
                    {
                        volume: 1.0
                    }
                }


                CaptureSession {
                    id: captureSession

                    audioInput: AudioInput
                    {
                        id: _input
                         device: devices.defaultAudioInput
                    }
                    recorder: MediaRecorder {
                        id: recorder
                        // audioChannelCount: 2
                        // quality: MediaRecorder.VeryHighQuality
                        // encodingMode: MediaRecorder.ConstantBitRateEncoding
                    }

                     audioOutput : AudioOutput
                     {
                         id: _output
                         volume: 0.2
                         device: devices.defaultAudioOutput
                     }
                }

                MediaDevices {
                    id: devices
                }

                Timer {
                       interval: 1000 // Check after 1 second
                       repeat: true
                       running: true
                       onTriggered: {
                           console.log("Audio Sample Rate:", recorder.audioSampleRate);
                       }
                   }

                contentItem: ColumnLayout
                {
                    Label
                    {
                        font.pointSize: 60
                        font.bold: true
                        text: recorder.audioBitRate + " / " + recorder.audioSampleRate
                    }

                    Label
                    {
                        text: recorder.actualLocation
                    }

                    ComboBox
                    {
                        model: devices.audioInputs
                        textRole: "description"

                    }

                    ComboBox
                    {
                        model: devices.audioOutputs
                        textRole: "description"

                    }

                    Slider
                    {
                        Layout.fillWidth: true
                         from : 0
                         to: 100
                         value: recorder.audioBitRate
                         live: false
                         // onValueChanged: recorder.audioBitRate = value
                    }

                    Slider
                    {
                        Layout.fillWidth: true

                         from : 0
                         to: 10
                         value: recorder.audioChannelCount
                         live: false
                         // onValueChanged: recorder.audioChannelCount = value
                    }

                    Slider
                    {
                        Layout.fillWidth: true

                         from : 0
                         to: 10
                         value: recorder.audioSampleRate
                         live: false
                         // onValueChanged: recorder.audioSampleRate = value
                    }

                    Row{
                        Layout.fillWidth: true
                        Button {
                            text: "Record"
                            enabled: recorder.recorderState !== MediaRecorder.RecordingState
                            onClicked: recorder.record()
                        }

                        Button {
                            id: stopButton
                            text: "Stop"
                            enabled: recorder.recorderState === MediaRecorder.RecordingState
                            onClicked: recorder.stop()
                        }

                        Button{
                            text: "Play"
                            onClicked: playMusic.play()
                        }
                    }
                }
            }

            Control
            {
                Maui.Theme.colorSet: Maui.Theme.Window
                Maui.Theme.inherit: false
                Layout.alignment: Qt.AlignCenter


                implicitHeight: 400

                padding: Maui.Style.defaultPadding

                background: Rectangle
                {
                    color: Maui.Theme.backgroundColor
                    radius: Maui.Style.radiusV
                    border.color: Maui.Theme.alternateBackgroundColor
                }

                component TuneButton : Button
                {
                    implicitWidth: 60
                }

                contentItem:  RowLayout
                {
                    spacing: Maui.Style.defaultSpacing
                    Column
                    {
                        Layout.topMargin: spacing
                        Layout.fillHeight: true
                        spacing: height * 0.065
                        TuneButton
                        {
                            text: "D"

                        }

                        TuneButton
                        {
                            text: "D"
                        }

                        TuneButton
                        {
                            text: "D"
                        }
                    }
                    Item {

                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        implicitWidth: _img.implicitWidth
                        Image
                        {
                            id: _img
                            height: parent.height
                            visible: false
                            source: "qrc:/guitars/guitar-headstock.svg"
                            sourceSize.height: 400
                            // sourceSize.width: width
                            fillMode: Image.PreserveAspectFit
                        }

                        MultiEffect
                        {
                            source: _img
                            anchors.fill: _img
                            colorization: 1.0
                            colorizationColor: Maui.Theme.textColor
                        }

                    }

                    Column
                    {
                        Layout.topMargin: spacing
                        Layout.fillHeight: true
                        spacing: height * 0.065
                        TuneButton
                        {
                            text: "D"
                        }

                        TuneButton
                        {
                            text: "D"
                        }

                        TuneButton
                        {
                            text: "D"
                        }
                    }
                }


            }

        }
    }
}

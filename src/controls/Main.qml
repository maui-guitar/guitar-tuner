import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import org.mauikit.controls as Maui

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

                contentItem: Item
                {
                    Label
                    {
                        anchors.fill: parent
                        font.pointSize: 60
                        font.bold: true
                        text: "60 Hz"
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

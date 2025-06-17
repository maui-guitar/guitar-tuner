import QtQuick
import QtQuick.Controls
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
    }
}

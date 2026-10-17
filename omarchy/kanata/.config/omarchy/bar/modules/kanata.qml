import QtQuick
import Quickshell.Io

// Kanata home row mods indicator.
// Listens to kanata's TCP server (--port 127.0.0.1:5829 in kanata.service).
// Click toggles HRM on/off.
Item {
  id: root
  property var bar
  property string moduleName
  property var settings

  property bool connected: false
  property bool hrmOn: true

  readonly property var offLayers: ["vanilla", "numsvanilla"]
  readonly property var onLayers: ["base", "nums"]

  implicitWidth: 28
  implicitHeight: bar ? bar.barSize : 26

  Process {
    id: listener
    running: true
    command: ["bash", "-c", "exec 3<>/dev/tcp/127.0.0.1/5829 && cat <&3"]
    stdout: SplitParser {
      onRead: function(line) {
        try {
          const layer = JSON.parse(line).LayerChange?.new
          if (!layer) return
          root.connected = true
          // "sym" is shared by both modes, so keep the previous state.
          if (root.offLayers.includes(layer)) root.hrmOn = false
          else if (root.onLayers.includes(layer)) root.hrmOn = true
        } catch (e) {}
      }
    }
    onExited: {
      root.connected = false
      reconnect.start()
    }
  }

  Timer {
    id: reconnect
    interval: 3000
    onTriggered: listener.running = true
  }

  Text {
    anchors.centerIn: parent
    text: !root.connected ? "󰌐" : root.hrmOn ? "󰌌" : "󰌐"
    color: !bar ? "white" : root.hrmOn && root.connected ? bar.foreground : bar.urgent
    opacity: root.connected ? 1 : 0.4
    font.family: bar ? bar.fontFamily : "monospace"
    font.pixelSize: 14
  }

  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true
    onClicked: {
      if (!bar || !root.connected) return
      const target = root.hrmOn ? "vanilla" : "base"
      bar.run("printf '%s\\n' '{\"ChangeLayer\":{\"new\":\"" + target + "\"}}' > /dev/tcp/127.0.0.1/5829")
    }
    onEntered: if (bar) bar.showTooltip(root, !root.connected ? "Kanata not running"
      : root.hrmOn ? "Home row mods ON (click to turn off)" : "Home row mods OFF (click to turn on)")
    onExited: if (bar) bar.hideTooltip(root)
  }
}

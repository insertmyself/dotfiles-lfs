pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    property PwNode sink: Pipewire.defaultAudioSink
    property real level: sink?.audio?.volume ?? 0
    property bool muted: sink?.audio?.muted ?? false

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }
}

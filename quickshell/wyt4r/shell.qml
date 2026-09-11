pragma ComponentBehavior: Bound

import Quickshell

ShellRoot {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Variants {
        model: Quickshell.screens

        Bar {
            clockRef: clock
            volumeRef: Volume.level
            brightnessRef: Brightness.level
            workspacesRef: Workspaces.names
            networkRef: Network.value
            batteryRef: Power.battery
            mprisRef: Mpris.player
        }
    }
}

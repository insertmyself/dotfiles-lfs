pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    property MprisPlayer player: {
        for (const player of Mpris.players.values) {
            if (isSpotify(player)) {
                return player;
            }
        }

        return null;
    }

    function isSpotify(player) {
        if (!player) {
            return false;
        }

        const url = player.metadata ? player.metadata["xesam:url"] : "";

        if (player.identity === "Spotify") {
            return true;
        } else if (url && url.includes("open.spotify.com")) {
            return true;
        }

        return false;
    }
}

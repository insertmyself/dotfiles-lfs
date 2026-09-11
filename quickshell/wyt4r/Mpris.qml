pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    property MprisPlayer player: {
        for (const player of Mpris.players.values) {
            if (player.playbackState === MprisPlaybackState.Playing && isSpotify(player)) {
                return player;
            }
        }

        return null;
    }

    function isSpotify(player) {
        const url = player.metadata ? player.metadata["xesam:url"] : "";

        if (player.identity === "Spotify") {
            return true;
        }

        if (url && url.includes("open.spotify.com")) {
            return true;
        }

        return false;
    }
}

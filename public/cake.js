let YouTube = {};
export function youtubeLoaded(YT) {
    YouTube = YT;
}

export function buildCake(cake) {
    if (!YouTube.Player)
        throw "YouTube IFrame API not yet loaded.";
    let CAKE = [];
    cake.map(layer => {
        // I expect elm to have divs created for each id
        CAKE.push(new YouTube.Player(layer, {
            width: window.innerWidth,
            height: window.innerHeight,
            videoId: layer,
            events: {
                "onReady": event => {
                    if (layer === cake[0])
                        event.target.mute();
                    else
                        event.target.setVolume(100 / cake.indexOf(layer));
                    event.target.playVideo();
                },
                "onStateChange": event => {
                    if (layer === cake[0]) {
                        if (event.data > 1)
                            CAKE.slice(1).forEach(video => video.pauseVideo());
                        else if (event.data === 1)
                            CAKE.slice(1).forEach(video => video.playVideo());
                    }
                }
            }
        }));
    });
}

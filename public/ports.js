import { youtubeLoaded, buildCake } from './cake.js';

let youtube = false;

window.onYouTubeIframeAPIReady = () => {
  // YT is a global object now
  youtube = true;
  youtubeLoaded(YT);
};

app.ports.cake.subscribe(async function(cake) {
  try {
    console.dir(youtube);
    buildCake(cake);
  }
  catch (e) {
    while (!youtube) {
      console.log("waiting");
    }
    buildCake(cake);
  }
});

/*
app.ports.play.subscribe(name => {
  const sound = document.getElementById(name);
  if (sound) {
    sound.play();
  } else {
    console.error(`[Audio] Could not play sound "${name}"`);
  }
});

app.ports.saveSettings.subscribe(
  settings => window.localStorage.setItem('settings', JSON.stringify(settings))
);

app.ports.loadSettings.subscribe(() => {
  app.ports.loadSettings.send(window.localStorage.getItem('settings'));
});
*/

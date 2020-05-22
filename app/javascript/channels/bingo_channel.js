import consumer from "./consumer"

const bingoChannel = consumer.subscriptions.create("BingoChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);
    if (!window.location.pathname.startsWith('/bingo')) {
      return;
    }
    var number = document.getElementById('number');
    if (number !== undefined) {
      number.innerHTML = data.content.id;
    }
    var instruction = document.getElementById('instruction');
    if (instruction !== undefined) {
      instruction.innerHTML = data.content.instruction;
    }
    var songName = document.getElementById('song-name');
    if (songName !== undefined && data.content.song_name !== undefined) {
      songName.innerHTML = data.content.song_name;
    }
    var song = document.getElementById('song');
    if (song !== undefined && data.content.song_url !== undefined) {
      song.src = data.content.song_url;
    }
  }
});

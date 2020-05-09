import consumer from "./consumer"

consumer.subscriptions.create("BingoChannel", {
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
    document.getElementById('number').innerHTML = data.content.number;
    document.getElementById('instruction').innerHTML = data.content.instruction;
  }
});

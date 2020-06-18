import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // categorize the data into message objects and sender objects
    var msgObj = data.message
    var sndrObj = data.sender
    var role = data.role
    // append children to #messageSection
    $('#messageSection').prepend(
        '<div>' +'<i>'+role+' -> </i>'+ sndrObj.name+'<br>'+msgObj.content+'<br><br></div>'
    )  
    // limit the number of children element in #messageSection to 10
    var messageSection = $('#messageSection');
    var children =messageSection.children();
    if (children.length > 10)
    {
        children.last().remove();
    }
    // Called when there's incoming data on the websocket for this channel
  }
});

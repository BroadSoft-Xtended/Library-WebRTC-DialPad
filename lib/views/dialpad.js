module.exports = require('bdsft-sdk-view')(DialpadView, {
  template: require('../../js/templates'), 
  style: require('../../js/styles')
})

function DialpadView(eventbus, sound) {
  var self = {};

  self.elements = ['keys'];

  self.listeners = function() {
    self.keys.bind('click', function(e) {
      e.preventDefault();
      sound.playClick();
      eventbus.digit(this.firstChild.nodeValue);
    });
  };

  return self;
}
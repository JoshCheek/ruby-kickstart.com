// presently, radio groups are the only form type that we validate
var radioGroups = {};

var RadioGroup = function() {
  this.radios = jQuery([]);
  this.valid = false;
};

RadioGroup.prototype.add = function(radio) {
  var that = this;
  this.radios.push(radio);
  radio.click(function() { that.valid = true; });
};

var formInitialize = function(form) {
  jQuery('input[type="radio"]', form).each( function(index, element) {
    element = jQuery(element);
    var name = element.attr('name');
    radioGroups[name] || (radioGroups[name] = new RadioGroup());
    radioGroups[name].add(element);
  });
};

jQuery(function(){
  formInitialize(jQuery('form'));
});

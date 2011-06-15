// I don't really know JavaScript. A lot of this code makes
// me think "What the fuck, JavaScript / jQuery?"
// 
// If you look at it and think "What the fuck, Josh?" instead,
// then totally let me know the right way to do this.


// presently, radio groups are the only form type that we validate
var radioGroups = {};

radioGroups.areAll = function(predicate) {
  var allTrue = true;
  jQuery.each(radioGroups, function(groupName, radioGroup) {
    if((radioGroup instanceof RadioGroup) && !predicate(radioGroup))
      allTrue = false;
  });
  return allTrue;
};

var RadioGroup = function() {
  this.radios = jQuery([]);
  this.isValid = false;
};

RadioGroup.prototype.add = function(radio) {
  var that = this;
  this.radios.push(radio);
  radio.click(function() { that.isValid = true; });
};

var formInitialize = function(form) {
  // create the RadioGroups
  jQuery('input[type="radio"]', form).each( function(index, element) {
    element = jQuery(element);
    var name = element.attr('name');
    radioGroups[name] || (radioGroups[name] = new RadioGroup());
    radioGroups[name].add(element);
  });
  
  // allow radioGroups to know if all their contents are valid
  radioGroups.isValid = function() {
    return radioGroups.areAll(function(radioGroup) {
      return radioGroup.isValid;
    })
  };
  
  // callback for validation before submission
  form.submit(function(event) {
    if(!radioGroups.isValid()) {
      event.preventDefault();
    }
    return true;
  });
};

jQuery(function(){
  formInitialize(jQuery('form'));
});

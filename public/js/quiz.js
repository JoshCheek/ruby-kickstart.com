// I don't really know JavaScript. A lot of this code makes
// me think "What the fuck, JavaScript / jQuery?"
// 
// If you look at it and think "What the fuck, Josh?" instead,
// then totally let me know the right way to do this.


// =====  quizQuestions  =====
// an array of quizQuestions that need to be validated
var quizQuestions = [];

quizQuestions.areAll = function(predicate) {
  var allTrue = true;
  jQuery.each(this, function(index, quizQuestion) {
    if(!predicate(quizQuestion))
      allTrue = false;
  });
  return allTrue;
};

quizQuestions.isValid = function() {
  return quizQuestions.areAll(function(quizQuestion) {
    return quizQuestion.isValid();
  })
};

quizQuestions.markInvalids = function() {
  jQuery.each(this, function(index, quizQuestion) {
    quizQuestion.markIfInvalid();
  });
};

quizQuestions.firstInvalid = function() {
  return jQuery.grep(this, function(quizQuestion) {
    return !quizQuestion.isValid();
  })[0];
};


// =====  RadioGroup  =====
// currently the only kind of quizQuestion
var RadioGroup = function($div) {
  this.div      =   $div;
  this.radios   =   jQuery([]);
  
  var that = this;
  jQuery('input[type="radio"]', $div).each(function(index, radio) {
    that.add(jQuery(radio));
  });
};

RadioGroup.prototype.add = function($radio) {
  var that = this;
  this.radios.push($radio);
  $radio.click(function() { 
    that.div.removeClass("invalid");
  });
};

RadioGroup.prototype.markIfInvalid = function() {
  if(this.isValid()) return;
  this.div.addClass("invalid");
};

RadioGroup.prototype.top = function() {
  return this.div.offset().top;
}

RadioGroup.prototype.isValid = function() {
  var hasChecked = false;
  jQuery.each(this.radios, function(index, $radio) {
    if("checked" == $radio.attr("checked")) 
      hasChecked = true;
  });
  return hasChecked;
}

// =====  Initialization Code  =====
var formInitialize = function(form) {
  jQuery('.quizPredicateProblem, .quizMultipleChoiceProblem').each( function(index, div) {
    $div = jQuery(div);
    quizQuestions.push(new RadioGroup($div));
  });
      
  // callback for validation before submission
  // mark invalid quizQuestions, scroll to first invalid.
  form.submit(function(event) {
    if(!quizQuestions.isValid()) {
      quizQuestions.markInvalids();
      event.preventDefault();
      var firstInvalid = quizQuestions.firstInvalid();
      jQuery(document).scrollTop(firstInvalid.top());
    }
  });
};

jQuery(function(){
  formInitialize(jQuery('form'));
});


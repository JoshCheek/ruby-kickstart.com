// I don't really know JavaScript. A lot of this code makes
// me think "What the fuck, JavaScript / jQuery?"
// 
// If you look at it and think "What the fuck, Josh?" instead,
// then totally let me know the right way to do this.


// =====  toValidate  =====
// an array of quizQuestions that need to be validated
var toValidate = [];

toValidate.areAll = function(predicate) {
  var allTrue = true;
  jQuery.each(this, function(index, quizQuestion) {
    if(!predicate(quizQuestion))
      allTrue = false;
  });
  return allTrue;
};

toValidate.isValid = function() {
  return toValidate.areAll(function(quizQuestion) {
    return quizQuestion.isValid;
  })
};

toValidate.markInvalid = function() {
  jQuery.each(this, function(index, quizQuestion) {
    quizQuestion.markIfInvalid();
  });
};

toValidate.firstInvalid = function() {
  return jQuery.grep(this, function(quizQuestion) {
    return !quizQuestion.isValid;
  })[0];
};


// =====  RadioGroup  =====
// currently the only kind of quizQuestion
var RadioGroup = function($div) {
  this.div      =   $div;
  this.radios   =   jQuery([]);
  this.isValid  =   false;
  
  var that = this;
  jQuery('input[type="radio"]', $div).each( function(index, radio) {
    that.add(jQuery(radio));
  });
};

RadioGroup.prototype.add = function($radio) {
  var that = this;
  this.radios.push($radio);
  $radio.click(function() { 
    that.isValid = true; 
    that.div.removeClass("invalid");
  });
};

RadioGroup.prototype.markIfInvalid = function() {
  if(this.isValid) return;
  this.div.addClass("invalid");
};

RadioGroup.prototype.top = function() {
  return this.div.offset().top;
}

// =====  Invalid Quiz Handling  =====
var notifyUserOfInvalidQuiz = function() {
  toValidate.markInvalid();
  alert("Quiz questions that must be answered have been marked.");
};

// =====  Initialization Code  =====
var formInitialize = function(form) {
  jQuery('.quizPredicateProblem, .quizMultipleChoiceProblem').each( function(index, div) {
    $div = jQuery(div);
    toValidate.push(new RadioGroup($div));
  });
      
  // callback for validation before submission
  // mark invalid quizQuestions, scroll to first invalid.
  form.submit(function(event) {
    if(!toValidate.isValid()) {
      toValidate.markInvalid();
      event.preventDefault();
      var firstInvalid = toValidate.firstInvalid();
      jQuery(document).scrollTop(firstInvalid.top());
    }
  });
};

jQuery(function(){
  formInitialize(jQuery('form'));
});


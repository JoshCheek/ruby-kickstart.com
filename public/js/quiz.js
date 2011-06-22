// I am a native Ruby speaker, but still a foreigner to JS.
// If you look through this and think there is something that
// could be better, let me know.



// =====  quizQuestions  =====
// an array of quizQuestions that need to be validated
var quizQuestions = [];

quizQuestions.areAll = function(predicate) {
  for(var index=0; index < this.length; ++index)
    if(!predicate(this[index])) 
      return false;
  return true;
};

quizQuestions.isValid = function() {
  return quizQuestions.areAll(function(quizQuestion) {
    return quizQuestion.isValid();
  })
};

// returns first invalid, or null
quizQuestions.markInvalids = function() {
  var indexOfFirst = null;
  jQuery.each(this, function(index, quizQuestion) {
    if( quizQuestion.markIfInvalid() && indexOfFirst == null )
      indexOfFirst = index;
  });
  return this[indexOfFirst];
};


// =====  RadioGroup  =====
// currently the only kind of quizQuestion
var RadioGroup = function($div) {
  this.div      =   $div; // I think this is a convention, $ indicates the jQuery div, not raw DOM div (It was getting confusing)
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

// returns true if it marked itself invalid
RadioGroup.prototype.markIfInvalid = function() {
  if(this.isValid()) return false;
  this.div.addClass("invalid");
  return true;
};

RadioGroup.prototype.top = function() {
  return this.div.offset().top;
}

// Here I have to use a flag to track whether I've seen it yet or not, I
// really hate that, but can't think of any other way. 
// 
// Also, the "checked" == $radio.attr("checked") is gross. I figured
// out that I can do $radio[0].checked, but that seems really unintuitive
// 
// If any JS gurus read this, please, show me the right way to do it!
RadioGroup.prototype.isValid = function() {
  var hasChecked = false;
  jQuery.each(this.radios, function(index, $radio) {
    if("checked" == $radio.attr("checked")){  
      hasChecked = true;
      return false;
    }
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
      event.preventDefault();
      var firstInvalid = quizQuestions.markInvalids();
      jQuery(document).scrollTop(firstInvalid.top());
    }
  });
};

jQuery(function(){
  formInitialize(jQuery('form[name="quiz"]'));
});


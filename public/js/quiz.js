// I don't really know JavaScript. A lot of this code makes
// me think "What the fuck, JavaScript / jQuery?", I'll try
// to comment where this is, and why. Maybe show a snippet
// of how I'd do it in Ruby. If you know jQuery well, then
// maybe take a look and let me know if there's a better way
// to do this stuff. 


// =====  quizQuestions  =====
// an array of quizQuestions that need to be validated
var quizQuestions = [];

// Issues: Okay, I am setting a flag! OMG, I can't remember
// the last time I set a flag :( I want to find the first element
// where my function is true, but can't figure out how to do it.
// In Ruby I wouldn't even have to write this method, b/c it
// already exists http://ruby-doc.org/core/classes/Enumerable.html#M001499
// but it would basically look like:
//    def quiz_questions.all?
//      each { |quiz_question| return false unless yield(quiz_question) }
//      true
//    end
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

// Here I just want the first one that matches my criteria
// but I don't know how to find it, so instead, I get *all*
// that match my criteia, then return the first one.
// In Ruby this would be
// def quiz_questions.first_invalid
//   find { |quiz_question| !quiz_question.valid? }
// end
quizQuestions.firstInvalid = function() {
  return jQuery.grep(this, function(quizQuestion) {
    return !quizQuestion.isValid();
  })[0];
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

RadioGroup.prototype.markIfInvalid = function() {
  if(this.isValid()) return;
  this.div.addClass("invalid");
};

RadioGroup.prototype.top = function() {
  return this.div.offset().top;
}

// Another stupid flag thing. I figured out that I can return false
// to break out of the loop so that I at least don't iterate over
// the whole array, but it adds another 2 lines so I'm not sure it's
// worth the complexity it adds.
// 
// Also, the "checked" == $radio.attr("checked") is gross. I figured
// out that I can do $radio[0].checked, but that seems really unintuitive
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
      quizQuestions.markInvalids();
      event.preventDefault();
      var firstInvalid = quizQuestions.firstInvalid();
      jQuery(document).scrollTop(firstInvalid.top());
    }
  });
};

jQuery(function(){
  formInitialize(jQuery('form[name="quiz"]'));
});


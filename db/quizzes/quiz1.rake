namespace :db do  
  task :populate => :quiz1
  task :quiz1 do
    Quiz.add 1, 'Chapter 1 Quiz' do
      problem 'What is a set of instructions called?', :match => /method/i
      problem 'What is 10 / 4', :match => /\b2\b|\btwo\b/i
      problem 'What does the dollar sign mean in cases like "$ ruby -v"', :solution => 3, :options => [
        "It means you get paid if the code works.",
        "It means you should be careful when using this code.",
        "It means you should enter this in your text editor.",
        "It means you should enter this at the command line",
      ]
    end
  end  
end

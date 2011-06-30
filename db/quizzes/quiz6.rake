namespace :db do  
  task :populate => :quiz6
  task :quiz6 => :bootstrap do
    Quiz.add 6, 'Session 6 Quiz' do
      problem 'How are devices located on the internet?', :match => [/ip/i, /address/i]
      problem '`google.com` represents the IP address `74.125.91.103`. What represents the IP address of your computer?', :solution => 0, :options => %w[localhost localhost.com computer self this]
      problem "Once you've located the device, how do you talk to the server?", :solution => 2, :options => [
        'It will be the only application running on that device.',
        'By specifying the name of the server.',
        'By specifying the port number the server is registered on.',
        'Magic.',
      ]
      problem 'Rack allows your application to talk to servers.', :predicate => true
      problem "What do we call the set of libraries and conventions that make it easier to write web applications?", :solution => 2, :options => %w[server rack framework application]
      problem "Which of these is not a web framework?", :solution => 0, :options => %w[Ruby Sinatra Rails]
      problem "When you go to a URL and hit return, what kind of request is this?", :solution => 0, :options => %w[GET POST PUT DELETE]
      problem <<-PROBLEM, :solution => 0, :options => %w[(a) (b) (c)]
        How would you match a GET request to the root of your application?
        
        {: lang='ruby'}
            get '/' do  # (a)
              # ...
            end
            
            post 'root' do  # (b)
              # ...
            end

            if request.get? && request.path.root? # (c)
              # ...
            end
      PROBLEM
      problem %q(If your HTML had a form like like this `<form action='/quiz-submission' method='post'>`{: lang='ruby'}, how would you write the first line of the route it gets submitted to?),
        :match => %r{\bpost\s+(['"])/quiz-submission\1}
      problem "Given that you're in the same directory as `main.rb`, which contains your Sinatra application, how do you run it? (don't worry about rack)", :match => /ruby\s+main\.rb\b/
      problem "Sinatra, by default, will set the server up on port 4567. What web address would take you to the root URL of your Sinatra application?", :solution => 3, :options => [
        'localhost/',
        '4567:localhost/',
        'localhost.com:4567/',
        'localhost:4567/',
      ]
      problem 'Which ERB tag places the text it evaluates to into the document?', :solution => 1, :options => ['<% ... %>', '<%= ... %>', '< ... >', '#{ ... }']
      problem 'Which route would best match a form submitted to "http://ruby-kickstart.com/quizzes/6"? (ie the form for this quiz)', :solution => 1, :options => [
        "`get '/quizzes/:quiz_number'`{: lang='ruby'}",
        "`post '/quizzes/:quiz_number'`{: lang='ruby'}",
        "`post 'ruby-kickstart.com/quizzes/:quiz_number'`{: lang='ruby'}",
        "`post 'ruby-kickstart.com/quizzes/6'`{: lang='ruby'}",
      ]
      problem "If this input was in a form `<input type='text' name='the_data'>`{: lang='html'}, you could access the contents through `params[:the_data]`{: lang='ruby'}", :predicate => true
      problem "If your route said `erb :quiz`{: lang='ruby'}, what file would Sinatra expect the erb template to be in?", :match => %r{\bviews/quiz\.erb\b}
      problem "How do you get a similar layout across all your views?", :match => /\blayout\.erb\b/
      problem "If you had the route `get '/hello/:first_name'`{: lang='ruby'}, how would you access the first name?", :match => /\bparams\[\s*:first_name\s*\]/
      problem "How would you run your app using rack?", :solution => 3, :options => [
        '`$ ruby config.ru`',
        '`$ ruby main.rb`',
        '`$ rackup main.rb`',
        '`$ rackup config.ru`',
      ]
      problem "Sinatra will serve up static files if they are located in", :solution => 1, :options => %w[views/ public/ root/ config.ru]
      problem "Where do you list the gems your app uses?", :solution => 0, :options => %w[Gemfile Gemfile.lock config.ru main.rb]
      problem "After specifying what gems you want, how do select a set for your app to use?", :solution => 0, :options => [
        '`$ bundle install`',
        'Put them in the Gemfile.lock',
        '`$ gem install gemname` for each of your gems',
      ]
      problem "How do you make sure you're using the gems in your Gemfile.lock?", :solution => 1, :options => [
        'Pray.',
        'Instead of running `$ command` run `$ bundle exec command`.',
        'If you have a Gemfile and Gemfile.lock, then it will just know.',
      ]
      add_problem :many_to_many do
        set_question 'Match each task with the git command to accomplish it.'
        subproblem 'How do you initialize a repository?', '`$ git init`'
        subproblem 'How do you see a list of files that are different from your repository?', '`$ git status`'
        subproblem 'How do you see the content itself that is different from your repository?', '`$ git diff`'
        subproblem 'How do you put all the files in the current directory to the staging area?', '`$ git add .`'
        subproblem 'How do you put all the files in the staging area into the repository?', '`$ git commit -m "committing changes"`'
        subproblem 'How do you send your code to Heroku?', '`$ git push heroku master`'
        presentation_order [
          "`$ git add .`",
          "`$ git diff`",
          "`$ git init`",
          "`$ git commit -m \"committing changes\"`",
          "`$ git push heroku master`",
          "`$ git status`",
        ]
      end
      problem "After you've got your Gemfile, Gemfile.lock, config.ru, main.rb, and put everything under git, how do you put your app on Heroku?", :solution => 2, :options => [
        '`$ git push heroku master`',
        '`$ bundle install heroku`, and then `$ git push heroku master`',
        '`$ heroku create` and then `$ git push heroku master`',
        '`$ git add heroku master`',
      ]
    end
  end
end



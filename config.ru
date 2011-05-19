run lambda { |env| 
  [ 200, 
    {'Content-Type'=>'text/plain'}, 
    StringIO.new("This site will be getting better in the near future :)\n")
  ]
}
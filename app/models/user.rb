class User < ActiveRecord::Base
  has_many :quiz_takens
end

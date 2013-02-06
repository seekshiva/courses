class Book < ActiveRecord::Base
  attr_accessible :edition, :isbn, :publisher, :title, :year
end

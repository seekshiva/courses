class Topic < ActiveRecord::Base
  belongs_to :course
  attr_accessible :description, :title
end

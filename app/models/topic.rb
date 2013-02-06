class Topic < ActiveRecord::Base
  belongs_to :course
  attr_accessible :course, :description, :title
end

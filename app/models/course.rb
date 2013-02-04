class Course < ActiveRecord::Base
  attr_accessible :credits, :name, :subject_code
  has_many :terms
  has_many :topics
  has_many :departments

  def current_term
    self.terms.reduce(nil) do |current, term|
      if term.is_current?
        current = term
      end
    end
  end
end

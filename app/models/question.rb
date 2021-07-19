class Question < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :role
  belongs_to :mapping
end

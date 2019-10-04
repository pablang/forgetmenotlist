#  item model class
class Item < ApplicationRecord
  validates :text, presence: true
end

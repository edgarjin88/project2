# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Article < ApplicationRecord
  belongs_to :user
  validates :title, :presence => true, length: {minimum: 3, maximum: 50}
  validates :description, :presence => true, length: {minimum: 10, maximum: 300}
  validates :user_id, presence: true
end

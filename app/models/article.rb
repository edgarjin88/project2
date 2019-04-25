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
  has_many :comments
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_one :userlist
  # :article_categoires 를 통해서만 has many를 할 수 있다. 
  validates :title, :presence => true, length: {minimum: 3, maximum: 50}
  validates :description, :presence => true, length: {minimum: 10, maximum: 300}
  validates :user_id, presence: true
end

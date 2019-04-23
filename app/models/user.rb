# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  admin           :boolean          default(FALSE)
#

class User< ApplicationRecord
  has_many :articles
  before_save { self.email = email.downcase}
  # self.email의 기본 벨류를 다시 다운케이스 하는 거다. 왜냐면 저장 전에 이미 self.eamil에 벨류가
  # 어사인 되어 있으니까. 
  validates :username, presence: true, uniqueness: {case_sensitive: false}, 
  length: {minimum: 3, maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 100},
            uniqueness: {case_sensitive: false},
            format: { with: VALID_EMAIL_REGEX}
  
            
  has_secure_password

end
 

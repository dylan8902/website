class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :local_tags
  has_many :train_journeys
  has_many :user_twitter_accounts
  has_many :episodes


  def twitter
    return self.user_twitter_accounts.first
  end


  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end

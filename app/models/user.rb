class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  belongs_to :store

  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :username, presence: true,
                       uniqueness: true

  has_attached_file :image, styles: {
    thumb: '100x100#',
    square: '200x200#'
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def registered_user?
    roles.exists?(name: "registered_user")
  end

  def store_admin?
    roles.exists?(name: "business_admin")
  end

  def store_submitted?
    if (self.store_id != nil) && (Store.find(self.store_id).status == "Pending")
      true
    end
  end

end

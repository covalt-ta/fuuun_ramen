# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  display     :boolean          default(FALSE)
#  name        :string(255)      not null
#  price       :integer          not null
#  text        :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  admin_id    :bigint           not null
#  category_id :integer          not null
#
# Indexes
#
#  index_products_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to :admin
  has_one_attached :image
  has_many :product_toppings, dependent: :restrict_with_error
  has_many :product_eats, dependent: :destroy
  has_many :comments, dependent: :destroy

  include Hashid::Rails

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :text, length: { maximum: 1000 }
    validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999_999 }
    validates :category_id, numericality: { other_than: 1}
    validates :image
    validates :admin_id
  end

  def category_name
    category = Category.find(category_id)
    category.name
  end

  def self.set_ranking
    where(display: true).joins(:product_eats).group("products.id").order("count_all DESC").count.keys
  end
end

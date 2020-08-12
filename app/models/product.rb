class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to :admin

  with_options presence: true do
    validates :name, length: { maxmum: 40 }
    validates :text, length: { maxmum: 1000 }
    validates :price
    validates :category_id, numericality: { other_than: 1}
    validates :admin_id
  end
end

class Category < ApplicationRecord

#カテゴリ名をenumで管理
  enum name: { アクアリウム:0, アクアテラリウム:1, テラリウム:2, ビオトープ:3 }

  has_many :post_categories
  has_many :posts, through: :post_categories
end

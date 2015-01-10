class Product < ActiveRecord::Base
has_many :line_items
has_many :orders, through: :line_items

before_destroy :ensure_not_referenced_by_any_line_item
private

#この商品を参照している品目がないことを確認する。
def ensure_not_referenced_by_any_line_item
if line_items.empty?
return true
else
errors.add(:base,'品目が存在します')
return false
end
end
end

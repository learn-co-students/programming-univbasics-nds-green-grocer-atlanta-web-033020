def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    item = collection[i][:item]
    if collection[i].has_value?(name)
      return collection[i]
    else
      i += 1 
    end
  end
  return nil
end

def consolidate_cart(cart)
  cart_array = []
  i = 0 
  while i < cart.length do
    item = find_item_by_name_in_collection(cart[i][:item], cart_array)
      if item 
        item[:count] += 1 
      else 
        item = {
          :item => cart[i][:item],
          :price => cart[i][:price],
          :clearance => cart[i][:clearance],
          :count => 1
        }
      cart_array.push(item)
    end
    i += 1 
  end 
  cart_array
end

def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length do 
    item = find_item_by_name_in_collection(coupons[i][:item], cart)
    c_item = "#{coupons[i][:item]} W/COUPON"
    item_w_coupon = find_item_by_name_in_collection(c_item, cart)
    
    if item && item[:count] >= coupons[i][:num]
      if item_w_coupon
        item_w_coupon[:count] += coupons[i][:num]
        item[:count] -= coupons[i][:num]
      else
        item_w_coupon = {
          :item => c_item,
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => item[:clearance],
          :count => coupons[i][:num]
        }
        cart << item_w_coupon
        item[:count] -= coupons[i][:num]
      end
    end
    i += 1 
  end
  cart
end

def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    price = 0 
    if cart[i][:clearance]
      price = cart[i][:price] * 0.8
      cart[i][:price] = price
    end
    i += 1 
  end
  cart
end

def checkout(cart, coupons)
 new_cart = consolidate_cart(cart)
 c_cart = apply_coupons(new_cart, coupons)
 sweet_discounts = apply_clearance(c_cart)
 
 i = 0 
 total_price = 0 
  while i < sweet_discounts.length do 
    total_price += (sweet_discounts[i][:price] * sweet_discounts[i][:count])
    if total_price > 100 
      total_price *= 0.9
    end
    i += 1 
  end 
  total_price.round(2)
 
 
end











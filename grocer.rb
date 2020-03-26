def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  count = 0
  found_item = {}
  
  while collection[count] do
    if collection[count][:item] == name then
      found_item = collection[count]
      return found_item
    end
    count += 1
  end
  
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  count = 0
  
  while cart[count] do
    if find_item_by_name_in_collection(cart[count][:item], new_cart) then
      search_count = 0
      while new_cart[search_count] do
        if new_cart[search_count][:item] == cart[count][:item] then
          new_cart[search_count][:count] += 1
        end
        search_count += 1
      end
    else
      new_cart << cart[count]
      new_cart[-1][:count] = 1
    end
    count += 1
  end
  
  return new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = cart
  count = 0
  
  while coupons[count] do
    cart_count = 0
    coupon_item = {}
    found_item = find_item_by_name_in_collection(coupons[count][:item], cart)

    next if found_item == nil

    if found_item[:count] >= coupons[count][:num]
      coupon_item[:item] = "#{found_item[:item]} W/COUPON"
      coupon_item[:price] = coupons[count][:cost]/coupons[count][:num]
      coupon_item[:clearance] = found_item[:clearance]
      coupon_item[:count] = coupons[count][:num]
  
      new_cart << coupon_item
      while new_cart[cart_count] do
        if new_cart[cart_count][:item] == coupons[count][:item] then
          new_cart[cart_count][:count] -= coupons[count][:num]
        end
        cart_count += 1
      end
    end
    count += 1
  end
  new_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  new_cart = cart
  count = 0
  
  while new_cart[count] do
    if new_cart[count][:clearance] then
      new_cart[count][:price] *= 0.8
      new_cart[count][:price] = new_cart[count][:price].round(2)
    end
    count += 1
  end
  
  new_cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0
  count = 0
  
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart, coupons)
  pp final_cart
  final_cart = apply_clearance(final_cart)
  pp final_cart
  
  while final_cart[count] do
    total += final_cart[count][:price] * final_cart[count][:count]
    count += 1
  end
  
  total *= 0.9 if total > 100
  
  total
end

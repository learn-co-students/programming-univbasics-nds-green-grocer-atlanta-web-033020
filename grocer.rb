def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  
  while index < collection.length do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  index = 0
  arr = []

  while index < cart.length do
    item = find_item_by_name_in_collection(cart[index][:item], arr)
    if item
      item[:count] += 1
    else
      cart[index][:count] = 1
      arr.push(cart[index])
    end
    
    index += 1
  end

  return arr
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  index = 0
  while index < coupons.length do
    item = find_item_by_name_in_collection(coupons[index][:item], cart)

    if item and item[:count] >= coupons[index][:num]
      cart = apply_coupon(item, coupons[index], cart)
    end
    index += 1
  end

  return cart
end

def apply_coupon(item, coupon, cart)
  item[:count] -= coupon[:num]
  item_with_coupon = {
    item: item[:item] + " W/COUPON",
    price: coupon[:cost] / coupon[:num],
    count: coupon[:num],
    clearance: item[:clearance]
  }
  cart.push(item_with_coupon)
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  index = 0
  
  while index < cart.length do
    if cart[index][:clearance]
      cart[index][:price] = (0.8 * cart[index][:price]).round(2)
    end
    index += 1
  end
  
  return cart
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
  
  index = 0
  total = 0

  consolidated_cart = consolidate_cart(cart)
  apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart)

  while index < consolidated_cart.length do
    total += consolidated_cart[index][:count] * consolidated_cart[index][:price]
    index += 1
  end

  if total > 100
    total = total * 0.9
  end
  
  return total
end

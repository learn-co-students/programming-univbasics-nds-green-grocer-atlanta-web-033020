require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0 
  while i < collection.length do
    if (name == collection[i][:item]) 
      return collection[i]
    else
      nil
    i += 1
    end
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  new_cart = []
  i = 0 
  while i < cart.length
    new_cart_item = find_item_by_name_in_collection(cart[i][:item], new_cart)
    if new_cart_item != nil
      #binding.pry
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
      }
      new_cart << new_cart_item
    end
    i += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  counter = 0 
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item != nil && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon 
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[counter][:cost] / coupons[counter][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[counter][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1 
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  counter = 0 
  while counter < cart.length do 
  clearance_price = 0
    if cart[counter][:clearance]
      clearance_price = cart[counter][:price] * 0.8
      cart[counter][:price] = clearance_price.round(2)
    end
  counter += 1 
  end
  cart
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
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  discounted_cart = apply_clearance(couponed_cart)
  counter = 0 
  total = 0
  while counter < discounted_cart.length do
    total += (discounted_cart[counter][:price] * discounted_cart[counter][:count])
    if total > 100 
      total = total * 0.9
    end
    counter += 1
  end
  return total.round(2)
end

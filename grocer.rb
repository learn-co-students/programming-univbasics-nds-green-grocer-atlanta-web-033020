def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
                      i = 0
                      while i < collection.length do
                          if name == collection[i][:item]
                            return collection[i]
                          end
                          i += 1
                          nil
                      end
                      
end




def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
                      cart_count = []
                      x = 0
                      while x < cart.length do
                          
                          cart_item = find_item_by_name_in_collection(cart[x][:item], cart_count)
                          
                          if !cart_item
                            cart_item = {
                              :item => cart[x][:item],
                              :price => cart[x][:price],
                              :clearance => cart[x][:clearance],
                              :count => 1
                            }
                            
                            cart_count << cart_item
                          else
                            cart_item[:count] += 1
                          end
                          
                          x += 1
                      
                      end
                      cart_count
                      
end



def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
                      n = 0
                      while n < coupons.length do
                        cart_item = find_item_by_name_in_collection(coupons[n][:item], cart)
                        couponed_item_name = "#{coupons[n][:item]} W/COUPON"
                        cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
                        
                          if cart_item && cart_item[:count] >= coupons[n][:num]
                            
                              if cart_item_with_coupon
                                cart_item_with_coupon[:count] += [coupons][n][:num]
                                cart_item[:count] -= coupons[n][:num]
                              else
                                cart_item_with_coupon = {
                                  :item => couponed_item_name,
                                  :price => coupons[n][:cost] / coupons[n][:num],
                                  :clearance => cart_item[:clearance],
                                  :count => coupons[n][:num]
                                }
                                
                                cart << cart_item_with_coupon
                                cart_item[:count] -= coupons[n][:num]
                              end
                          end
                        
                          n += 1
                      end
  
                      cart
  
end



def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
                      y = 0
                      while y < cart.length do
                        if cart[y][:clearance]
                          cart[y][:price] = (cart[y][:price] - (cart[y][:price] * 0.2)).round(2)
                        end
                        
                        y += 1
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
  
                      consolidated = consolidate_cart(cart)
                      couponed = apply_coupons(consolidated, coupons)
                      cleared = apply_clearance(couponed)
                      
                      total = 0
                      index = 0
                      while index < cleared.length do
                        total += cleared[index][:price] * cleared[index][:count]
                        index += 1
                      end
                      
                      
                      if total > 100
                        total = (total - (total * 0.1)).round(2)
                      end
                      
                      total
  
end








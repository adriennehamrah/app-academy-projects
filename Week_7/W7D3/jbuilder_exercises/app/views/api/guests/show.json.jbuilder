# json.extract! @guest, :name, :age, :favorite_color

json.partial! 'api/guests/guest', guest: @guest

# json.set! :gifts do
#   json.array! @guest.gifts do |gift|
#     json.partial! 'api/gifts/gift', gift: gift
#   end
# end

json.gifts @guest.gifts, partial: 'api/gifts/gift', as: :gift

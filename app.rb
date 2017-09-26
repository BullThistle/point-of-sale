require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
also_reload 'lib/**/*.rb'
require './lib/item'
require './lib/purchase'
require 'pg'
require 'pry'

get '/' do
  @items = Item.all
  erb :index
end

post '/' do
  name = params.fetch 'name'
  price = params.fetch 'price'
  description = params.fetch 'description'
  Item.create({:name => name, :description => description, :price => price})
  @items = Item.all
  erb :index
end

delete '/item/:id' do
  item = Item.find(params.fetch(:id).to_i)
  item.destroy
  @items = Item.all
  erb :index
end

get '/item/:id' do
  @item = Item.find(params.fetch('id').to_i)
  erb :item_detail
end

post '/item/:id' do
  @item = Item.find(params.fetch('id').to_i)
  name = params.fetch 'name'
  price = params.fetch 'price'
  description = params.fetch 'description'
  @item.update(:id => @item.id, :name => name, :price => price, :description => description)
  erb :item_detail
end

get '/purchase' do
  @items = Item.all
  erb :purchase
end

post '/purchase' do
  id = params[:item].to_i
  Purchase.create({:item_id => id})
  @items = Item.all
  erb :purchase
end

get '/recipt' do
  @purchases = Purchase.all
  erb :recipt
end

post '/recipt' do
  @purchases = Purchase.all
  @purchases.each do |purchase|
    if Item.exists?(:id => purchase.item_id)
      Item.destroy(purchase.item_id)
    end
  end
  erb :recipt
end

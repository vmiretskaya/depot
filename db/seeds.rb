# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all
# . . .
Product.create(title: 'Programming Ruby' ,
description:
%{<p>
Ruby is the fastest growing and most e x c itin g dynamic language
out there. If you need to get working programs delivered fast,
you should add Ruby to your toolbox.
</p>}, 
image_url: 'ruby.jpg',
price: 49.95)

Product.create(title: 'Bike' ,
description:
%{<p>
Cool bike
</p>}, 
image_url: 'bike.jpg',
price: 109.25)

# . . .
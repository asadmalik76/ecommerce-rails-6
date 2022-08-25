# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Coupon.create(code: 'Devntech', discount: 0.3)
Coupon.create(code: 'Pak14', discount: 0.2)
Coupon.create(code: 'E20', discount: 0.5)

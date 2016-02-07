# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
points= Point.create([{name:"MRI Imaging Scanner"},{name:"Angiography"}])
point3 = Point.create(name:"UltraSound")
datum=Datum.create(title:"UltraSText",description:"You're pregnant",url:"http://google.com")
point_data = PointDat.create([{point_id:point3.id,data_id:datum.id}])



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Datum.create([{title:'Test Data',description:'Test Description',
						url:'http://www.w3schools.com/html/mov_bbb.mp4'}])

Point.create(name:"MRI Imaging Scanner")

Point.create(name:"Angiography")

point3 = Point.create(name:"UltraSound")

datum = Datum.create(title:"UltraSText",description:"You're pregnant",url:"http://s.hswstatic.com/gif/mri-10.jpg")
PointDatum.create(point_id:point3.id,datum_id:datum.id,rank:0)

alevelStudent = Audience.create(name:"A-Level")
uniStudent = Audience.create(name:"Uni Student")

DataAudience.create(datum_id:datum.id,audience_id:alevelStudent.id)

DataAudience.create(datum_id:datum.id,audience_id:uniStudent.id)

Tour.create([{name:"Imaging Tour"}])

User.create(email:"dev@mail.com",password:"password")


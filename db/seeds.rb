# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Datum.create([{title:'Test Data',description:'Test Description',
						url:'https://s3-us-west-2.amazonaws.com/hitourbucket/Notes.txt'}])

User.create([{email:"tahmidul786@gmail.com"}])

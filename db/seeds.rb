# Audiences
alevel = Audience.new(name: 'A-Level Student')
uni_student = Audience.new(name: 'University Student')

# Data - Also assigning it's audience
datum1 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum2 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum3 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum4 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum5 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum6 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum7 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum8 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum9 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

datum10 = Datum.create(title: 'Test Data', description: 'Test Description', url: 'http://www.w3schools.com/html/mov_bbb.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)

# Points
point1 = Point.create(name: 'Fluoroscopy')
point2 = Point.create(name: 'Angiography')
point3 = Point.create(name: 'Intravenous Urograms (IVU)')
point4 = Point.create(name: 'Magnetic Resonance Imaging (MRI)')
point5 = Point.create(name: 'Nuclear Medicine')

# Point Data
# For Point 1
PointDatum.create(point_id: point1.id, datum_id: datum1.id)
PointDatum.create(point_id: point1.id, datum_id: datum2.id)

# For Point 2
PointDatum.create(point_id: point2.id, datum_id: datum3.id)
PointDatum.create(point_id: point2.id, datum_id: datum4.id)

# For Point 3
PointDatum.create(point_id: point3.id, datum_id: datum5.id)
PointDatum.create(point_id: point3.id, datum_id: datum6.id)

# For Point 4
PointDatum.create(point_id: point4.id, datum_id: datum7.id)
PointDatum.create(point_id: point4.id, datum_id: datum8.id)

# For Point 5
PointDatum.create(point_id: point5.id, datum_id: datum9.id)
PointDatum.create(point_id: point5.id, datum_id: datum10.id)

# Tours - With Point assignments
tour1 = Tour.new(name: 'Imaging Tour: A-Level', audience_id: alevel.id)
TourPoint.create(tour_id: tour1.id, point_id: point1.id, rank: '1')
TourPoint.create(tour_id: tour1.id, point_id: point2.id, rank: '2')
TourPoint.create(tour_id: tour1.id, point_id: point3.id, rank: '3')

tour2 = Tour.new(name: 'Imaging Tour: University', audience_id: uni_student.id)
TourPoint.create(tour_id: tour2.id, point_id: point4.id, rank: '1')
TourPoint.create(tour_id: tour2.id, point_id: point5.id, rank: '2')
TourPoint.create(tour_id: tour2.id, point_id: point6.id, rank: '3')

# User Related Stuff
User.create(email: 'dev@mail.com', password: 'password')

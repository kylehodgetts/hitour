# Audiences
alevel = Audience.create(name: 'A-Level Student')
uni_student = Audience.create(name: 'University Student')

# Data - Also assigning it's audience
datum1 = Datum.create(title: 'Fluroscopy System Video',
description: 'This video shows a detailed overview of the fluroscopy machine',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/Fluoroscopy/OCH%27s+New+Fluoroscopy+System.mp4')
DataAudience.create(datum_id: datum1.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum1.id, audience_id: uni_student.id)

datum2 = Datum.create(title: 'Fluroscopy Machine',
description: 'A ER45SI edition fluroscopy machine.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/Fluoroscopy/c-arm_fluoroscopy.jpg')
DataAudience.create(datum_id: datum2.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum2.id, audience_id: uni_student.id)

datum3 = Datum.create(title: 'Cerebral Angiography Arteria',
description: 'This is a microscopic look at a arteria. It shows how amazing the human body is. I have also run out of things to write.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/Angiography/Cerebral_angiography%2C_arteria_vertebralis_sinister_injection.jpg')
DataAudience.create(datum_id: datum3.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum3.id, audience_id: uni_student.id)

datum4 = Datum.create(title: 'Angiography Overview',
description: 'A brief overview of what an angiography.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/Angiography/angiography.txt')
DataAudience.create(datum_id: datum4.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum4.id, audience_id: uni_student.id)

datum5 = Datum.create(title: 'MDI Radiology Machine Overview',
description: 'A breif video showing what the MDI radiology machines function. Blah blah.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/IVU/MDI+Radiology+CT+IVP+3D.mp4')
DataAudience.create(datum_id: datum5.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum5.id, audience_id: uni_student.id)

datum6 = Datum.create(title: 'IVU Scan',
description: 'An X-Ray scan of an a persons spine, something to do with IVU.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/IVU/61b13ed65cd0b6785a701239b805fd.PNG')
DataAudience.create(datum_id: datum6.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum6.id, audience_id: uni_student.id)

datum7 = Datum.create(title: 'MRI Scan',
description: 'A man happy to get an MRI scan.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/MRI.JPG')
DataAudience.create(datum_id: datum7.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum7.id, audience_id: uni_student.id)

datum8 = Datum.create(title: 'What is MRI?',
description: 'A breif overview, explaing what MRI is and how it effects you.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/mri.txt')
DataAudience.create(datum_id: datum8.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum8.id, audience_id: uni_student.id)

datum9 = Datum.create(title: 'Nuclear Scan',
description: 'An X-Ray scan of a persons head.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/NuclearMedicine/57339506.jpg')
DataAudience.create(datum_id: datum9.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum9.id, audience_id: uni_student.id)

datum10 = Datum.create(title: 'What is nuclear medicine?',
description: 'A brief essay, explaining the importance of nuclear medicine.',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/NuclearMedicine/nuclear.txt')
DataAudience.create(datum_id: datum10.id, audience_id: alevel.id)
DataAudience.create(datum_id: datum10.id, audience_id: uni_student.id)

# Points
point1 = Point.create(name: 'Fluoroscopy', description: 'This is a test description',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/MRI.JPG')
point2 = Point.create(name: 'Angiography', description: 'This is a test description',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/MRI.JPG')
point3 = Point.create(name: 'Intravenous Urograms (IVU)', description: 'This is a test description',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/MRI.JPG')
point4 = Point.create(name: 'Magnetic Resonance Imaging (MRI)', description: 'This is a test description',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/MRI.JPG')
point5 = Point.create(name: 'Nuclear Medicine', description: 'This is a test description',
url: 'https://s3-us-west-2.amazonaws.com/hitourbucket/ExampleData/MRI/MRI.JPG')

# Point Data
# For Point 1
PointDatum.create(point_id: point1.id, datum_id: datum1.id, rank: '1')
PointDatum.create(point_id: point1.id, datum_id: datum2.id, rank: '2')

# For Point 2
PointDatum.create(point_id: point2.id, datum_id: datum3.id, rank: '1')
PointDatum.create(point_id: point2.id, datum_id: datum4.id, rank: '2')

# For Point 3
PointDatum.create(point_id: point3.id, datum_id: datum5.id, rank: '1')
PointDatum.create(point_id: point3.id, datum_id: datum6.id, rank: '2')

# For Point 4
PointDatum.create(point_id: point4.id, datum_id: datum7.id, rank: '1')
PointDatum.create(point_id: point4.id, datum_id: datum8.id, rank: '2')

# For Point 5
PointDatum.create(point_id: point5.id, datum_id: datum9.id, rank: '1')
PointDatum.create(point_id: point5.id, datum_id: datum10.id, rank: '2')

# Tours - With Point assignments
tour1 = Tour.create(name: 'Imaging Tour: A-Level', audience_id: alevel.id)
TourPoint.create(tour_id: tour1.id, point_id: point1.id, rank: '1')
TourPoint.create(tour_id: tour1.id, point_id: point2.id, rank: '2')
TourPoint.create(tour_id: tour1.id, point_id: point3.id, rank: '3')

tour2 = Tour.create(name: 'Imaging Tour: University', audience_id: uni_student.id)
TourPoint.create(tour_id: tour2.id, point_id: point4.id, rank: '1')
TourPoint.create(tour_id: tour2.id, point_id: point5.id, rank: '2')
TourPoint.create(tour_id: tour2.id, point_id: point2.id, rank: '3')

# User Related Stuff
User.create(email: 'dev@mail.com', password: 'password')

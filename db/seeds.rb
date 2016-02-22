# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Office.create( name: "Office Alpha" )
Office.create( name: "Office Beta" )
Office.create( name: "Office Delta" )

200.times do
	Document.create(
		control: "[OVPD" + DateTime.now.strftime("%Y]") + "-" + SecureRandom.hex,
		office: 1,
	    date: DateTime.now,
	    received_by: FFaker::Name.name,
	    subject: FFaker::Movie.title,
	    outgoing: false
	)
end

200.times do
	Document.create(
		control: "[OVPD" + DateTime.now.strftime("%Y]") + "-" + SecureRandom.hex,
		office: 1,
	    date: DateTime.now,
	    received_by: FFaker::Name.name,
	    subject: FFaker::Movie.title,
	    outgoing: true
	)
end
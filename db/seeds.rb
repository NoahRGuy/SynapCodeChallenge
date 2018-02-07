# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'


participants_text = File.read(Rails.root.join('lib', 'seeds', 'participants.csv'))
weigh_ins_text = File.read(Rails.root.join('lib', 'seeds', 'weighins.csv'))

parts_csv = CSV.parse(participants_text, :headers => true, :encoding => 'ISO-8859-1')
weighs_csv = CSV.parse(weigh_ins_text, :headers => true, :encoding => 'ISO-8859-1')

parts_csv.each do |row|
	p = Person.new
	p.name = row['Name']
	#e = Event.find_or_create_by(row["Event"])
	if !Event.exists?(:name => row['Event'])
		e = Event.create(:name => row['Event'])
		e.created_at = row['Date']
		e.save
	end
	if !League.exists?(:name => row['League'])
		l = League.create(:name => row['League'])
		l.save
	end
	#l = League.find_or_create_by(row['League'])
	p.starting_weight = 0.0
	league = League.find_by(name: row['League'])
	p.league_id = league.id
	p.save
end
p League.first
weighs_csv.each do |row|
	c = Checkin.new
	e = Event.find_by(name: row['Event'])
	p = Person.find_by(name: row['Name'])
	l = LeagueEventJoin.where(:event_id => e.id, :league_id => p.league_id).first_or_create
	if p.starting_weight == 0.0
		p.starting_weight = row['Weight']
	end
	c.person_id = p.id
	c.event_id = e.id
	weight_difference = row['Weight'].to_i - p.starting_weight
	c.delta = weight_difference
	c.created_at = row['Time']
	c.save
	l.save
end
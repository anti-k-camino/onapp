# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Status.create(state: 'waiting for customer')
Status.create(state: 'waiting for stuff response')
Status.create(state: 'canceled')
Status.create(state: 'closed')
Status.create(state: 'on hold')

Department.create(title: 'dept1')
Department.create(title: 'dept2')
Department.create(title: 'dept3')



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

courses = [
           {
             subject_code: "CS402",
             name: "Advanced Database Management Systems",
             credits: 3
           },
           {
             subject_code: "HM402",
             name: "Industrial Economics",
             credits: 3
           },
           {
             subject_code: "CS452",
             name: "Real-Time Systems",
             credits: 3
           }
           
          ]

Course.create(courses)

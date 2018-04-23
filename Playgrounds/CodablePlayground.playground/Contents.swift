//: Playground - noun: a place where people can play

import Foundation

let rawData = """
{
   "courses":[
      {
         "title":"Accelerated iOS with Swift",
         "url":"https://training.bignerdranch.com/classes/accelerated-ios-with-swift",
         "upcoming":[
            {
               "start_date":"2018-04-23",
               "end_date":"2018-04-27",
               "instructors":"Scott Ritchie",
               "location":"Big Nerd Ranch West"
            },
            {
               "start_date":"2018-08-13",
               "end_date":"2018-08-17",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      },
      {
         "title":"iOS Essentials with Swift",
         "url":"https://training.bignerdranch.com/classes/ios-essentials-with-swift",
         "upcoming":[
            {
               "start_date":"2018-06-16",
               "end_date":"2018-06-22",
               "instructors":"Bolot Kerimbaev",
               "location":"Big Nerd Ranch Stone Mountain"
            },
            {
               "start_date":"2018-09-08",
               "end_date":"2018-09-14",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            },
            {
               "start_date":"2018-12-08",
               "end_date":"2018-12-14",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      },
      {
         "title":"Advanced iOS Bootcamp",
         "url":"https://training.bignerdranch.com/classes/advanced-ios-bootcamp",
         "upcoming":[
            {
               "start_date":"2018-06-18",
               "end_date":"2018-06-22",
               "instructors":"Mikey Ward",
               "location":"Big Nerd Ranch West"
            }
         ]
      },
      {
         "title":"Comprehensive Swift",
         "url":"https://training.bignerdranch.com/classes/comprehensive-swift",
         "upcoming":[
            {
               "start_date":"2018-09-24",
               "end_date":"2018-09-28",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      },
      {
         "title":"Android Essentials",
         "url":"https://training.bignerdranch.com/classes/android-essentials",
         "upcoming":[
            {
               "start_date":"2018-06-11",
               "end_date":"2018-06-15",
               "instructors":"David Greenhalgh",
               "location":"Big Nerd Ranch Stone Mountain"
            },
            {
               "start_date":"2018-11-05",
               "end_date":"2018-11-09",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      },
      {
         "title":"Android Essentials with Kotlin",
         "url":"https://training.bignerdranch.com/classes/android-essentials-with-kotlin",
         "upcoming":[
            {
               "start_date":"2018-09-15",
               "end_date":"2018-09-21",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      },
      {
         "title":"Advanced Android",
         "url":"https://training.bignerdranch.com/classes/advanced-android",
         "upcoming":[
            {
               "start_date":"2018-11-26",
               "end_date":"2018-11-30",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      },
      {
         "title":"Full-Stack Essentials with React",
         "url":"https://training.bignerdranch.com/classes/full-stack-essentials-with-react",
         "upcoming":[
            {
               "start_date":"2018-10-15",
               "end_date":"2018-10-19",
               "instructors":"Ned Nerd",
               "location":"Big Nerd Ranch Stone Mountain"
            }
         ]
      }
   ]
}
""".data(using: .utf8)


struct upcoming: Codable {
    let startDate: String
    let endDate: String
    let instructors: String
    let location: String
    
    private enum AllCodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case instructors = "instructors"
        case location = "location"
    }
    
    init(from decoder : Decoder) throws {
        let values  = try decoder.container(keyedBy: AllCodingKeys.self)
        startDate   = try values.decode(String.self, forKey: .startDate)
        endDate     = try values.decode(String.self, forKey: .endDate)
        instructors = try values.decode(String.self, forKey: .instructors)
        location    = try values.decode(String.self, forKey: .location)
    }
}

struct Course: Codable {
    let title: String
    let url: String
    let upcoming: [upcoming]
}

struct Courses: Codable {
    let courses: [Course]
}

do {
    let jsonDecoder = try JSONDecoder().decode(Courses.self, from: rawData!)
    print(jsonDecoder)
}
catch let err {
    print(err)
}









//
//  Time.swift
//  Seazoned
//
//  Created by Apple on 19/06/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import Foundation

class Time
{
    func dateformat(str_date:String)->String
    {
        let format1 = DateFormatter()
        format1.dateFormat="yyyy-MM-dd"
        let date1 = format1.date(from: str_date)
        let format2 = DateFormatter()
        format2.dateFormat="MMM-dd-yyyy"
        let str_result = format2.string(from: date1!)
        return str_result
    }
    func revdateformat(str_date:String)->String
    {
        let format1 = DateFormatter()
     //   format1.dateFormat="MMM-dd-yyyy"
     //   dateFormatter1.dateFormat="MMM-d-yyyy"
 format1.dateFormat="MMM-d-yyyy"
        let date1 = format1.date(from: str_date)
        let format2 = DateFormatter()
        format2.dateFormat="yyyy-MM-dd"
        let str_result = format2.string(from: date1!)
        return str_result
    }
    func timeformat(str_date:String)->String
    {
        let format1 = DateFormatter()
        format1.dateFormat="HH:mm:ss"
        let date1 = format1.date(from: str_date)
        let format2 = DateFormatter()
        format2.dateFormat="h:mm a"
        let str_result = format2.string(from: date1!)
        return str_result
    }
    func revtimeformat(str_date:String)->String
    {
        let format1 = DateFormatter()
        format1.dateFormat="h:mm a"
        let date1 = format1.date(from: str_date)
        let format2 = DateFormatter()
        format2.dateFormat="HH:mm:ss"
        let str_result = format2.string(from: date1!)
        return str_result
    }
}

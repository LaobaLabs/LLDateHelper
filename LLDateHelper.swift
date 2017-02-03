//
//  LLDateHelper.swift
//  TimeSinceLast
//
//  Created by Will Chilcutt on 1/13/17.
//  Copyright © 2017 Laoba Labs. All rights reserved.
//

import Foundation

let kLLDateHelperYearTimeName = "year"
let kLLDateHelperMonthTimeName = "month"
let kLLDateHelperDayTimeName = "day"
let kLLDateHelperHourTimeName = "hour"
let kLLDateHelperMinuteTimeName = "minute"
let kLLDateHelperSecondTimeName = "second"

struct LLDateHelper
{
    func getTimeToDate(fromDate date : NSDate, withNumberOfUnits numberOfUnitsAskedFor : Int) -> String
    {
        let calendar = Calendar.current
        
        let calendarUnits : Set<Calendar.Component> = [.year,
                                                       .month,
                                                       .day,
                                                       .hour,
                                                       .minute,
                                                       .second]
        
        let components = calendar.dateComponents(calendarUnits,
                                                 from: date as Date,
                                                 to: Date())
        var timeStringsArray : [String] = []
        
        let timeValuesArray = [components.year!,
                              components.month!,
                              components.day!,
                              components.hour!,
                              components.minute!,
                              components.second!]
        
        let timeNamesArray = [kLLDateHelperYearTimeName,
                              kLLDateHelperMonthTimeName,
                              kLLDateHelperDayTimeName,
                              kLLDateHelperHourTimeName,
                              kLLDateHelperMinuteTimeName,
                              kLLDateHelperSecondTimeName]
        
        //Loop through each pair (Time value + time name) and if the time value is at least 1, then add it to the timeStringsArray. Also if the value is greate than 2, then add an 's' at the end.
        for index in 0...(timeValuesArray.count - 1)
        {
            let timeValue = timeValuesArray[index]
            let timeName = timeNamesArray[index]

            if timeValue >= 1
            {
                timeStringsArray.append(self.addAnSIfNeeded(withNumber: timeValue, forString: timeName))
            }
        }
        
        var resultString = ""
        
        var stringIndex = 0
        
        //While we have not given them the total numbe of units they have asked for (stringIndex < numberOfUnitsAskedFor)
        //And while the number of units we have given them is not more than the number of units that we actually have.. (stringIndex < timeStringsArray.count)
        //It is possible that the user of this class may have asked for 5 units of time but we only had 1, for example, because maybe it was EXACTLY one week ago
        while stringIndex < numberOfUnitsAskedFor &&
            stringIndex < timeStringsArray.count
        {
            let timeString = timeStringsArray[stringIndex]
            
            if resultString == ""
            {
                resultString = timeString
            }
            else if stringIndex == numberOfUnitsAskedFor - 1
            {
                resultString = resultString + " and \(timeString)"
            }
            else
            {
                resultString = resultString + ", \(timeString)"
            }
            
            stringIndex = stringIndex + 1
        }

        return resultString + " ago!"
    }
    
    func addAnSIfNeeded(withNumber number : Int, forString givenString : String) -> String
    {
        var resultString = "\(number) \(givenString)"
        
        if number > 1
        {
            resultString = resultString + "s"
        }
        
        return resultString
    }
}

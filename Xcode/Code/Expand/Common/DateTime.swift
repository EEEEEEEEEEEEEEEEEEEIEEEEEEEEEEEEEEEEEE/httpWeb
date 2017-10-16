//
//  DateTime.swift
//  HxBitCoin
//
//  Created by Hanxun on 2017/6/15.
//  Copyright © 2017年 Asness. All rights reserved.
//

import UIKit

class DateTime: NSObject {
    
    //MARK:时间转时间戳
    func stringToTimeStamp(stringTime:String)->String {
        
        let dateForMatter = DateFormatter()
        dateForMatter.dateFormat="yyyy年MM月dd日 HH时mm分ss秒"
        let date = dateForMatter.date(from: stringTime)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
    }
    
    
    //MARK:时间戳转时间
    func timeStampToInteger(timeStamp:NSInteger)->NSDate {
        
        let timeSta:TimeInterval = Double(timeStamp)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日 HH时mm分ss秒"
        let date = NSDate(timeIntervalSince1970: timeSta)
        return date
    }
    
    // 获取当前时间
    func getCurrentTime() -> String {
        
        let newDate = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy年MM月dd日 HH时mm分ss秒"
        let nowTime = timeFormatter.string(from: newDate as Date) as String
        return nowTime
    }
    
    func intervalTime(newDate: NSDate, preDate: NSDate) {
        
        let  secondsInterval: Double = newDate.timeIntervalSince(preDate as Date)
        /// 计算相差几分钟
        /// lroundf是一个全局函数，作用是将浮点数四舍五入转为整数。
        _ = lroundf(Float(secondsInterval/60))
    }
    
    /// 时间 -> 时间 
    public func timeStampToInteger(_ timeStamp: NSInteger) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeStamp))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "yyy-MM-dd hh:mm a"
        return dayTimePeriodFormatter.string(from: date as Date)
    }
}

//
//  DancerDetailSchduleManager.swift
//  Hypeclass
//
//  Created by 이성노 on 2022/07/25.
//

import UIKit

class DancerDetailSchduleManager {
    private var dancerScheduleDataArray: [DancerDetailSchedule] = []
    
    func makeDancerData() {
        dancerScheduleDataArray = [
            DancerDetailSchedule(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailSchedule(studioLabel: "호진스튜디오", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailSchedule(studioLabel: "justjerk", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailSchedule(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailSchedule(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailSchedule(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
            DancerDetailSchedule(studioLabel: "1 Million", startTimeLabel: "22:00", endTimeLabel: "24:00"),
        ]
    }
}

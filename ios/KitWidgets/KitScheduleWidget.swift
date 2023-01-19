//
//  KitScheduleWidget.swift
//  KitWidgetsExtension
//
//  Created by MacPro13 on 18/01/2023.
//

import Foundation
import SwiftUI
import WidgetKit



struct ScheduleData: Codable {
    let day: Date?
    let startTime: Date?
    let endTime: Date?
    let subjectName: String?
    let room: String?
    
    static let sample = ScheduleData(
        day: Date(),
        startTime: Calendar.current.date(bySetting: .hour, value: 7, of: Date()),
        endTime: Calendar.current.date(bySetting: .hour, value: 10, of: Date()),
        subjectName: "Lý thuyết cơ sở dữ liệu",
        room: "101TA1"
    )
}

struct ScheduleEntry: TimelineEntry {
    let date: Date
    let data: [ScheduleData]
}

struct ScheduleProvider : TimelineProvider {
    
    
    
    static let dataKey = "gpa-schedule-widget"
    
    func placeholder(in context: Context) -> ScheduleEntry {
        return ScheduleEntry(date: Date(), data: [.sample, .sample])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ScheduleEntry) -> Void) {
        let entry = ScheduleEntry(date: Date(), data: [.sample])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let dataKey = "schedule-widget-data"
        
        var entries: [ScheduleEntry] = []
        
//        let startDate = Date();
        
        if let sharedDefaults = UserDefaults.init(suiteName: "group.kit.schedule") {
            let stringData = sharedDefaults.string(forKey: dataKey)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = stringData?.data(using: .utf8), let convertedList = try? decoder.decode([ScheduleData].self, from: data) {
                entries.append(ScheduleEntry(date: Date(), data: convertedList))
                entries.append(ScheduleEntry(date: Calendar.current.date(byAdding: .minute, value: 15, to: Date())!, data: convertedList))
//                for i in 6...21 {
//                    var date: Date?
//                    if i == 0 {
//                        date = startDate
//                    } else {
//                        let dateWithoutTime = startDate.removeTimeStamp!
//                        date = Calendar.current.date(byAdding: .hour, value: i, to: dateWithoutTime)
//                    }
//                    let filteredSchedules = convertedList.filter { schedule in
//                        if (schedule.day == nil) {
//                            return false
//                        }
//                        return schedule.day!.removeTimeStamp! == date
//                    }
//
//                    let entry = ScheduleEntry(date: date!, data: filteredSchedules)
//                    entries.append(entry)
//                }
            } else {
                print("Error: Could not read string data")
            }
                
        } else {
            print("Error: Could not read user defaults")
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct KitSheduleWidgetView: View  {
    let entry: ScheduleEntry
    
    @Environment(\.colorScheme) private var colorScheme
    
    var data: [ScheduleData] {
        entry.data
    }
    
    
    var emptyView: some View {
        VStack {
            Spacer()
            Text("Không có tiết học hôm nay")
                .foregroundColor(.gray)
                .font(.caption)
            Spacer()
        }
    }
    
    var looseCell : some View {
        HStack (alignment: .center){
            Divider()
                .frame(width: 3, height: .looseScheduleHeight)
                .overlay(Color.appLightBlueColor)
                .cornerRadius(3)
            VStack  (alignment: .leading, spacing: 2){
                
                Text("Công nghệ mạng máy tính (mạng máy tính)")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .padding(.bottom, 1)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                HStack {
                    Text("7:00-9:00")
                        .font(.caption2)
                    Text("101TA2")
                        .font(.caption2)
                    Spacer()
                }
                .foregroundColor(.gray)
                
            }
            
        }
    }
    
    var mediumCell : some View {
        HStack (alignment: .center){
            Divider()
                .frame(width: 3, height: .mediumScheduleHeight)
                .overlay(Color.appLightBlueColor)
                .cornerRadius(3)
            VStack  (alignment: .leading, spacing: 2){
                Text("Công nghệ mạng máy tính (mạng máy tính)")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .padding(.bottom, 1)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                HStack {
                    Text("7:00-9:00")
                        .font(.caption2)
                    Text("101TA2")
                        .font(.caption2)
                    Spacer()
                }
                .foregroundColor(.gray)
                
            }
        }
    }
    
    var smallCell: some View {
        HStack {
            Divider()
                .frame(width: 3, height: .smallScheduleCellHeight)
                .overlay(Color.appLightBlueColor)
                .cornerRadius(3)
            Text("2 khác")
                .font(.caption2)
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        ZStack {
            if colorScheme == .light {
                Color.appBackgroundColor
            }
            
            if (entry.data.isEmpty){
                Text("No data")
            } else {
                VStack (alignment: .leading) {
                    HStack {
                        Text("Lịch Học")
                            .foregroundColor(.appGreyColor)
                            .textCase(.uppercase)
                            .font(.caption2)
                            .fontWeight(.medium)
                        Spacer()
                        
                        Image(systemName: "graduationcap.fill")
                            .foregroundColor(.appGreenColor)
                            .font(.body)
                    }
                    switch data.count {
                    case 0:
                        emptyView
                    case 1:
                        VStack(alignment: .leading) {
                            looseCell
                            Spacer()
                            Text("Không còn tiết học")
                                .font(.caption2)
                                .foregroundColor(.appLightBlueColor)
                            
                        }
                    case 2:
                        VStack {
                            looseCell
                            looseCell
                        }
                    default:
                        VStack (alignment: .leading) {
                            mediumCell
                            mediumCell
                            smallCell
                        }
                    }
                    Spacer()
                }
                .padding(14)
            }
        }
        
        
    }
}

struct ScheduleWidget : Widget {
    let kind = "schedule-widget-data"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ScheduleProvider()) { entry in
            KitSheduleWidgetView(entry: entry)
        }
    }
}



struct KitScheduleWidget_Previews: PreviewProvider {
    static var previews: some View {
        KitSheduleWidgetView(entry: ScheduleEntry(date: Date(), data: [.sample]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDevice(PreviewDevice.init(rawValue: "iPhone 8"))
    }
}

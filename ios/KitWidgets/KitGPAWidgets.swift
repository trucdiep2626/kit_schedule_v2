//
//  KitWidgets.swift
//  KitWidgets
//
//  Created by MacPro13 on 16/01/2023.
//

import WidgetKit
import SwiftUI

extension Color {
    init(r: Int, g: Int, b: Int, a: Int) {
        self.init(red: Double(r) / 255.0, green: Double(g)/255.0, blue: Double(b)/255.0)
    }
    
    static let appPrimaryColor = Color.init(red: 0.10196078431372549, green: 0.13725490196078433, blue: 0.4980392156862745)
    static let appPrimaryLightColor = Color.init(r: 194, g: 221, b: 248, a: 255)
    static let appBackgroundColor = Color.init(r: 252, g: 250, b: 243, a: 255)
}


struct GPAData: Codable {
    let score : Double?
    let passedSubjects: Int?
    let failedSubjects: Int?
    
    var formatedScore: String {
        if score == nil || score! <= 0 {
            return "-/-"
        }
        return score!.formatted()
    }
    
    var textPassedSubjects: String {
        passedSubjects?.formatted() ?? "-"
    }
    
    var textFailedSubjects: String {
        failedSubjects?.formatted() ?? "-"
    }
    
    var levelString: String {
        if let score = score {
            if (score < 2.5) {
                return "Trung binh"
            }
            if score < 3.2 {
                return "Khá"
            }
            
            if score < 3.6 {
                return "Tốt"
            }
            
            return "Xuất sắc"
        }
        return "-"
    }
}

struct GPAProvider: TimelineProvider {
    let dataKey = "gpa-widget-data"
    
    func placeholder(in context: Context) -> GPAEntry {
        GPAEntry(date: Date(), data: GPAData(score: 3.6, passedSubjects: 32, failedSubjects: 0))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (GPAEntry) -> ()) {
        let entry = GPAEntry(date: Date(), data: GPAData(score: 3.6, passedSubjects: 32, failedSubjects: 0))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [GPAEntry] = []
        var gpaData: GPAData?
        
        
        if let sharedData = UserDefaults.init(suiteName: "group.kit.schedule") {
            let stringData = sharedData.string(forKey: dataKey)
            if let data = stringData?.data(using: .utf16),  let convertedGPAModel = try? JSONDecoder().decode(GPAData.self, from: data) {
                gpaData = convertedGPAModel;
            }
        }
        
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        let entry = GPAEntry(date: entryDate, data: gpaData)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct GPAEntry: TimelineEntry {
    let date: Date
    let data: GPAData?
}

struct KitGPAWidgetView : View {
    let minValue = 0.0
    let maxValue = 4.0
    
    @Environment(\.colorScheme) private var colorScheme;
    @Environment(\.widgetFamily) private var widgetFamily;
    
    var entry: GPAProvider.Entry
    
    var acessoryCircularView : some View {
        Gauge(value: entry.data?.score ?? 0, in: 0...4) {
                    Label("GPA", systemImage: "graduationcap.fill")
                } currentValueLabel: {
                    Text(entry.data?.formatedScore ?? "-")
                }
                .gaugeStyle(.accessoryCircular)
    }
    
    var accessoryInlineView : some View {
        HStack {
            Image(systemName: "graduationcap.fill")
            Text("GPA: \(entry.data?.formatedScore ?? "-")")
        }
    }
    
    var accessoryRegtangular : some View {
        GeometryReader { geo in
            HStack (alignment: .center) {
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "graduationcap.fill")
                            .font(.body)
                        Text("GPA của bạn")
                            .font(.body)
                            .fontWeight(.medium)
                            .textCase(.uppercase)
                    }
                        
                    Text(entry.data?.formatedScore ?? "-")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
        }
    }
    
    var gPASystemView : some View {
        ZStack {
            if (colorScheme == .light) {
                Color.appBackgroundColor
            }
            
            VStack (alignment: .leading){
                HStack {
                    Text("GPA của bạn")
                        .textCase(.uppercase)
                        .font(.caption2)
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "graduationcap.fill")
                        .font(.body)
                }
                .foregroundColor(colorScheme == .light ? .appPrimaryColor : .appPrimaryLightColor)
                HStack (alignment: .bottom){
                    Text(entry.data?.formatedScore ?? "-")
                        .font(.system(size: 44, weight: .regular, design: .rounded))
                    Text("/4")
                        .font(.system(size: 22, weight: .regular, design: .rounded))
                        .transformEffect(.init(translationX: -4, y: -5))
                }
                
                .scaledToFill()
                .minimumScaleFactor(0.5)
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Đạt")
                            .font(.caption2)
                        HStack {
                            Text(entry.data?.textPassedSubjects ?? "-")
                                .font(.title2)
                                .foregroundColor(colorScheme == .light ? .appPrimaryColor : .appPrimaryLightColor)
                                .scaledToFill()
                                
                            Text("môn")
                                .font(.caption)
                            
                                .transformEffect(.init(translationX: -5, y: 3.5))
                                .padding(0)
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                            
                        }
                    }
                    .frame(minWidth: 20)
                    
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Chưa đạt")
                            .font(.caption2)
                        HStack {
                            Text(entry.data?.textFailedSubjects ?? "-")
                                .font(.title2)
                                .foregroundColor(colorScheme == .light ? .appPrimaryColor : .appPrimaryLightColor)
                                
                            Text("môn")
                                .font(.caption)
                                .transformEffect(.init(translationX: -5, y: 3.5))
                                .padding(0)
                        }
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    }
                    .frame(minWidth: 20)
//                    .padding(.leading, widgetFamily == .systemMedium ? 18 : 0)
                    if ([WidgetFamily.systemMedium, WidgetFamily.systemLarge].contains(widgetFamily)) {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Học lực")
                                .font(.caption2)
                           
                            HStack {
                                Text(entry.data?.levelString ?? "-")
                                    .font(.title2)
                                    .foregroundColor(colorScheme == .light ? .appPrimaryColor : .appPrimaryLightColor)
                                    
                                
                            }
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        }
                    }
                }
                
            }
            .padding(14)
        }
        

    }
    
    var errorView: some View {
        ZStack {
            if (colorScheme == .light) {
                Color.appBackgroundColor
            }
            
            switch widgetFamily {
            case .accessoryCircular :
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 30))
            case .accessoryRectangular:
                Label("Đăng nhập để xem GPA", systemImage: "exclamationmark.circle.fill")
                    .multilineTextAlignment(.center)
            default:
                VStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                    Text("Đăng nhập để xem GPA")
                }
            }
            
        
            
        }
    }
    
    var body: some View {
        if let _ = entry.data {
            switch widgetFamily {
            case .systemSmall, .systemMedium, .systemLarge, .systemExtraLarge:
                gPASystemView
            case .accessoryInline:
                accessoryInlineView
            case .accessoryCircular:
                acessoryCircularView
            case .accessoryRectangular:
                accessoryRegtangular
            @unknown default:
                gPASystemView
            }
        
        } else {
            errorView
        }
    }
}

struct GPAAccessoryCircularWidget : View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    let gpaData: GPAData
    
    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            Gauge(value: gpaData.score ?? 0, in: 0...4) {
                        Text("GPA")
                    } currentValueLabel: {
                        Text(gpaData.formatedScore)
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("4")
                    }
                    .gaugeStyle(.accessoryCircular)
        default:
            Label("GPA", systemImage: "exclamationmark.circle")
        }
    }
}

struct KitWidgets: Widget {
    let kind: String = "gpa-widget-data"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GPAProvider()) { entry in
            KitGPAWidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular, .accessoryInline, .accessoryRectangular])
        .configurationDisplayName("GPA")
        .description("Cập nhật điểm trung bình học tập của bạn")
    }
}

struct KitWidgets_Previews: PreviewProvider {
    static var previews: some View {
        KitGPAWidgetView(entry: GPAEntry(date: Date(), data: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        KitGPAWidgetView(entry: GPAEntry(date: Date(), data: GPAData(score: 3.6, passedSubjects: 32, failedSubjects: 0)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

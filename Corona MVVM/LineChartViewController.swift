//
//  LineChartViewController.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 08/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    @IBOutlet weak var chartView: LineChartView!
    
    var dailyCounts : [DailyCount] = [] {
        didSet {
            initChart()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initChart() {
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .systemBlue
        yAxis.axisLineColor = .systemBlue
        
//        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.enabled = false
        chartView.doubleTapToZoomEnabled = false
        
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        
        var dataConfirmed: [ChartDataEntry] = []
        var dataDeaths: [ChartDataEntry] = []
        var dataRecovered: [ChartDataEntry] = []
        
        for dailyCount in dailyCounts {
            dataConfirmed.append(dailyCount.getChartDataEntry(status: .confirmed))
            dataRecovered.append(dailyCount.getChartDataEntry(status: .recovered))
            dataDeaths.append(dailyCount.getChartDataEntry(status: .death))
        }
        
        let dataEntries = [dataConfirmed, dataRecovered, dataDeaths]
        
        let lineWidth : CGFloat = 3
        
        let status = [
            "Confirmed",
            "Recovered",
            "Death"
        ]
        
        let colors: [NSUIColor] = [
            .systemBlue,
            .systemGreen,
            .systemRed
        ]
        
        let data = LineChartData()
        
        var i = 0;
        for dataEntry in dataEntries {
            let set = LineChartDataSet(entries: dataEntry, label: status[i])
            set.drawCirclesEnabled = false
            set.mode = .cubicBezier
            set.lineWidth = lineWidth
            set.setColor(colors[i])
            set.fill = Fill(color: colors[i])
            set.fillAlpha = 0.6
            set.drawFilledEnabled = true
            
//            set.drawHorizontalHighlightIndicatorEnabled = false
            
            data.addDataSet(set)
            
            i+=1
        }
        
        data.setDrawValues(false)
        
        chartView.animate(xAxisDuration: 1.5)
        
        chartView.data = data
//        chartView.delegate = self
    }
}

//extension LineChartViewController: ChartViewDelegate {
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        print(entry)
//    }
//}

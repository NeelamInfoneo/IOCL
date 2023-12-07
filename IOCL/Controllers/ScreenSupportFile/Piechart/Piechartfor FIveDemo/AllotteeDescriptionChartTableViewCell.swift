//
//  AllotteeDescriptionChartTableViewCell.swift
//  UPSIDA
//
//  Created by infoneo on 03/03/23.
//

import UIKit
import Charts

class AllotteeDescriptionChartTableViewCell: UITableViewCell {
    //MARK: -VARIABLES-
    let investments = ["1", "2", "3", "4", "5"]
    let colors: [UIColor] = [.appColor(.highlySatisfy), .appColor(.satisfy), .appColor(.needImprovement), .appColor(.disatisfy), .appColor(.highlyDisatify)]
    
    //MARK: -OUTLETS-
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var titleLBl: UILabel!
    @IBOutlet weak var pieChartOuterView: UIView!
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var creditLbl: UILabel!
    @IBOutlet weak var outstandingView: UIView!
    @IBOutlet weak var ourstandingLbl: UILabel!
    @IBOutlet weak var debitView: UIView!
    @IBOutlet weak var debitLbl: UILabel!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var lbl5: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    //MARK: -CELL LIFE CYCLE-
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
        //        setChart(dataPoints: investments, values: units)
    }
    //MARK: -ACTIONS-
    
    //MARK: -FUNCTIONS-
    private func setCell() {
        
        self.backgroundColor = .clear
        selectionStyle = .none
        
        titleLBl.setAppFontColor(.appColor(.black), font: .Inter(.bold, size: .oneSix))
        titleLBl.text = "Description Of Chart"
//        pieChartView.makeRoundCorner(5)
//        pieChartOuterView.dropShadowCustom(shadowColor: .appColor(.black,alpha: 0.4))
        
//        1) Please respond to all questions, 2) If the question is not relevant to you, choose N/A, 3) Kindly provide additional details if your response is 1(Highly Dissatisfied).
//        The scale used is : 5 - Highly Satisfied, 4 - Satisfied, 3 - Needs Improvement, 2 - Dissatisfied, 1 - Highly Dissatisfed, 0 - N/A
        creditView.backgroundColor = .appColor(.highlySatisfy)
        creditLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneOne))
        creditLbl.text = "Highly Satisfied"
        outstandingView.backgroundColor = .appColor(.satisfy)
        ourstandingLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneOne))
        ourstandingLbl.text = "Satisfied"
        debitView.backgroundColor = .appColor(.needImprovement)
        debitLbl.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneOne))
        debitLbl.text = "Needs Improvement"
        
        view4.backgroundColor = .appColor(.disatisfy)
        lbl4.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneOne))
        lbl4.text = "Needs Improvement"
        
        view5.backgroundColor = .appColor(.highlyDisatify)
        lbl5.setAppFontColor(.appColor(.black), font: .Inter(.regular, size: .oneOne))
        lbl5.text = "Needs Improvement"
        
   
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<values.count {
//            let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            
            let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            
            dataEntries.append(dataEntry1)
           
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartData.setValueTextColor(.black)
        pieChartData.setValueFont(UIFont.Inter(.medium, size: .oneOne))
        pieChartDataSet.colors = colors
        pieChartView.noDataText = "No data available"
        pieChartView.legend.enabled = false
        pieChartView.entryLabelFont = .Inter(.regular, size: .oneOne)
        pieChartView.entryLabelColor = .appColor(.black)
        pieChartView.drawHoleEnabled = true
        pieChartView.holeRadiusPercent = 0.2
        pieChartView.drawSlicesUnderHoleEnabled = true
    
        pieChartView.holeColor = .white
        pieChartView.transparentCircleRadiusPercent = 0.4
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.transparentCircleColor = .appColor(.white,alpha: 0.4)
        pieChartView.animate(xAxisDuration: 1.5)
        
    }
}

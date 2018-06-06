//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let container = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

let lineWidth : CGFloat = 5
let lineMargin : CGFloat = 5

class LineChartView : UIView {
    
    public var inputData = [[String]]()
    
//    private var bottomLeftPoint : CGPoint {
//        return CGPoint(x: 0, y: self.frame.height)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(inputData)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(inputData)
        
        
        var leftSeperator = createSeperatorWithRect(CGRect(x: lineMargin, y: 0, width: lineWidth, height: self.frame.height - lineMargin))
        self.addSubview(leftSeperator)
        let bottmLine = createSeperatorWithRect(CGRect(x: lineMargin, y: self.frame.height - lineMargin, width: self.frame.width - lineMargin, height:lineWidth ))
        self.addSubview(bottmLine)
        
        
//        drawVerticalMarks(onView: leftSeperator)
        
        
       
    }
    
//    private func drawVerticalMarks (onView view: UIView) {
//
//        let count = inputData.count
//
//        let segment : Int = view.frame.height / count
//
//        var depthPoints : Int = view.frame.height
//
//        for input in inputData {
//            let verticalMark = input[0];
//            depthPoints -= segment    // 250-50, 200-50 .... 50-50
//
//            let markView : UIView = UIView(frame: CGRect(x: lineMargin - 2, y: (depthPoints as CGFloat), width: (lineWidth+3), height: lineWidth))
//            markView.backgroundColor = UIColor.red
//            self.addSubview(markView)
//        }
//
//
//
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createSeperatorWithRect(_ rect : CGRect) -> UIView{
        let seperator = UIView(frame: rect)
        seperator.backgroundColor = UIColor.blue
        return seperator
    }
}


let inputData = [["a","10"],["b","50"],["c","30"],["d","20"],["e","40"]]

let lineChart = LineChartView(frame: CGRect(x: 10, y: 10, width: 350, height: 250))
lineChart.inputData = inputData
lineChart.backgroundColor = UIColor.gray



container.addSubview(lineChart)












































PlaygroundPage.current.liveView = container
PlaygroundPage.current.needsIndefiniteExecution = true

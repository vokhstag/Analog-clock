//
//  ClockView.swift
//  ClockTest
//
//  Created by Yunus Abubakarov on 28.09.2021.
//

import UIKit

class ClockView: UIView {
    
    //MARK: - Constants
    let ovalRadius: Double = 150 //Радиус часов
    lazy var ovalCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    
    override func draw(_ rect: CGRect) {
        //Круг с разметкой
        
        let ovalPath = UIBezierPath(arcCenter: ovalCenter, radius: CGFloat(ovalRadius), startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        UIColor.white.setStroke()
        ovalPath.lineWidth = 3.0
        ovalPath.stroke()
        
        //Разметка на часах
        for i in 0..<60 {
            let path = UIBezierPath()
            let xValue = Double(ovalCenter.x) + cos((Double.pi * 2) * Double(i)/60) * ovalRadius
            let yValue = Double(ovalCenter.y) + sin((Double.pi * 2) * Double(i)/60) * ovalRadius
            let cooficient = (i % 5 == 0) ? 0.9 : 0.95
            let xValueForLine = Double(ovalCenter.x) + cos((Double.pi * 2) * Double(i)/60) * (ovalRadius * cooficient)
            let yValueForLine = Double(ovalCenter.y) + sin((Double.pi * 2) * Double(i)/60) * (ovalRadius * cooficient)
            path.move(to: CGPoint(x: xValue, y: yValue))
            path.addLine(to: CGPoint(x: xValueForLine, y: yValueForLine))
            path.lineWidth = (i % 5 == 0) ? 3 : 2
            path.stroke()
        }
        
        //Стрелки
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        //Часы
        let hoursValue = (((hour * 5) + minute/12) > 60 ) ? minute/12 : (hour * 5) + minute/12
        let hourLinePath = UIBezierPath()
        hourLinePath.move(to: ovalCenter)
        hourLinePath.addLine(to: lineAngle(value: hoursValue, cooficient: 0.65))
        
        UIColor.white.setStroke()
        hourLinePath.lineWidth = 5
        hourLinePath.stroke()
        
        //Минуты
        let minutsLinePath = UIBezierPath()
        minutsLinePath.move(to: ovalCenter)
        minutsLinePath.addLine(to: lineAngle(value: minute, cooficient: 0.85))
        
        UIColor.white.setStroke()
        minutsLinePath.lineWidth = 3
        minutsLinePath.stroke()
        
        //Секунды
        let secondsLinePath = UIBezierPath()
        secondsLinePath.move(to: ovalCenter)
        secondsLinePath.addLine(to: lineAngle(value: second))
        
        UIColor.red.setStroke()
        secondsLinePath.lineWidth = 2
        secondsLinePath.stroke()
        
        //Кружочек в центре часов
        let centerOvalPath = UIBezierPath(arcCenter: ovalCenter, radius: 6, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        UIColor.red.setFill()
        centerOvalPath.fill()
    }
    
    func lineAngle(value: Int, cooficient: Double = 1) -> CGPoint {
        let timeValue = (value + 45 >= 60) ? value - 15 : value + 45
        let xValue = Double(ovalCenter.x) + cos((Double.pi * 2) * Double(timeValue)/60) * (ovalRadius * cooficient)
        let yValue = Double(ovalCenter.y) + sin((Double.pi * 2) * Double(timeValue)/60) * (ovalRadius * cooficient)
        return CGPoint(x: xValue, y: yValue)
    }
}

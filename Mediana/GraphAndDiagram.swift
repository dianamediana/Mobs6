//
//  GraphAndDiagram.swift
//  Mediana
//
//  Created by dianaMediana on 22.12.2020.
//

import Foundation
import UIKit

class SegmentControl: UIViewController {
    
    @IBOutlet weak var diagrama: UIView!
    @IBOutlet weak var grafic: UIView!
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diagrama.isHidden = false
        grafic.isHidden = true
        self.segmentButton.addTarget(self, action: #selector(goToCertainView(sender:)), for: .valueChanged)
    }
    
    @objc func goToCertainView(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            grafic.isHidden = true
            diagrama.isHidden = false
        } else if index == 1 {
            grafic.isHidden = false
            diagrama.isHidden = true
        }
    }
    
}

class Chart: UIView {
    var yellowTune: CGFloat = 15.0
    var brownTune: CGFloat = 25.0
    var grayTune: CGFloat = 50.0
    var redTune: CGFloat = 10.0
    
    override func draw(_ rect: CGRect) {
        let rad: CGFloat = 81.0
        let yellow = UIBezierPath()
        let brown = UIBezierPath()
        let gray = UIBezierPath()
        let red = UIBezierPath()
        yellow.lineWidth = 32.0
        brown.lineWidth = 32.0
        gray.lineWidth = 32.0
        red.lineWidth = 32.0
        yellow.addArc(withCenter: CGPoint(x: self.bounds.width / CGFloat(2.0), y: self.bounds.height / CGFloat(2.4)), radius: rad, startAngle: 0, endAngle: 2 * CGFloat.pi * yellowTune / 100, clockwise: true)
        brown.addArc(withCenter: CGPoint(x: self.bounds.width / CGFloat(2.0), y: self.bounds.height / CGFloat(2.4)), radius: rad, startAngle: 2 * CGFloat.pi * yellowTune / 100, endAngle: 2 * CGFloat.pi * (yellowTune + brownTune) / 100, clockwise: true)
        gray.addArc(withCenter: CGPoint(x: self.bounds.width / CGFloat(2.0), y: self.bounds.height / CGFloat(2.4)), radius: rad, startAngle: 2 * CGFloat.pi * (yellowTune + brownTune) / 100, endAngle: 2 * CGFloat.pi * (yellowTune + brownTune + grayTune) / 100, clockwise: true)
        red.addArc(withCenter: CGPoint(x: self.bounds.width / CGFloat(2.0), y: self.bounds.height / CGFloat(2.4)), radius: rad, startAngle: 2 * CGFloat.pi * (yellowTune + brownTune + grayTune) / 100, endAngle: 2 * CGFloat.pi, clockwise: true)
        UIColor.yellow.setStroke()
        yellow.stroke()
        UIColor.brown.setStroke()
        brown.stroke()
        UIColor.gray.setStroke()
        gray.stroke()
        UIColor.red.setStroke()
        red.stroke()
    }
}

class Graph: UIView {
    var dependence: ((Float) -> Float)?
    var set: CGPoint?
    var origin: CGPoint {
        get {
            return set ?? CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        }
        set {
            set = newValue
        }
    }
    override func draw(_ rect: CGRect) {
        let graphAxes = DrawTheAxes()
        graphAxes.contentScaleFactor = contentScaleFactor
        graphAxes.color = UIColor.darkGray
        graphAxes.drawAxes(in: bounds, origin: origin, pointsPerUnit: 25.85)
        drawGrafic(bounds, origin: origin, scale: 25.85)
    }
    
    func drawGrafic(_ bounds: CGRect, origin: CGPoint, scale: CGFloat) {
            var xGraph, yGraph: CGFloat
            var x, y: Float
            var isFirstPoint = true
            
            let oldYGraph: CGFloat = 0.0
            var disContinuity: Bool {
                return abs(yGraph - oldYGraph) > max(bounds.width, bounds.height) * 1.5
            }
            dependence = {$0 * $0}
            if dependence != nil {
                UIColor.purple.set()
                let path = UIBezierPath()
                path.lineWidth = 1.4
                
                var xArray: [Float] = []
                for i in -5...5 {
                    xArray.append(Float(i))
                    if i == 5 {
                        break
                    }
                    for _ in 0...6 {
                        xArray.append(Float(0))
                    }
                }
                var i: Int = 0
                while i < xArray.count {
                    if Int(xArray[i]) == 5 {
                        break
                    }
                    xArray[i + 1] = xArray[i] + 0.11
                    xArray[i + 2] = xArray[i] + 0.25
                    xArray[i + 3] = xArray[i] + 0.39
                    xArray[i + 4] = xArray[i] + 0.53
                    xArray[i + 5] = xArray[i] + 0.67
                    xArray[i + 6] = xArray[i] + 0.81
                    xArray[i + 7] = xArray[i] + 0.95
                    i = i + 8
                }
                for i in xArray{
                    x = Float(i)
                    xGraph = CGFloat(x) * scale + origin.x
                    y = (dependence)!(x)
                    guard y.isFinite else {
                        continue
                    }
                    yGraph = origin.y - CGFloat(y) * scale
                    if isFirstPoint {
                        path.move(to: CGPoint(x: xGraph, y: yGraph))
                        isFirstPoint = false
                    } else {
                        if disContinuity {
                            isFirstPoint = true
                        } else {
                            path.addLine(to: CGPoint(x: xGraph, y: yGraph))
                        }
                    }
                }
                path.stroke()
            }
        }
}

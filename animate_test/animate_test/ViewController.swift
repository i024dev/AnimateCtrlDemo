//
//  ViewController.swift
//  animate_test
//
//  Created by Apple on 2024/4/23.
//

import UIKit

class IndicatorView: UIView {
    
    var size: CGSize = .zero
    
    lazy var indicator = UIView()
    
    init(size: CGSize) {
        super.init(frame: .zero)
        self.size = size
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        self.backgroundColor = .color(hex: 0x000000, alpha: 0.3)
        self.layer.cornerRadius = 1.5
        self.layer.masksToBounds = true
        
        // 起始位置不可见
        indicator.frame = CGRectMake(-size.width, 0, size.width, size.height)
        indicator.backgroundColor = .blue
        indicator.layer.cornerRadius = 1.5
        indicator.layer.masksToBounds = true
        addSubview(indicator)

    }
}

class ViewController: UIViewController {
    
    var indicator: IndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        indicator = IndicatorView(size: CGSize(width: UIScreen.main.bounds.width, height: 10))
        indicator.frame = CGRectMake(0, 100, UIScreen.main.bounds.width, 10)
        view.addSubview(indicator)
        
        let buttton = UIButton(type: .custom)
        buttton.backgroundColor = .red
        buttton.setTitle("pause", for: .normal)
        view.addSubview(buttton)
        buttton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        buttton.frame = CGRectMake(10, 120, 60, 30)
        
        let buttton2 = UIButton(type: .custom)
        buttton2.setTitle("resume", for: .normal)
        buttton2.backgroundColor = .green
        view.addSubview(buttton2)
        buttton2.addTarget(self, action: #selector(resume), for: .touchUpInside)
        buttton2.frame = CGRectMake(90, 120, 60, 30)
        
        let buttton3 = UIButton(type: .custom)
        buttton3.setTitle("start", for: .normal)
        buttton3.backgroundColor = .blue
        view.addSubview(buttton3)
        buttton3.addTarget(self, action: #selector(start), for: .touchUpInside)
        buttton3.frame = CGRectMake(180, 120, 60, 30)
        
        
        let buttton4 = UIButton(type: .custom)
        buttton4.setTitle("stop", for: .normal)
        buttton4.backgroundColor = .blue
        view.addSubview(buttton4)
        buttton4.addTarget(self, action: #selector(stop), for: .touchUpInside)
        buttton4.frame = CGRectMake(270, 120, 60, 30)
      
    }

    @objc func pause() {
        let pausedTime = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        view.layer.speed = 0.0
        view.layer.timeOffset = pausedTime
    }
    
    @objc func resume() {
        let pausedTime = view.layer.timeOffset
        if pausedTime == 0 {
            return
        }
        view.layer.speed = 1.0
        view.layer.timeOffset = 0.0
        view.layer.beginTime = 0.0
        let timeSincePause = view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        view.layer.beginTime = timeSincePause
    }
    
    @objc func stop() {
       
        indicator.indicator.layer.removeAllAnimations()
    }
    
    @objc func start() {
        UIView.animate(withDuration: 10) { [self] in
            indicator.indicator.frame = CGRectMake(0, 0, indicator.bounds.width, indicator.bounds.height)
        } completion: { completed in
            print("--------")
        }
    }
}


extension UIColor {
    /// 格式化颜色
    static func color(hex: UInt, alpha: CGFloat = 1.0) -> UIColor {
        let color = UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
        return color
    }
}

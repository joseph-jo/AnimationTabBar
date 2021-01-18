//
//  AnimationTabBar.swift
//  AnimationTabBar
//
//  Created by Joseph Chen on 2021/1/18.
//

import Foundation
import UIKit

protocol AnimationTabBarDelegate: class {
    
    func onTabBarButtonClick(idx: Int)
}

class AnimationTabBar: UIView {

    class func defaultHeight() -> CGFloat { return 35.0 }
    
    weak var delegate: AnimationTabBarDelegate?
    
    lazy var stackView = UIStackView()
    lazy var indicator = UIView()
    lazy var selectedIdx = 0
    var bMoveAsAnimation = false
    
    var buttonString: Array<String>? {
        didSet {
            self.initUI()
        }
    }
    
    lazy var buttons = Array<UIButton>()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.addSubview(self.stackView)
        
        self.indicator.backgroundColor = .orange
        self.indicator.layer.cornerRadius = 1.5
        self.stackView.addSubview(self.indicator)
    }
    
    convenience init(delegate: AnimationTabBarDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    private func initUI() {
         
        guard let strings = buttonString else { return }
        self.buttons.removeAll()
        
        for idx in 0...strings.count - 1 {
            
            let btn = UIButton()
            btn.tag = idx
            btn.setTitle(strings[idx], for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.addTarget(self, action: #selector(AnimationTabBar.onButtonClick(sender:)), for: .touchUpInside)
            
            self.buttons.append(btn)
        }
        
        for btn in buttons {
            self.stackView.addArrangedSubview(btn)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.stackView.frame = self.bounds
        self.stackView.layoutIfNeeded()
        
        if selectedIdx < self.buttons.count {
            
            if self.bMoveAsAnimation {
                
                UIView.animate(withDuration: 0.5) { [self] in
                     
                    self.indicator.frame = self.stackView.convert(self.getIndicatorFrame(fromBtn: self.buttons[selectedIdx]), from: self.buttons[selectedIdx])
                }
            }
            else {
                self.indicator.frame = self.stackView.convert(self.getIndicatorFrame(fromBtn: self.buttons[selectedIdx]), from: self.buttons[selectedIdx])
            }
        }
        
        
        for i in 0...self.buttons.count - 1 {
            let btn = self.buttons[i]
            if i == selectedIdx {
                btn.setTitleColor(.orange, for: .normal)
            }
            else {
                btn.setTitleColor(.black, for: .normal)
            }
        }
    }
}

extension AnimationTabBar {
    
    private func getIndicatorFrame(fromBtn btn: UIButton) -> CGRect {
        guard let lbl = btn.titleLabel else { return .zero }
        
        let rect = CGRect(x: lbl.frame.minX, y: lbl.frame.maxY, width: lbl.frame.width, height: 3.0)
        return rect
    }
    
    @objc private func onButtonClick(sender: UIButton) {
        
        self.delegate?.onTabBarButtonClick(idx: sender.tag)
        
        if selectedIdx == sender.tag {
            return
        }
        self.selectedIdx = sender.tag
        self.bMoveAsAnimation = true
        self.setNeedsLayout()
    }
}

extension AnimationTabBar {
    
}

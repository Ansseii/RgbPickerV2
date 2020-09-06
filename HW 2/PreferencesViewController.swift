//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var mainViewColor: CIColor!
    var delegate: SetColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        initStartValues()
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        let currentText = string(from: sender.value)
        switch sender.tag {
        case 0: redLabel.text = currentText
        case 1: greenLabel.text = currentText
        case 2: blueLabel.text = currentText
        default: break
        }
        setColor()
    }
    @IBAction func applyColor() {
        delegate.setColor(colorView.backgroundColor)
        dismiss(animated: true)
    }
    
    // Цвет вью
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func initStartValues() {
        let initialRed = Float(mainViewColor.red)
        let initialGreen = Float(mainViewColor.green)
        let initialBlue = Float(mainViewColor.blue)
        
        colorView.backgroundColor = UIColor(ciColor: mainViewColor)
        
        redLabel.text = string(from: initialRed)
        greenLabel.text = string(from: initialGreen)
        blueLabel.text = string(from: initialBlue)
        
        redSlider.value = initialRed
        greenSlider.value = initialGreen
        blueSlider.value = initialBlue
    }
    
    private func setColor(ciColor: CIColor) {
        colorView.backgroundColor = UIColor(ciColor: ciColor)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider.value)
            case 1: greenLabel.text = string(from: greenSlider.value)
            case 2: blueLabel.text = string(from: blueSlider.value)
            default: break
            }
        }
    }
    
    // Значения RGB
    private func string(from source: Float) -> String {
        String(format: "%.2f",source)
    }
}

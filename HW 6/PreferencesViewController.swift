//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

enum Color {
    case red
    case green
    case blue
}

class PreferencesViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var mainViewColor: CIColor!
    var delegate: SetColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        initStartValues()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        let currentText = string(from: sender.value)
        switch sender.tag {
        case 0:
            redLabel.text = currentText
            redTextField.text = currentText
        case 1:
            greenLabel.text = currentText
            greenTextField.text = currentText
        case 2:
            blueLabel.text = currentText
            blueTextField.text = currentText
        default: break
        }
        setColor()
    }
    
    @IBAction func applyColor() {
        delegate.setColor(colorView.backgroundColor)
        dismiss(animated: true)
    }
    
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
        
        setValue(initialRed, for: .red)
        setValue(initialGreen, for: .green)
        setValue(initialBlue, for: .blue)
    }
    
    private func setValue(_ value: Float , for color: Color) {
        switch color {
        case .red:
            redLabel.text = string(from: value)
            redTextField.text = redLabel.text
            redSlider.value = value
        case .green:
            greenLabel.text = string(from: value)
            greenTextField.text = greenLabel.text
            greenSlider.value = value
        case .blue:
            blueLabel.text = string(from: value)
            blueTextField.text = blueLabel.text
            blueSlider.value = value
        }
    }
    
    private func string(from source: Float) -> String {
        String(format: "%.2f",source)
    }
}

extension PreferencesViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currentText = textField.text else { return }
        guard let currentFloat = Float(currentText) else { return }
        switch textField.tag {
        case 0: setValue(currentFloat, for: .red)
        case 1: setValue(currentFloat, for: .green)
        case 2: setValue(currentFloat, for: .blue)
        default: break
        }
        
        setColor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

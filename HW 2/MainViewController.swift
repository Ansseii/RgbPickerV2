//
//  MainViewController.swift
//  HW 2
//
//  Created by Aleksandr on 06.09.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var colorAreaView: UIView!
    
    override func viewDidLoad() { super.viewDidLoad() }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let preferencesVC =
            segue.destination as? PreferencesViewController else { return }
        guard let color = colorAreaView.backgroundColor else { return }
        preferencesVC.mainViewColor = CIColor(color: color)
        preferencesVC.delegate = self
    }
}

protocol SetColorViewControllerDelegate {
    func setColor(_ color: UIColor?);
}

extension MainViewController: SetColorViewControllerDelegate {
    func setColor(_ color: UIColor?) {
        if let color = color { colorAreaView.backgroundColor = color }
    }
}

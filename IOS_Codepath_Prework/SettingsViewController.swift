//
//  SettingsViewController.swift
//  IOS_Codepath_Prework
//
//  Created by Andy Chen on 1/16/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var defaultTipTextField: UITextField!
    @IBOutlet weak var defaultTipTextField2: UITextField!
    @IBOutlet weak var defaultTipTextField3: UITextField!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    let defaults = UserDefaults.standard

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        defaultTipTextField.text = defaults.string(forKey: "defaultTipTextField") ?? "15%"
        defaultTipTextField2.text = defaults.string(forKey: "defaultTipTextField2") ?? "18%"
        defaultTipTextField3.text = defaults.string(forKey: "defaultTipTextField3") ?? "20%"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func saveDefaultTips(_ sender: Any) {
        //Save default tips to UserDefault
        defaults.set(defaultTipTextField.text, forKey: "defaultTipTextField")
        defaults.set(defaultTipTextField2.text, forKey: "defaultTipTextField2")
        defaults.set(defaultTipTextField3.text, forKey: "defaultTipTextField3")
        defaults.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

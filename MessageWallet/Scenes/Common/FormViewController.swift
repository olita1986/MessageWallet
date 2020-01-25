//
//  FormViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    init() {
        super.init(nibName: "FormViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDismissKeyboard()
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

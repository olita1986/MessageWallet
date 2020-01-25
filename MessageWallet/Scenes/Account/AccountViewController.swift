//
//  AccountViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import UIKit
import Web3

class AccountViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var etherBalanceLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    
    // MARK: - Properties
    
    let privateKey: EthereumPrivateKey
    
    init(privateKey: EthereumPrivateKey) {
        self.privateKey = privateKey
        super.init(nibName: "AccountViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressLabel.text = privateKey.address.hex(eip55: true)
    }

}

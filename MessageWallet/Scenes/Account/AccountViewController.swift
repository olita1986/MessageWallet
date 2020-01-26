//
//  AccountViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import Web3

protocol AccountViewControllerDelegate: AnyObject {
    func signWasSelected(privateKey: EthereumPrivateKey)
    func verifyWasSelected()
}

class AccountViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var etherBalanceLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    
    weak var delegate: AccountViewControllerDelegate?
    
    
    // MARK: - Properties
    
    let viewModel: AccountViewModel
    let privateKey: EthereumPrivateKey
    
    private let disponseBag = DisposeBag()
    
    init(privateKey: EthereumPrivateKey,
         viewModel: AccountViewModel = AccountViewModel()) {
        self.privateKey = privateKey
        self.viewModel = viewModel
        super.init(nibName: "AccountViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()

        viewModel.getData(withKey: privateKey)
        viewModel.getBalance(address: privateKey.address)
    }
    
    func setupBindings() {
        viewModel.address
            .drive(addressLabel.rx.text)
            .disposed(by: disponseBag)
        
        viewModel.ethQuantity
            .drive(etherBalanceLabel.rx.text)
            .disposed(by: disponseBag)
        
        signButton.rx.tap
            .subscribe(onNext: {[weak self] in
                guard let `self` = self else { return }
                self.delegate?.signWasSelected(privateKey: self.privateKey)
            })
            .disposed(by: disponseBag)
        
        verifyButton.rx.tap
            .subscribe(onNext: {
                self.delegate?.verifyWasSelected()
            })
            .disposed(by: disponseBag)
    }

}

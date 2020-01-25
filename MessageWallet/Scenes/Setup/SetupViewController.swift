//
//  SetupViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Web3

protocol SetupViewControllerDelegate: AnyObject {
    func privateKeyWasSuccesful(withPrivateKey key: EthereumPrivateKey)
}

class SetupViewController: FormViewController {

    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: SetupViewModel
    weak var delegate: SetupViewControllerDelegate?
    
    init(viewModel: SetupViewModel = SetupViewModel()) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        generalBindings()
    }
    
    private func setupViews() {
        setupKeyTextField()
        setupGetInfoButton()
        setupInfoLabel()
    }
    
    private func setupGetInfoButton() {
        actionButton.setTitle("Get Info", for: [])
        actionButton.rx.tap
        .throttle(
            .milliseconds(500),
            latest: false,
            scheduler: MainScheduler.instance
        )
        .subscribe(onNext: {[weak self] in
            guard let `self` = self else { return }
            self.viewModel.checkPrivateKey()
            self.inputTextField.text = ""
        })
        .disposed(by: disposeBag)
        viewModel.buttonEnabled
            .drive(actionButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func setupKeyTextField() {
        inputTextField.placeholder = "Enter Private Key"
        inputTextField.rx.text
            .orEmpty
            .bind(to: viewModel.privateKeyString)
            .disposed(by: disposeBag)
    }
    
    private func setupInfoLabel() {
        infoLabel.text = "Invalid private key"
        infoLabel.textColor = .red
        viewModel.privateKey
            .map {$0 != nil}
            .drive(infoLabel.rx.isHidden)
            .disposed(by: disposeBag)
        infoLabel.isHidden = true
    }
    
    private func generalBindings() {
        viewModel.privateKey
            .drive(onNext: { [weak self] key in
                guard let `self` = self else { return }
                guard let privateKey = key  else { return }
                self.delegate?.privateKeyWasSuccesful(withPrivateKey: privateKey)
            })
            .disposed(by: disposeBag)
    }
}

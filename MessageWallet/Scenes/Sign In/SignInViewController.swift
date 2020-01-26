//
//  SignInViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit
import Web3

protocol SignInViewControllerDelegate: AnyObject {
    func signMessage(signature: String, message: String)
}

class SignInViewController: FormViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: SignInViewModel
    let privateKey: EthereumPrivateKey
    
    weak var delegate: SignInViewControllerDelegate?
    
    init(viewModel: SignInViewModel = SignInViewModel(),
         privateKey: EthereumPrivateKey) {
        self.privateKey = privateKey
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
        setupMessageTextField()
        setupSignMessageButton()
    }
    
    private func setupSignMessageButton() {
        actionButton.rx.tap
        .throttle(
            .milliseconds(500),
            latest: false,
            scheduler: MainScheduler.instance
        )
        .subscribe(onNext: {[weak self] in
            guard let `self` = self else { return }
            self.viewModel.signMessage(privateKey: self.privateKey)
        })
        .disposed(by: disposeBag)
        viewModel.buttonEnabled
            .drive(actionButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func setupMessageTextField() {
        inputTextField.placeholder = "Enter Message"
        inputTextField.rx.text
            .orEmpty
            .bind(to: viewModel.message)
            .disposed(by: disposeBag)
    }
    
    private func generalBindings() {
        viewModel.signature
            .drive(onNext: {[weak self] signature in
                guard let `self` = self else { return }
                guard !signature.isEmpty else { return }
                self.delegate?.signMessage(
                    signature: signature,
                    message: self.viewModel.message.value
                )
            })
            .disposed(by: disposeBag)
    }
}

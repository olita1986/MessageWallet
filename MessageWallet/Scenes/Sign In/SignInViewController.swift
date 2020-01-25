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

class SignInViewController: FormViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel = SignInViewModel()) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
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
        .subscribe(onNext: {
            self.viewModel.doSomethig()
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

}

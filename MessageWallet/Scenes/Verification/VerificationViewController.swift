//
//  VerificationViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class VerificationViewController: FormViewController {

    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel: VerificationViewModel
    
    init(viewModel: VerificationViewModel = VerificationViewModel()) {
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
        setupKeyTextField()
        setupGetInfoButton()
    }
    
    private func setupGetInfoButton() {
        actionButton.setTitle("Get Info", for: [])
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
    
    private func setupKeyTextField() {
        inputTextField.placeholder = "Enter Private Key"
        inputTextField.rx.text
            .orEmpty
            .bind(to: viewModel.message)
            .disposed(by: disposeBag)
    }

}

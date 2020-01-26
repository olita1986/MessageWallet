//
//  SignatureViewController.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxCocoa
import RxSwift

class SignatureViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var inputMessageLabel: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    let viewModel: SignatureViewModel
    let message: String
    let signature: String
    
    init(viewModel: SignatureViewModel = SignatureViewModel(),
         message: String,
         signature: String) {
        self.message = message
        self.viewModel = viewModel
        self.signature = signature
        
        super.init(
            nibName: "SignatureViewController",
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

        viewModel.getQRImage(withMessage: signature)
    }


    // MARK: - UI Setup
    
    func setupViews() {
        setupInputMessageLabel()
        setupQRImageView()
    }
    
    func setupInputMessageLabel() {
        let attrString = NSMutableAttributedString(
            string: "Message: ",
            attributes: [
                .font : UIFont.boldSystemFont(ofSize: 17)
            ]
        )
        attrString.append(NSAttributedString(string: message))
        inputMessageLabel.attributedText = attrString
    }
    
    func setupQRImageView() {
        viewModel.qrImage
            .drive(qrImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    

}

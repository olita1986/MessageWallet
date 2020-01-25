//
//  SignatureViewModel.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxSwift
import RxCocoa

class SignatureViewModel {
    
    // MARK: - Properties
    let qrService: QRServiceProtocol
    private let _qrImage = BehaviorRelay<UIImage>(value: UIImage())
    
    var qrImage: Driver<UIImage> {
        return _qrImage.asDriver()
    }
    
    init(qrService: QRServiceProtocol = QRService()) {
        self.qrService = qrService
    }
    
    func getQRImage(withMessage message: String) {
        let image = qrService.generateQRCode(from: message)
        _qrImage.accept(image ?? UIImage())
    }
}

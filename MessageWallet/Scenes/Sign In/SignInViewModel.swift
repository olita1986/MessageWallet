//
//  SignInViewModel.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxSwift
import RxCocoa
import Web3

class SignInViewModel {
    // MARK: - Properties
    
    let message = BehaviorRelay<String>(value: "")
    private let _signature = BehaviorRelay<String>(value: "")
    
    var signature: Driver<String> {
        return _signature.asDriver()
    }
    
    var buttonEnabled: Driver<Bool> {
        return message
            .map{$0.count > 0}
            .asDriver(onErrorJustReturn: false)
    }
    
    let ethService: ETHServiceProtocol
    
    init(ethService: ETHServiceProtocol = ETHService.shared) {
        self.ethService = ethService
    }
    
    func signMessage(privateKey: EthereumPrivateKey) {
        let signature = ethService.signMessage(withPrivateKey: privateKey, message: message.value)
        
        _signature.accept(signature)
    }
}



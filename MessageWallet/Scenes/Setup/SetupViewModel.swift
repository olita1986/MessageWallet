//
//  SetupViewModel.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxSwift
import RxCocoa
import Web3

class SetupViewModel {
    // MARK: - Properties
    
    let privateKeyString = BehaviorRelay<String>(value: "")
    
    let _privateKey = BehaviorRelay<EthereumPrivateKey?>(value: nil)
    
    var privateKey: Driver<EthereumPrivateKey?> {
        return _privateKey.asDriver()
    }
    
    var buttonEnabled: Driver<Bool> {
        return privateKeyString
            .map{$0.count > 0}
            .asDriver(onErrorJustReturn: false)
    }
    
    let ethService: ETHServiceProtocol
    
    init(ethService: ETHServiceProtocol = ETHService()) {
        self.ethService = ethService
    }
    
    func checkPrivateKey() {
        let privateKey = ethService.isValidPrivateKey(key: privateKeyString.value)
        _privateKey.accept(privateKey)
    }
}

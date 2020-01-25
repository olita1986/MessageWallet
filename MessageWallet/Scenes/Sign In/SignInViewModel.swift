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
    
    var buttonEnabled: Driver<Bool> {
        return message
            .map{$0.count > 0}
            .asDriver(onErrorJustReturn: false)
    }
    
    init() {
        
    }
    
    func doSomethig() {
        print(message.value)
    }
    
    func doSomethingElse() {
//        let ethPrivateKey = try? EthereumPrivateKey(hexPrivateKey: "0x94eca03b4541a0eb0d173e321b6f960d08cfe4c5a75fa00ebe0a3d283c609c3a")
//        
//        print(ethPrivateKey?.address.)
//        
//        ethPrivateKey?.sign(message: Bytes()
    }
}



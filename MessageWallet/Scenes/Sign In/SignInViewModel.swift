//
//  SignInViewModel.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxSwift
import RxCocoa

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
}



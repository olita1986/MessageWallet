//
//  AccountViewModel.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxCocoa
import RxSwift
import Web3

class AccountViewModel {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    let ethService: ETHServiceProtocol
    
    private let _address = BehaviorRelay<String>(value: "")
    private let _ethQuantity = BehaviorRelay<BigUInt?>(value: 0)
    
    var address: Driver<String> {
        return _address.asDriver()
    }
    
    var ethQuantity: Driver<String> {
        return _ethQuantity.map{
            $0 != nil ? "\($0 ?? 0) eth" : "An error has occured"
        }.asDriver(onErrorJustReturn: "")
    }
    
    init(ethService: ETHServiceProtocol = ETHService.shared) {
        self.ethService = ethService
    }
    
    
    func getData(withKey key: EthereumPrivateKey) {
        let addressHexString = key.address.hex(eip55: true)
        _address.accept(addressHexString)
    }
    
    func getBalance(address: EthereumAddress) {
        ethService.getBalance(fromAddress: address)
            .subscribe(onNext: {[weak self] in
                self?._ethQuantity.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
}

//
//  ETHService.swift
//  MessageWallet
//
//  Created by Orlando Arzola Aragort on 1/25/20.
//  Copyright © 2020 Orlando Arzola Aragort. All rights reserved.
//

import RxSwift
import Web3

class ETHService: ETHServiceProtocol {
    
    static var shared = ETHService()
    
    private let web3 = Web3(rpcURL: "https://rinkeby.infura.io/v3/30741a0875054f90826b80efa8bf614b")
    
    private init() {}
    
    var signature: (v: UInt, r: Bytes, s: Bytes)?
    
    func isValidPrivateKey(key: String) -> EthereumPrivateKey? {
        let ethPrivateKey = try? EthereumPrivateKey(hexPrivateKey: key)
        return ethPrivateKey
    }
    
    func getAddress(fromPrivateKey key: EthereumPrivateKey) -> String {
        return key.address.hex(eip55: true)
    }
    
    func getBalance(fromAddress address: EthereumAddress) -> Observable<BigUInt?> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let `self` =  self else { return Disposables.create()}
            self.web3.eth.getBalance(address: address, block: .latest) { (response) in
                if response.status.isFailure {
                    observer.onNext(nil)
                } else if let result = response.result {
                    observer.onNext(result.quantity.eth)
                } else {
                    observer.onNext(nil)
                }
            }
            return Disposables.create()
        }
    }
    
    func signMessage(withPrivateKey key: EthereumPrivateKey, message: String) -> String {
        guard !message.isEmpty else { return "" }
        
        signature = try! key.sign(message: message.bytes)
        
        guard let signature = signature else { return "" }
        
        return signature.r.toHexString() + signature.s.toHexString() + signature.v.makeBytes().toHexString()
        
    }
}

protocol ETHServiceProtocol {
    func getAddress(fromPrivateKey key: EthereumPrivateKey) -> String
    
    func isValidPrivateKey(key: String) -> EthereumPrivateKey?
    
    func getBalance(fromAddress address: EthereumAddress) -> Observable<BigUInt?>
    
    func signMessage(withPrivateKey key: EthereumPrivateKey, message: String) -> String
}

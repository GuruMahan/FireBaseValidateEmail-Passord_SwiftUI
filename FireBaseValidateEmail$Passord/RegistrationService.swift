//
//  RegistrationService.swift
//  FireBaseValidateEmail$Passord
//
//  Created by Guru Mahan on 07/02/23.
//

import Foundation

import Combine
import Firebase


protocol RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void , Error>
}

final class RegistrationServiceImpl: RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher< Void,Error> {
        Deferred {
            
            Future { promise in
                Auth.auth().createUser(withEmail: details.email, password: details.password) { res, error in
                    if let err = error{
                        promise(.failure(err))
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

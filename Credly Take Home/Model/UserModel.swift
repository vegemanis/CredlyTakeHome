//
//  UserModel.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import JSONParserSwift

class UserModel: ParsableModel {
    var id: Int = 0
    var name: String?
    var username: String?
    var email: String?
    var address: AddressModel?
    var phone: String?
    var website: String?
    var company: CompanyModel?
}

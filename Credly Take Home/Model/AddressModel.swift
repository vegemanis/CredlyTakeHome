//
//  AddressModel.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import JSONParserSwift

class AddressModel: ParsableModel {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: GeoModel?
}

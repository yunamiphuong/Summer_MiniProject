//
//  FakeData.swift
//  Summer_MiniProject
//
//  Created by Apple on 5/28/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct PetCollection {
    var imageName: String
    var nameLabel: String
    var tag: Int
}

func fakeData() -> [PetCollection] {
    let pet1 = PetCollection(imageName: "bee", nameLabel: "Bee", tag: 0)
    let pet2 = PetCollection(imageName: "cat2", nameLabel: "Cat 2", tag:1 )
    let pet3 = PetCollection(imageName: "dog", nameLabel: "Dog", tag:2 )
    let pet4 = PetCollection(imageName: "cat4", nameLabel: "Cat 4", tag:3 )
    let pet5 = PetCollection(imageName: "cat1", nameLabel: "Cat 1", tag:4 )
    let pet6 = PetCollection(imageName: "cat3", nameLabel: "Cat 3", tag:5 )
    return [pet1, pet2, pet3, pet4, pet5, pet6]
}

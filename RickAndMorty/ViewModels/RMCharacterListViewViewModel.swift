//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Wilson Mungai on 2022-12-28.
//

import Foundation

struct RMCharacterListViewViewModel
{
    RMService.shared.execute(.listCharactersRequest,expecting: RMGetAllCharactersResponse.self)
    { result in
        switch result
        {
        case.success(let model):
            print("Total: "+String(model.info.pages))
            print("Page result count: "+String(model.results.count))
        case .failure(let error):
            print(String(describing: error))
        }
    }
}

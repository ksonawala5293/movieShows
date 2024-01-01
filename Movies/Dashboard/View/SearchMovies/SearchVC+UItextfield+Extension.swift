//
//  SearchVC+UItextfield+Extension.swift
//  Movies
//
//  Created by Apple on 01/01/24.
//

import Foundation
import UIKit

extension SearchVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.workItem?.cancel()
        
        guard let text = textField.text else {
            return true
        }

        let workItem = DispatchWorkItem { [weak self] in
            self?.performSearch(with: text)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
        self.workItem = workItem

        return true
    }
}

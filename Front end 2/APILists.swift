import Foundation

struct APIList {
    static let baseUrl = "http://localhost/WalletWise"
    static let loginUrl = "\(baseUrl)/login.php"
    static let feedback = "\(baseUrl)/getsubmitfeedback.php"
    static let registerUrl = "\(baseUrl)/register.php"
    static let cashinUrl = "\(baseUrl)/cashin.php"
    static let listUrl="\(baseUrl)/viewlist.php"
    static let cashoutUrl="\(baseUrl)/cashout.php"
    static let budgetgoalUrl="\(baseUrl)/budgetgoals.php"
    static let ratingUrl="\(baseUrl)/submitfeedback.php"
    
}
//
//  APILists.swift
//  Wallet
//
//  Created by SAIL on 29/05/25.
//


class Datamanager {
    
    static let shared = Datamanager()
    
    
    init(){}
    
    var email:String = ""
    
    
    
}

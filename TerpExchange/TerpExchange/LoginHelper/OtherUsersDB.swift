//
//  OtherUsersDB.swift
//  TerpExchange
//
//  Created by David Do on 4/14/23.
//

//////////////////////////////////////////// DOESN'T WORK AT THE MOMENT...

import Foundation
import FirebaseFirestore

class OtherUsersDB: ObservableObject {
    @Published var profileURLString: String?

    func getProfileURL(userId: String) -> String? {
        let usersRef = Firestore.firestore().collection("users").document(userId)
        var profileURLString: String?

        usersRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  let reviews = data["reviews"] as? [[String: Any]]
            else {
                return
            }

            for review in reviews {
                if let photoId = review["photoId"] as? String {
                    profileURLString = photoId
                    break
                }
            }
        }

        return profileURLString
    }
}

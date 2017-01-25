import UIKit



class Person{
    
    var avatar : String?
    var bio : String?
    var firstName : String?
    var id : String?
    var lastName : String?
    var title : String?
  
    
    init(fromJSON json: [String : Any]){
        avatar = json["avatar"] as? String
        bio = json["bio"] as? String
        firstName = json["firstName"] as? String
        id = json["id"] as? String
        lastName = json["lastName"] as? String
        title = json["title"] as? String
    }
    
}


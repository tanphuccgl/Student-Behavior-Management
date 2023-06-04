

import UIKit

class ClassModel:Codable {
    
    let id :String
    let name: String
    


    //MARK: constructors
    init?(id:String, name:String) {
      
        self.id = id
        self.name = name
    
    }

//    //Getter va setter
//    public func getName()->String{
//        return name
//    }
//
//    public func getRatingValue()->Int{
//        return ratingvalue
//    }
//
//    public func getImgMeal()->UIImage?{
//        return imgMeal
//    }
}

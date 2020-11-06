//
//  Webservice.swift
//  EstateBlock
//
//  Created by Dinesh Sailor on 28/11/16.
//  Copyright © 2016 Varshaa Weblabs. All rights reserved.
//

import UIKit

import Alamofire
import Reachability
import SVProgressHUD

struct Server {
  //  static let demo = "http://jbmdemo.in/prediktion/api/"
    
 //static let live =  "http://192.168.1.2:8080/dev/seazonedapp/public/api/"
    
//static let live2 = "http://192.168.1.2:8080/dev/seazonedapp/public/"
    
 // static let live2 = "http://103.230.103.142:8080/dev/seazonedapp/public/"
    
   // static let live            = "http://103.230.103.142:8080/dev/seazonedapp/public/api/"
    
    // http://seazoned.com/api

     static let live2 = "http://seazoned.com/api/"
    
     static let live            = "http://seazoned.com/api/"
    
	//static let live = "http://prediktions.com/api/"
}

enum LoginSource: String {
    case custom = "custom"
    case facebook = "facebook"
    case google = "google"
    case twitter = "twitter"
}

struct Parameter {
    
    static let username = "username"
    static let password = "password"
    static let profile_id = "profile_id"
      static let first_name = "first_name"
      static let last_name = "last_name"
    
   static let   card_holder_name  = "customer_name"
     static let        card_no   = "card_number"
    static let      month     =   "month"
    static let     year       =  "year"
    static let      card_id     =  "card_id"
    static let old_pw = "old_pw"
    static let new_pw = "new_pw"
    static let conf_pw = "conf_pw"
    
    static let email = "email"
    //tel
  static let tel = "tel"
    static let dob = "dob"
    
	 static let street = "street"
     static let city = "city"
   // state
      static let state = "state"
      static let country = "country"
    
    
    static let postal_code = "postal_code"
    
    static let address = "address"
    
    static let service_id = "service_id"
    
    static let profile_image = "profile_image"
    
    static let facebook_id = "facebook_id"
    
    static let google_id = "google_id"
    
    static let contact_name = "contact_name"
    static let street_address = "street_address"
    static let contact_number = "contact_number"
    static let email_address = "email_address"
    
    static let address_id = "address_id"
    
    static let landscaper_id = "landscaper_id"
    
    static let added_service_id = "added_service_id"
    
    static let address_book_id = "address_book_id"
    static let service_price_id = "service_price_id"
    static let service_date = "service_date"
    static let service_time = "service_time"
    static let additional_note = "additional_note"
    static let service_price = "service_price"
    
    static let lawn_area = "lawn_area"
    static let grass_length = "grass_length"
    static let leaf_accumulation = "leaf_accumulation"
    static let no_of_zones = "no_of_zones"
    static let water_type = "water_type"
    static let include_spa = "include_spa"
    static let pool_type = "pool_type"
    static let pool_state = "pool_state"
    static let no_of_cars = "no_of_cars"
    static let driveway_type = "driveway_type"
    static let service_type = "service_type"
    
    
    static let order_id = "order_id"
    
    static let status = "status"
    
  //  static let card_id = "card_id"
    
    static let rating = "rating"
    
    static let review = "review"
    
   
    static let cvv = "cvv"
    static let customer_name = "customer_name"
    
    static let device_token = "device_token"
    static let device_type = "device_type"
    static let user_type = "user_type"
    
    static let latitude = "latitude"
    static let longitude = "longitude"
    
}

struct Webservice {
	
	static let addOneSignalId = Server.live + "add_signal_id"
    
    static let login = Server.live + "authenticate"
    static let register = Server.live + "user-registration"
    
    static let userinfo = Server.live + "userinfo"
    
    static let userinfo_edit = Server.live + "userinfo-edit"
    
    static let provider_list_by_service_location = Server.live + "provider-list-by-service-location"
    
    static let user_fb_login = Server.live + "user-fb-login"
    
    static let user_google_login = Server.live + "user-google-login"
    
    
    
    
    static let address_book_list = Server.live + "address-book-list"
    
    static let add_address_book = Server.live + "add-address-book"
    
    static let edit_address_book = Server.live + "edit-address-book"
    
    static let lanscaper_details = Server.live + "lanscaper-details"
    
    static let view_service = Server.live + "view-service"
    
    static let booking_history = Server.live + "booking-history"
    
    static let confirm_booking = Server.live + "confirm-booking"
    
    static let booking_history_details = Server.live + "booking-history-details"
    
    static let view_favorite_list = Server.live + "view-favorite-list"
    
    static let static_image = Server.live2 + "uploads/services/7692_1518190108_feature-image-big.jpg"
    
    static let add_favorite = Server.live + "add-favorite"
    
    static let remove_favorite = Server.live + "remove-favorite"
    
    static let delete_card = Server.live + "delete-card"
    
    static let give_rate_review = Server.live + "give-rate-review"
    
    static let pay_using_card = Server.live + "pay-using-card"
    
    static let admin_paypal_details = Server.live + "admin-paypal-details"
    
    static let landscaper_paypal_details = Server.live + "landscaper-paypal-details"
    
    static let notification_list_user = Server.live + "notification-list-user"
    
    
    static let serviceList = Server.live + "service-list"
    
    
    
    static let subscribe = Server.live + "subscribe"
      static let notification = Server.live + "get-notification-status"
   // get-notification-status
    static let user_chat_list = Server.live + "user-chat-list"
    
    static let emailCheck = Server.live + "emailCheck"
    
    static let otpCheck = Server.live + "otpCheck"
    
    static let new_password = Server.live + "new-password"
    
    
    
    static let forgotPassword = Server.live + "user/forget_password"
    static let countries = Server.live + "user/countries"
    static let emailAvailability = Server.live + "user/email_used"
    static let validateSessionKey = Server.live + "user/check_session"
    static let resendCode = Server.live + "user/resend_code"
    
    static func verifyCode(code: String) -> String {
        return Server.live + "user/verify_code/" + code
    }
    
    static func getLeagues(sessionKey: String) -> String {
        return Server.live + "soccer/get_leagues/" + sessionKey
    }
    
    static let setSoccerPreference = Server.live + "user/preference/set_soccer_preference"
	
    static let deleteSoccerPrefernce = Server.live + "user/preference/delete_soccer_preference"
    
    static func getUserTeams(sessionKey: String, leagueId: String, page: String) -> String {
        return Server.live + "soccer/get_user_teams/" + sessionKey + "/" + leagueId + "/" + page
    }
    
    static func getTeams(sessionKey: String, leagueId: String) -> String {
        return Server.live + "soccer/get_teams/" + leagueId + "/" + sessionKey
    }
    
    static func selectChampion(sessionKey: String) -> String {
        return Server.live + "soccer/user_predik_league_winner/" + sessionKey
    }
    
    static func getPreferredLeagues(sessionKey: String) -> String {
        return Server.live + "soccer/get_preference_leagues/" + sessionKey
    }
    
    static let setNewsPreference = Server.live + "user/preference/set_news_preference"
	
	static func getNewsPreference(sessionKey: String, leagueId: String) -> String {
		return Server.live + "user/preference/get_news_preference/" + sessionKey + "/" + leagueId
	}

    static func getUserNews(sessionKey: String, page: String, count: String) -> String {
        return Server.live + "news/sports/get_user_news/" + sessionKey + "/" + page + "/" + count
    }
	
    static func getProfile(sessionKey: String) -> String {
        return Server.live + "user/profile/" + sessionKey
    }
    
    static let contact = Server.live + "contact"
    
    static func feedback(sessionKey: String) -> String {
        return Server.live + "feedback/" + sessionKey
    }
    
    static let privacyPolicy = Server.live + "get_page/Privacy_policy"
    
    static func updateProfilePicture(sessionKey: String) -> String {
        return Server.live + "user/change_picture/" + sessionKey
    }
    
    static func setUserPrediktWinLoss(sessionKey: String) -> String {
        return Server.live + "soccer/user_predik_win_loose/" + sessionKey
    }
    
    static func updateUserProfile(sessionKey: String) -> String {
        return Server.live + "user/profile_update/" + sessionKey
    }
    
    static func changePassword(sessionKey: String) -> String {
        return Server.live + "user/change_password/" + sessionKey
    }
    
    static func getToken(leagueId: String) -> String {
        return Server.live + "get_token/" + leagueId
    }
	
	static func hasPredikted(sessionKey: String) -> String {
		return Server.live + "soccer/has_predikted/" + sessionKey
	}
	
	static func getWeeklyMatches(sessionKey: String, leagueId: String, matchDay: String) -> String {
		return Server.live + "soccer/get_all_matches_by_week/" + sessionKey + "/" + leagueId + "/" + matchDay
	}
	
	static let setMultiSoccerPreference = Server.live + "user/preference/set_multi_soccer_preference"
	
	//	MARK: - Friends
	static func getSearchFriends(sessionKey: String, searchString: String) -> String {
		return Server.live + "friends/search/" + sessionKey + "/" + searchString
	}
	
    static func existingSearchFriends(page: String, count: String) -> String {
        return Server.live + "friends/search_friend/" + page + "/" + count
    }
    
	static func getSentFriends(sessionKey: String) -> String {
		return Server.live + "friends/sent_request/" + sessionKey
	}
	
	static func getReceivedFriends(sessionKey: String) -> String {
		return Server.live + "friends/received_request/" + sessionKey
	}
	
	static func getFriends(sessionKey: String) -> String {
		return Server.live + "friends/friends/" + sessionKey
	}
	
	static func addFriend(sessionKey: String, friendId: String) -> String {
		return Server.live + "friends/add_friend/" + sessionKey + "/" + friendId
	}
	
	static func confirmFriend(sessionKey: String, friendId: String) -> String {
		return Server.live + "friends/confirm_request/" + sessionKey + "/" + friendId
	}
	
	static func removeFriend(sessionKey: String, friendId: String) -> String {
		return Server.live + "friends/unfriend/" + sessionKey + "/" + friendId
	}
	
	static let upcomingEvents = Server.live + "get_upcomming_events"
	
	static func notifyMe(sessionKey: String) -> String {
		return Server.live + "news/sports/setNotifyMe/" + sessionKey
	}
    
    static func getMyWins(sessionKey: String) -> String {
        return Server.live + "user/preference/get_stats/" + sessionKey
    }
	
	static func getWinsReferer(sessionKey: String) -> String {
		return Server.live + "user/preference/full_stats/" + sessionKey + "/referer"
	}
    
	static func getWinsSport(sessionKey: String, category: String, leagueId: String) -> String {
        return Server.live + "user/preference/full_stats/" + sessionKey + "/" + category + "/" + leagueId
    }
	
	static func getWinsSport(sessionKey: String, category: String) -> String {
		return Server.live + "user/preference/full_stats/" + sessionKey + "/" + category
	}
    
    static func getCurrentWeek(leagueId: String) -> String {
        return Server.live + "soccer/get_current_week/" + leagueId
    }
    
    static let getEntertainment = Server.live + "get_entertainments"
	
}

class Service: NSObject {
    
    enum ResponseType {
		
	//	case addOneSignalId
        case login
        case register
//        case forgotPassword
//        case countries
//        case emailAvailability
//        case validateSessionKey
//        case verifyCode
//        case resendCode
//        case leagues
//        case setSoccerPreference
//        case deleteSoccerPrefernce
//        case team
//        case selectChampion
//        case getPreferredLeagues
//        case setNewsPreference
//        case getUserNews
//        case getProfile
//        case feedback
//        case contact
//        case privacyPolicy
//        case getUserTeams
//        case setUserPrediktWinLoss
//        case updateUserProfile
//        case changePassword
//        case getToken
//        case hasPredikted
//        case getWeeklyMatches
//        case setMultiSoccerPreference
//        case getNewsPreference
//        case searchFriends
//        case existingSearchFriends
//        case sentFriends
//        case receivedFriends
//        case friends
//        case addFriend
//        case confirmFriend
//        case removeFriend
//        case upcomingEvents
//        case notifyMe
//        case getMyWins
//        case getWinsSport
//        case getCurrentWeek
//        case getEntertainment
		
    }
    
    class func request(url: String, method: HTTPMethod, parameters: Parameters?, displayLoader: Bool, loaderMessage: String?, resposneType: ResponseType, completion:@escaping (_ response: Any) -> Void) {
        
        let reachability = Reachability()
        
        if (reachability?.isReachable)! {
            
            if displayLoader {
				DispatchQueue.main.async {
					if loaderMessage == nil {
						SVProgressHUD.setDefaultStyle(.light)
						SVProgressHUD.setDefaultMaskType(.gradient)
						SVProgressHUD.show()
					} else {
						SVProgressHUD.setDefaultStyle(.light)
						SVProgressHUD.setDefaultMaskType(.gradient)
						SVProgressHUD.show(withStatus: loaderMessage)
					}
				}
            }
            
            Alamofire.request(URL(string: url)!, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
                
                SVProgressHUD.dismiss()
                
                switch response.result {
                    
                case .success(let json):
                    
                    switch resposneType {
						
			
                        
                    case .login:
                        let login = Login_data.init(object: json)
                        completion(login)
                        
                    case .register:
                        let reg = Reg_data.init(object: json)
                        completion(reg)
                    
						
                   
                    }
                    break
					
                case .failure(let error):
					
					if error.localizedDescription != "cancelled" {
						showError(with: error.localizedDescription)
					}
					
                    print("Webservice Error - \(error.localizedDescription)")
					print("URL - \(url)")
                    
                    break
                }
            })
            
        } else {
            print("Internet connection not available")
			showInfo(with: "Internet connection not available")
        }
    }
	
	class func cancelRequests() {
		Alamofire.SessionManager.default.session.getAllTasks(completionHandler: { (task) in
			task.forEach { $0.cancel() }
		})
	}
	
}

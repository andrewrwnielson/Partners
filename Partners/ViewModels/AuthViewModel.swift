////
////  AuthViewModel.swift
////  Partners
////
////  Created by Andrew Nielson on 8/16/24.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//import FirebaseAuth
//import Combine
//
//protocol AuthenticationFormProtocol {
//    var formIsValid: Bool { get }
//}
//
//@MainActor
//class AuthViewModel: ObservableObject {
//    @Published var userSession: FirebaseAuth.User?
//    @Published var currentUser: User? {
//        didSet {
//            objectWillChange.send() // Notify views when currentUser changes
//        }
//    }
//    @Published var isNewUser: Bool = false
//    @Published var isLoading: Bool = false
//    
//    init() {
//        self.userSession = Auth.auth().currentUser
//        print("DEBUG: User session initialized: \(self.userSession != nil)")
//        
//        if self.userSession != nil {
//            Task {
//                await fetchUser()
//            }
//        }
//    }
//    
//    func signIn(withEmail email: String, password: String) async {
//        isLoading = true
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchUser()
//        } catch let error as NSError {
//            handleAuthError(error)
//        }
//        isLoading = false
//    }
//    
//    func createUser(withEmail email: String, password: String, fullname: String) async {
//        isLoading = true
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            self.userSession = result.user
//            let user = User(
//                id: result.user.uid,
//                fullname: fullname,
//                email: email,
//                subscription: 0,
//                swipes: 10
//            )
//            let encodedUser = try Firestore.Encoder().encode(user)
//            try await Firestore.firestore().collection("users").document(user.id!).setData(encodedUser)
//            await fetchUser()
//            isNewUser = true
//        } catch let error as NSError {
//            handleAuthError(error)
//        }
//        isLoading = false
//    }
//    
//    func fetchUser() async {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("DEBUG: No user is currently logged in.")
//            return
//        }
//        do {
//            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
//            if snapshot.exists {
//                self.currentUser = try snapshot.data(as: User.self)
//                print("DEBUG: Current user fetched")
//            } else {
//                print("DEBUG: User document does not exist.")
//                try Auth.auth().signOut()
//                DispatchQueue.main.async {
//                    self.userSession = nil
//                    self.currentUser = nil
//                    self.isNewUser = false
//                }
//            }
//        } catch {
//            print("DEBUG: Failed to fetch user data: \(error.localizedDescription)") // user is corrupt
//            await deleteAccount()
//        }
//    }
//}

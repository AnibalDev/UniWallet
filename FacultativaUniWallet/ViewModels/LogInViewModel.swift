//
//  LogInViewModel.swift
//  FacultativaUniWallet
//
//  Created by Anibal Rodriguez on 31/5/24.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class LogInViewModel: Identifiable, ObservableObject {
//
//    let db = Firestore.firestore()
//
////
////
////
//    func readAll(collection: String) async {
//        do {
//          let snapshot = try await db.collection(collection).getDocuments()
////          for document in snapshot.documents {
////            print("\(document.documentID) => \(document.data())")
////          }
//        } catch {
//          print("Error getting documents: \(error)")
//        }
//
//
//    }
//
//    func insert(data: [String:Any], collection: String) async {
//        do {
//          let ref = try await db.collection(collection).addDocument(data: data)
//          print("Document added with ID: \(ref.documentID)")
//        } catch {
//          print("Error adding document: \(error)")
//        }
//    }
//
//}

import AuthenticationServices
import FirebaseAuth
import FirebaseCore

enum AuthState {
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    private var authStateHandle: AuthStateDidChangeListenerHandle!
    
    init() {
        configureAuthStateChanges()
    }
    
    private func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            print("Auth changed: \(user != nil)")
            self.updateState(user: user)
        }
    }
        private func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
    private func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false
        
        if isAuthenticatedUser {
            self.authState = .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    func changePassword() async throws {
        if let user = Auth.auth().currentUser {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: user.email!)
            }
            catch let error as NSError {
                print("FirebaseAuthError: failed to sign out from Firebase, \(error)")
                throw error
            }
        }
    }
    func signOut() async throws {
        if let user = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
            }
            catch let error as NSError {
                print("FirebaseAuthError: failed to sign out from Firebase, \(error)")
                throw error
            }
        }
    }
    func createAccount(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            updateState(user: result.user)
            return result
        }
        catch {
            print("FirebaseAuthError: createAccount(with:) failed. \(error)")
            throw error
        }
    }
    func signIn(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            updateState(user: result.user)
            return result
        }
        catch {
            print("FirebaseAuthError: signIn(with:) failed. \(error)")
            throw error
        }
    }
}

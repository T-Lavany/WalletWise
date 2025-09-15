


import Foundation
import UIKit


class APIHandler {
    static var shared: APIHandler = APIHandler()
    
    init() {}
    
    func getAPIValues<T:Codable>(type: T.Type, apiUrl: String, method: String, onCompletion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: apiUrl) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            onCompletion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("URL --------> \(url)")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
                onCompletion(.failure(error))
                return
            }
            print("=====\(String(data: data, encoding: .utf8) ?? "No data")")
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                onCompletion(.success(decodedData))
                print(decodedData)
            } catch {
                onCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func postAPIValues<T: Codable>(
        type: T.Type,
        apiUrl: String,
        method: String,
        formData: [String: Any], // Dictionary for form data parameters
        onCompletion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: apiUrl) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            onCompletion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       
        // Construct the form data string
        var formDataString = ""
        for (key, value) in formData {
            formDataString += "\(key)=\(value)&"
        }
        formDataString = String(formDataString.dropLast())
        
        request.httpBody = formDataString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("URL --------> \(url)")
        print("FormData --------> \(formData)")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
                onCompletion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                onCompletion(.success(decodedData))
                print(decodedData)
            } catch {
                onCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        // Use URLSession to download the image asynchronously
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check if the data is not nil and there were no errors
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    // Create a UIImage from the data
                    let image = UIImage(data: data)
                    completion(image)
                }
            } else {
                // In case of an error, return nil
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    func postAPIValuesForAddPatient<T: Codable>(
        type: T.Type,
        apiUrl: String,
        method: String,
        formData: [String: Any], // Dictionary for form data parameters
        onCompletion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: apiUrl) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            onCompletion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.uppercased()
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        for (key, value) in formData {
            if let fileData = value as? Data, key == "profilePic" {
                // Generate a unique filename using timestamp
                let timestamp = Int(Date().timeIntervalSince1970)
                let filename = "profile_\(timestamp).jpg"
                let mimeType = "image/jpeg"
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(fileData)
                body.append("\r\n".data(using: .utf8)!)
            } else if let stringValue = value as? String {
                // Append normal form fields
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(stringValue)\r\n".data(using: .utf8)!)
            }
        }

        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        print("URL --------> \(url)")
        print("FormData --------> \(formData)")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
                onCompletion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                onCompletion(.success(decodedData))
                print(decodedData)
            } catch {
                onCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func deleteRequest(apiUrl: String, usePostMethod: Bool = false, onCompletion: @escaping (Bool) -> Void) {
        guard let url = URL(string: apiUrl) else {
            print("❌ Invalid URL: \(apiUrl)")
            onCompletion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = usePostMethod ? "POST" : "DELETE"

        // Add headers if required
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer YOUR_ACCESS_TOKEN", forHTTPHeaderField: "Authorization") // If auth is required

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
                onCompletion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("🔄 Response Code: \(httpResponse.statusCode)")
                
                if let responseData = data {
                    print("📩 Response Data: \(String(data: responseData, encoding: .utf8) ?? "No response body")")
                }
                
                if httpResponse.statusCode == 200 {
                    print("✅ Successfully deleted patient profile")
                    onCompletion(true)
                } else {
                    print("❌ Server error: \(httpResponse.statusCode)")
                    onCompletion(false)
                }
            } else {
                print("❌ No response from server")
                onCompletion(false)
            }
        }
        task.resume()
    }



    func postAPIValuesWithFormData<T: Codable>(
        type: T.Type,
        apiUrl: String,
        method: String,
        formData: [String: Any], // Dictionary for form data parameters
        onCompletion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: apiUrl) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            onCompletion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.uppercased()
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        for (key, value) in formData {
            if let fileData = value as? Data, key == "doctorimage" {
                // Generate a unique filename using timestamp
                let timestamp = Int(Date().timeIntervalSince1970)
                let filename = "profile_\(timestamp).jpg"
                let mimeType = "image/jpeg"
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                body.append(fileData)
                body.append("\r\n".data(using: .utf8)!)
            } else if let stringValue = value as? String {
                // Append normal form fields
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(stringValue)\r\n".data(using: .utf8)!)
            }
        }

        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        print("URL --------> \(url)")
        print("FormData --------> \(formData)")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
                onCompletion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                onCompletion(.success(decodedData))
                print(decodedData)
            } catch {
                onCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
}


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

//
//  APIHandler.swift
//  Wallet
//
//  Created by SAIL on 29/05/25.
//



import Foundation

func sendCashInRequest() {
    // URL of your PHP API
    guard let url = URL(string: "http://localhost/WalletWise/cashin.php") else {
        print("Invalid URL")
        return
    }

    // Prepare the JSON dictionary to send
    let json: [String: Any] = [
        "category": "Salary",
        "date": "2025-05-22",
        "amount": "424",
        "note": "",
        "email": "your-email@example.com"  // put actual user email here
    ]

    // Convert dictionary to JSON data
    guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {
        print("Error converting to JSON")
        return
    }

    // Prepare the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    // Create URLSession data task
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle error
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }

        // Check for valid response and data
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode),
              let data = data else {
            print("Invalid response or data")
            return
        }

        // Parse JSON response from PHP
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print("Response JSON: \(jsonResponse)")
                // You can parse jsonResponse["status"], jsonResponse["message"], etc.
            }
        } catch {
            print("Error parsing JSON response: \(error.localizedDescription)")
        }
    }

    // Start the network request
    task.resume()
}



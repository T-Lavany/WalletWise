import SwiftUI

struct HowToUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to WalletWise")
                    .font(.title)
                    .bold()
                
                Text("Thank you very much for downloading the App!")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Here's a quick walkthrough of the most important features in WalletWise:")
                        .font(.subheadline)
                    
                    FeatureRow(number: "1", text: "The Dashboard gives you an overview of your daily, weekly, and monthly spending.")
                    FeatureRow(number: "2", text: "Tap \"Add Transaction\" to record cash-in or cash-out activities instantly.")
                    FeatureRow(number: "3", text: "Use categories like Food, Travel, Shopping to track spending more effectively.")
                    FeatureRow(number: "4", text: "Set budgets per category and get alerts when you’re nearing your limit.")
                    FeatureRow(number: "5", text: "Check out your Monthly Summary to see income vs expenses.")
                    FeatureRow(number: "6", text: "Use Smart Insights to discover saving opportunities based on your spending habits.")
                    FeatureRow(number: "7", text: "In Settings, manage your account, backup data, and share your feedback with us.")
                }
            }
            .padding()
        }
    }
}

struct FeedbackView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Thanks for choosing WalletWise!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.green)
                .multilineTextAlignment(.center)
            
            Text("We hope WalletWise helps you take control of your finances with ease.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Your feedback helps us improve and deliver the best experience.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Please visit the App Settings to leave a review or share your thoughts.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Thank you for being part of the WalletWise community!")
                .font(.body)
                .italic()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .multilineTextAlignment(.center)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.2), Color.green.opacity(0.05)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

struct ContactUsView: View {
    var body: some View {
        List {
            Section(header: Text("Customer Support")) {
                ContactRow(icon: "envelope.fill", title: "Email", detail: "walletwise.help@gmail.com")
                ContactRow(icon: "phone.fill", title: "Phone", detail: "+91 7981536381")
                ContactRow(icon: "clock.fill", title: "Hours", detail: "Mon-Fri: 10AM - 7PM IST")
            }
            
            Section(header: Text("Social Media")) {
                ContactRow(icon: "camera.fill", title: "Instagram", detail: "@walletwise_app")
            }
        }
    }
}

struct LanguageSettingsView: View {
    @State private var selectedLanguage = "English"
    let languages = ["English"]
    
    var body: some View {
        Form {
            Section(header: Text("Select Language")) {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text(language)
                    }
                }
            }
            
            Section(header: Text("About Language Settings")) {
                Text("Changing the language will update the app's interface language. Some content may remain in the original language.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms of Service")
                    .font(.title)
                    .bold()
                
                Group {
                    Text("Last Updated: March 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("1. Acceptance of Terms")
                        .font(.headline)
                    Text("By using WalletWise, you agree to be bound by these Terms of Service. If you disagree with any part, please do not use the app.")
                    
                    Text("2. User Responsibilities")
                        .font(.headline)
                    Text("You're responsible for securing your account and data. Please report unauthorized access immediately.")
                    
                    Text("3. Data Entry")
                        .font(.headline)
                    Text("Ensure accuracy when entering financial data. WalletWise is not responsible for financial losses due to user errors.")
                    
                    Text("4. Subscription & Refunds")
                        .font(.headline)
                    Text("WalletWise offers free and premium features. Subscriptions are billed monthly/yearly and can be cancelled anytime.")
                    
                    Text("5. Intellectual Property")
                        .font(.headline)
                    Text("All content and designs in WalletWise are owned by us and protected under applicable laws.")
                    
                    Text("6. Termination")
                        .font(.headline)
                    Text("We may suspend or terminate access to WalletWise if users violate these terms.")
                    
                    Text("7. Limitation of Liability")
                        .font(.headline)
                    Text("WalletWise is not liable for any financial decisions made based on app usage.")
                }
            }
            .padding()
        }
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.title)
                    .bold()
                
                Group {
                    Text("Last Updated: March 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("1. Information We Collect")
                        .font(.headline)
                    Text("We collect your name, email, spending records, and preferences to personalize your experience.")
                    
                    Text("2. How We Use Your Information")
                        .font(.headline)
                    Text("Your data helps us improve insights, offer reminders, manage budgets, and secure your account.")
                    
                    Text("3. Data Sharing")
                        .font(.headline)
                    Text("We never sell your data. We only share it with trusted partners for app functionality and legal compliance.")
                    
                    Text("4. Security")
                        .font(.headline)
                    Text("WalletWise uses end-to-end encryption and secure cloud storage to protect your financial data.")
                    
                    Text("5. Your Rights")
                        .font(.headline)
                    Text("You can request access to, edit, or delete your data at any time from within the app settings.")
                    
                    Text("6. Cookies and Tracking")
                        .font(.headline)
                    Text("We use tracking tools for improving user experience. You can opt-out in settings.")
                    
                    Text("7. Children's Privacy")
                        .font(.headline)
                    Text("WalletWise is not intended for users under 13. We do not knowingly collect data from children.")
                    
                    Text("8. International Use")
                        .font(.headline)
                    Text("Your data may be processed outside your country with adequate protection measures in place.")
                    
                    Text("9. Updates to Policy")
                        .font(.headline)
                    Text("We may revise this policy and will notify users of major changes.")
                }
            }
            .padding()
        }
    }
}

struct DataUsageView: View {
    var body: some View {
        List {
            Section(header: Text("Data Collection")) {
                Text("We collect usage data to help you better understand your spending habits.")
            }
            
            Section(header: Text("Types of Data")) {
                Text("• Account Information")
                Text("• Transaction Records")
                Text("• Budget Details")
                Text("• Device Usage Data")
            }
            
            Section(header: Text("Data Protection")) {
                Text("Your data is stored securely with encryption. We never sell your personal information.")
            }
        }
    }
}

// Reused Views
struct FeatureRow: View {
    let number: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(number)
                .font(.headline)
                .foregroundColor(.green)
                .frame(width: 25)
            Text(text)
                .font(.body)
        }
    }
}

struct ContactRow: View {
    let icon: String
    let title: String
    let detail: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 25)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    NavigationView {
        HowToUseView()
    }
}

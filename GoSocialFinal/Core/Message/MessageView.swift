//
//  MessageView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Combine

struct MessageView: View {
    
    @State var chatMessages: [ChatMessage] = []
    @State var messageText: String = ""
    @State var cancellables = Set<AnyCancellable>()
    
    let openAIService = OpenAIService()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatMessages, id:\.id) { messages in
                        messageView(message: messages)
                        
                    }
                }
            }
            
            HStack {
                TextField("Enter Query...", text: $messageText)  {
                    
                }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        
    }
    
    func messageView(message: ChatMessage) -> some View {
        HStack {
                if message.sender == .me {
                    Spacer()
                }
                Text(message.content)
                    .foregroundColor(message.sender == .me ? .white : .black)
                    .padding()
                    .background(message.sender == .me ? .blue : .gray.opacity(0.1))
                    .cornerRadius(16)
                if message.sender == .gpt && message.content != "" {
                    Spacer()
                }
            }
    }
    
    func sendMessage() {
        
        let myMessage = ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .me)
        
        chatMessages.append(myMessage)
        
        openAIService.sendMessage(message: messageText).sink { completion in
                //Handle error
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text else {return}
            
            let gptMessage = ChatMessage(id: response.id, content: textResponse, dateCreated: Date(), sender: .gpt)
            
            chatMessages.append(gptMessage)
        }
        .store(in: &cancellables)

        messageText = ""
    }
}

//struct chatbotView_Previews: PreviewProvider {
//    static var previews: some View {
//        chatbotView()
//    }
//}

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}
